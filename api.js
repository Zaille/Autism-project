/* eslint-env node */
'use strict';

// Ce module nodejs gère l'API de notre site
// Il définit l'ensemble des routes (relative à "/api") corresponant aux
// points d'entrée de l'API

// Expressjs
const express = require('express');
const formidable = require('formidable');
const path = require('path');
const dbHelper = require('./dbhelper.js');
const passwordHash = require('password-hash');
// https://github.com/validatorjs/validator.js#validators pour plus de check
const { body, param, validationResult } = require('express-validator');

////////////////////////////////////////////
// Middle ware de gestion de droit
////////////////////////////////////////////

const requireEtudiantOnly = (url) => {
    return function (req, res, next) {
        // ce middleware arrive toujours après le login.active
        // Nous somme donc log avec une session valide

        if (req.session.passport.user.type !== 3) {
            return res.redirect(url || '/login');
        }
        next();
    };
};

const requireProfesseurOnly = (url) => {
    return function (req, res, next) {
        // ce middleware arrive toujours après le login.active
        // Nous somme donc log avec une session valide

        if (req.session.passport.user.type !== 2) {
            return res.redirect(url || '/login');
        }
        next();
    };
};

const requireAdminOnly = function (url) {
    return function (req, res, next) {
        // ce middleware arrive toujours après le login.active
        // Nous somme donc log avec une session valide

        if (req.session.passport.user.type !== 1) {
            return res.redirect(url || '/login');
        }
        next();
    };
};


// Comme c'est un module nodejs il faut exporter les fonction qu'on veut rendre publiques
// ici on n'exporte qu'ne seule fonction (anonyme) qui est le "constructeur" du module
// Cette fonction prend en paramètre un objet "passport" pour la gestion de l'authentification
module.exports = (passport) => {
    const app = express();
    app.use(express.json());
    app.use(express.urlencoded());
    app.use(express.static('public'));
    app.use('/uploads', express.static('uploads'));

    //////////////////////
    // Routes Participe Evenement
    //////////////////////

    app.get('/participe_evenement/:id_evenement',
        [require('connect-ensure-login').ensureLoggedIn()],
        function (req, res) {
            dbHelper.participe_evenement.byEventId(req.params.id_evenement)
                .then((rows) => res.json(rows.result)).catch((err) => res.status(400).json({ err }));
        });

    app.post('/participe_evenement',
        [require('connect-ensure-login').ensureLoggedIn(),
        body('id_etu', 'Etudiant invalide').exists().isInt({ min: 1, max: 99999999999 }),
        body('id_evenement', 'Evenement invalide').exists().isInt({ min: 1, max: 99999999999 }),
        requireEtudiantOnly(),
        ],
        function (req, res) {

            const errors = validationResult(req);
            if (!errors.isEmpty()) {
                return res.status(422).json(errors.array());
            }

            if ('' + req.body.id_etu === '' + req.session.passport.user.id_etu) {
                // si user qui veut inscrire est bien l'user connecté
                // check si suffisement de place
                dbHelper.evenement.byEventId(req.body.id_evenement).then((event_info) => {
                    if (event_info.result.length === 0) {
                        // l'event existe pas
                        throw { err: 'Evenement invalide' };
                    }

                    const max_place = event_info.result[0].places;
                    dbHelper.evenement.getPlaceCount(req.body.id_evenement).then((nb_place) => {
                        const nb_place_actuel = max_place - nb_place.result[0].nbplaceused;
                        if (nb_place_actuel > 0) {
                            dbHelper.participe_evenement.add(
                                req.body.id_etu,
                                req.body.id_evenement,
                                0).then(() => res.end())
                                .catch((err) => res.status(400).json({ err }));
                        }
                        else {
                            throw { err: 'Inscription invalide' };
                        }
                    }).catch((err) => res.status(400).json({ err }));
                }).catch((err) => res.status(400).json({ err }));
            }
            else {
                return res.status(400).end();
            }
        });


    //////////////////////
    // Routes Evenements
    //////////////////////

    app.get('/evenements',
        [require('connect-ensure-login').ensureLoggedIn()],
        function (req, res) {
            dbHelper.evenement.all()
                .then((rows) => res.json(rows.result))
                .catch((err) => res.status(400).json({ err }));
        });

    app.get('/evenements/:event_id',
        [require('connect-ensure-login').ensureLoggedIn(),
        param('event_id').exists().isInt({ min: 1, max: 99999999999 })],
        function (req, res) {

            const errors = validationResult(req);
            if (!errors.isEmpty()) {
                return res.status(422).json(errors.array());
            }

            dbHelper.evenement.byEventId(req.params.event_id)
                .then((rows) => res.json(rows.result))
                .catch((err) => res.status(400).json({ err }));
        });

    app.get('/evenements/participe/:etu_id',
        [require('connect-ensure-login').ensureLoggedIn(),
        requireEtudiantOnly()],
        function (req, res) {
            dbHelper.evenement.participeByEtuId(req.params.etu_id)
                .then((rows) => res.json(rows.result))
                .catch((err) => res.status(400).json({ err }));
        });

    app.get('/evenements/termines/:etu_id',
        [require('connect-ensure-login').ensureLoggedIn()],
        function (req, res) {
            dbHelper.evenement.terminesByEtuId(req.params.etu_id)
                .then((rows) => res.json(rows.result))
                .catch((err) => res.status(400).json({ err }));

        });

    app.get('/evenements/organises/:etu_id',
        [require('connect-ensure-login').ensureLoggedIn(),
        requireEtudiantOnly()],
        function (req, res) {
            dbHelper.evenement.organisesByUserId(req.params.etu_id)
                .then((rows) => res.json(rows.result))
                .catch((err) => res.status(400).json({ err }));

        });

    app.get('/evenements/liste_participants_attente_points/:event_id',
        [require('connect-ensure-login').ensureLoggedIn()],
        function (req, res) {
            dbHelper.participe_evenement.allPendingEtu(req.params.event_id)
                .then((rows) => res.json(rows.result))
                .catch((err) => res.status(400).json({ err }));
        });

    app.post('/evenements',
        [require('connect-ensure-login').ensureLoggedIn(),
        body('id_responsable', 'Responsable invalide').exists().isInt({ min: 1, max: 99999999999 }),
        body('titre', 'Titre invalide').exists().isLength({ min: 2, max: 100 }),
        // body('image', 'Image invalide').exists().isLength({ min: 6, max: 100 }),
        body('description', 'Description invalide').exists().isLength({ min: 2, max: 800 }),
        body('date_d', 'Date de debut invalide').exists().isISO8601(),
        body('date_f', 'Date de fin invalide').exists().isISO8601(),
        body('lieu', 'Lieu invalide').exists().isLength({ min: 2, max: 100 }),
        body('polypoints', 'Nb de polypoint invalide').exists().isInt({ min: 1, max: 100 }),
        body('places', 'Nb de place invalide').exists().isInt({ min: 1, max: 99999999999 }),
        requireAdminOnly(),
        ],
        function (req, res) {

            const errors = validationResult(req);
            if (!errors.isEmpty()) {
                return res.status(422).json(errors.array());
            }

            dbHelper.evenement.add(
                req.body.id_responsable,
                req.body.titre,
                req.body.image || '/public/images/no_image.svg',
                req.body.description,
                req.body.date_d,
                req.body.date_f,
                req.body.lieu,
                req.body.polypoints,
                req.body.places,
            ).then(() => res.end()).catch((err) => res.status(400).json({ err }));
        });

    app.post('/evenements/image',
        [require('connect-ensure-login').ensureLoggedIn(),
        requireAdminOnly()],
        function (req, res) {
            /*
             TODO chech taille maximale
             TODO chech type du fichier (profondement pas juste l'extension)
             */
            let form = new formidable.IncomingForm();
            form.keepExtensions = true;

            // Dossier de téléchargement
            form.uploadDir = path.join(__dirname, '/private/images/');

            form.parse(req, function (err, fields, files) {
                let fileName = files.file.path.replace(/^.+(\/upload_.+)$/, '$1');
                let filePath = '/private/images' + fileName;
                res.send(filePath); // permet de recuperer le chemin + nom du fichier (aleatoire generé par parse) et l'envoyer au .main
            });
        });

    // tentative de suppression impliquant des failles de sécurité
    // app.delete('/evenements/image',
    //     [require('connect-ensure-login').ensureLoggedIn(),
    //     requireAdminOnly()],
    //     function (req, res) {
    //         workingDirectory.getFile("todo", {}, function(fileEntry) {
    //             fileEntry.remove(function() {
    //               /* the file was removed successfully */
    //             });
    //           }, handleError);
    //     });

    app.get('/evenements/place/:id_evenement',
        [require('connect-ensure-login').ensureLoggedIn(),
        param('id_evenement', 'Evenement invalide').exists().isInt({ min: 1, max: 99999999999 })],
        function (req, res) {

            const errors = validationResult(req);
            if (!errors.isEmpty()) {
                return res.status(422).json(errors.array());
            }

            dbHelper.evenement.getPlaceCount(req.params.id_evenement)
                .then((rows) => {
                    res.json(rows.result);
                }).catch((err) => res.status(400).json({ err }));
        });

    app.patch('/evenements/verifier_participation/:id_evenement',
        [require('connect-ensure-login').ensureLoggedIn(),
        param('id_evenement', 'Evenement invalide').exists().isInt({ min: 1, max: 99999999999 }),
        body('id_etu', 'Etudiant invalide').exists().isInt({ min: 1, max: 99999999999 }),
        body('etat', 'Etat invalide').exists().isInt({ min: 1, max: 2 }),
        requireEtudiantOnly()],
        function (req, res) {

            const errors = validationResult(req);
            if (!errors.isEmpty()) {
                return res.status(422).json(errors.array());
            }

            dbHelper.evenement.byEventId(req.params.id_evenement).then((data) => {
                if (data.result.length === 1 && data.result[0].id_responsable === req.session.passport.user.id_etu) {
                    // vérification que l'etu qui requete est bien le responsable
                    dbHelper.participe_evenement.setParticipation(
                        req.body.etat,
                        req.body.id_etu,
                        req.params.id_evenement)
                        .then(() => res.end())
                        .catch((err) => res.status(400).json({ err }));
                }
            }).catch((err) => res.status(400).json({ err }));
        });

    //////////////////////
    // Routes activite
    //////////////////////

    app.get('/activite',
        [require('connect-ensure-login').ensureLoggedIn()],
        function (req, res) {
            dbHelper.activite.all()
                .then((rows) => res.json(rows.result)).catch((err) => res.status(400).json({ err }));
        });

    app.post('/activite',
        [require('connect-ensure-login').ensureLoggedIn(),
        body('id_etu', 'Etudiant invalide').exists().isInt({ min: 1, max: 99999999999 }),
        body('rapport_pdf', 'Type invalide').exists().isLength({ min: 0, max: 255 }),
        body('date', 'Type invalide').exists().isISO8601(),
        body('sujet', 'Sujet invalide').exists().isLength({ min: 2, max: 100 }),
        body('points', 'Nb de point invalide').exists().isFloat(),
        requireProfesseurOnly()], // only prof mais discutable
        function (req, res) {

            const errors = validationResult(req);
            if (!errors.isEmpty()) {
                return res.status(422).json(errors.array());
            }

            dbHelper.activite.add(
                req.body.id_etu,
                req.body.rapport_pdf,
                req.body.date,
                req.body.sujet,
                req.body.points)
                .then(() => res.end())
                .catch((err) => res.status(400).json({ err }));
        });

    app.get('/activite/by_id/:sujet',
        [require('connect-ensure-login').ensureLoggedIn()],
        function (req, res) {
            dbHelper.activite.bySubject(req.params.sujet)
                .then((rows) => res.json(rows.result)).catch((err) => res.status(400).json({ err }));
        });

    app.post('/activite/file',
        [require('connect-ensure-login').ensureLoggedIn(),
        requireProfesseurOnly()],
        function (req, res) {


            // TODO chech taille maximale
            // TODO chech type du fichier (profondement pas juste l'extension)

            let form = new formidable.IncomingForm();

            form.keepExtensions = true;

            // Dossier de téléchargement
            form.uploadDir = path.join(__dirname, '/private/rapport/');

            form.parse(req, function (err, fields, files) {
                let fileName = files.file.path.replace(/^.+(\/upload_.+)$/, '$1');
                let filePath = '/private/rapport' + fileName;
                res.send(filePath); // permet de recuperer le chemin + nom du fichier (aleatoire generé par parse) et l'envoyer au .main
            });


        });

    //////////////////////
    // Routes Bonification points
    //////////////////////

    app.get('/bonification/:id_user',
        [require('connect-ensure-login').ensureLoggedIn()],
        function (req, res) {
            dbHelper.activite.byEtuId(req.params.id_user)
                .then((rows) => res.json(rows.result)).catch((err) => res.status(400).json({ err }));
        });

    //////////////////////
    // Route etudiant
    //////////////////////

    app.get('/etudiant/list',
        [require('connect-ensure-login').ensureLoggedIn()],
        function (req, res) {
            dbHelper.etudiant.list()
                .then((rows) => res.json(rows.result)).catch((err) => res.status(400).json({ err }));
        });

    app.get('/etudiant',
        [require('connect-ensure-login').ensureLoggedIn()],
        function (req, res) {
            dbHelper.etudiant.all()
                .then((rows) => res.json(rows.result)).catch((err) => res.status(400).json({ err }));
        });

    // app.get('/etudiant/user_id/:id',
    //     [require('connect-ensure-login').ensureLoggedIn()],
    //     function (req, res) {
    //         dbHelper.etudiant.byUserId(req.params.id)
    //             .then((rows) => res.json(rows.result));
    //     });

    app.get('/etudiant/:id_etu',
        [require('connect-ensure-login').ensureLoggedIn()],
        function (req, res) {
            dbHelper.etudiant.byId(req.params.id_etu)
                .then((rows) => res.json(rows.result)).catch((err) => res.status(400).json({ err }));
        });

    app.post('/etudiant',
        [require('connect-ensure-login').ensureLoggedIn(),
        body('username', 'Nom d\'utilisateur invalide').exists().isLength({ min: 6, max: 100 }),
        body('password', 'Mot de passe invalide').exists().isLength({ min: 6, max: 100 }),
        body('id_promotion', 'Promotion invalide').exists().isInt({ min: 1, max: 99999999999 }),
        body('num_etu', 'Numéro etudiant invalide').exists().isLength({ min: 6, max: 10 }),
        body('nom', 'Nom invalide').exists().isLength({ min: 2, max: 100 }),
        body('prenom', 'Prenom invalide').exists().isLength({ min: 2, max: 100 }),
        requireAdminOnly()],
        function (req, res) {

            const errors = validationResult(req);
            if (!errors.isEmpty()) {
                return res.status(422).json(errors.array());
            }

            dbHelper.etudiant.add(req.body.username,
                passwordHash.generate(req.body.password),
                req.body.id_promotion,
                req.body.num_etu,
                req.body.nom,
                req.body.prenom)
                .then(() => {
                    res.end();
                }).catch((err) => res.status(400).json({ err }));
        });

    app.delete('/etudiant/:id_etu',
        [require('connect-ensure-login').ensureLoggedIn(),
        param('id_etu', 'Etudiant invalide').exists().isInt({ min: 1, max: 99999999999 }),
        requireAdminOnly()],
        function (req, res) {

            const errors = validationResult(req);
            if (!errors.isEmpty()) {

                return res.status(422).json(errors.array());
            }

            dbHelper.etudiant.remove(req.params.id_etu)
                .then(() => res.end()).catch((err) => res.status(400).json({ err }));
        });

    app.patch('/etudiant/:id_etu',
        [require('connect-ensure-login').ensureLoggedIn(),
        param('id_etu', 'Etudiant invalide').exists().isInt({ min: 1, max: 99999999999 }),
        body('id_promotion', 'Promotion invalide').exists().isInt({ min: 1, max: 99999999999 }),
        body('num_etu', 'Numéro etudiant invalide').exists().isLength({ min: 6, max: 10 }),
        body('nom', 'Nom invalide').exists().isLength({ min: 2, max: 100 }),
        body('prenom', 'Prenom invalide').exists().isLength({ min: 2, max: 100 }),
        requireAdminOnly()],
        function (req, res) {

            const errors = validationResult(req);
            if (!errors.isEmpty()) {
                return res.status(422).json(errors.array());
            }

            dbHelper.etudiant.rename(req.params.id_etu,
                req.body.id_promotion,
                req.body.num_etu,
                req.body.nom,
                req.body.prenom)
                .then(() => res.end()).catch((err) => res.status(400).json({ err }));
        });

    //////////////////////
    // Route professeur
    //////////////////////

    app.get('/professeur/',
        [require('connect-ensure-login').ensureLoggedIn()],
        function (req, res) {
            dbHelper.professeur.all()
                .then((rows) => res.json(rows.result));
        });

    app.get('/professeur/:prof_id',
        [require('connect-ensure-login').ensureLoggedIn()],
        function (req, res) {
            dbHelper.professeur.byId(req.params.prof_id)
                .then((rows) => res.json(rows.result));
        });

    app.patch('/professeur/:id',
        [require('connect-ensure-login').ensureLoggedIn(),
        param('id', 'Professeur invalide').exists().isInt({ min: 1, max: 99999999999 }),
        body('num_prof', 'Numero professeur invalide').exists().isLength({ min: 6, max: 10 }),
        body('prenom', 'Prenom invalide').exists().isLength({ min: 2, max: 100 }),
        body('nom', 'Nom invalide').exists().isLength({ min: 2, max: 100 }),
        requireAdminOnly()],
        function (req, res) {

            const errors = validationResult(req);
            if (!errors.isEmpty()) {
                return res.status(422).json(errors.array());
            }

            dbHelper.professeur.rename(
                req.params.id,
                req.body.num_prof,
                req.body.nom,
                req.body.prenom)
                .then(() => res.end()).catch((err) => res.status(400).json({ err }));
        });

    app.post('/professeur',
        [require('connect-ensure-login').ensureLoggedIn(),
        body('username', 'Nom d\'utilisateur invalide').exists().isLength({ min: 6, max: 100 }),
        body('password', 'Mot de passe invalide').exists().isLength({ min: 6, max: 100 }),
        body('num_prof', 'Numéro professeur invalide').exists().isLength({ min: 6, max: 10 }),
        body('nom', 'Nom invalide').exists().isLength({ min: 2, max: 100 }),
        body('prenom', 'Prenom invalide').exists().isLength({ min: 2, max: 100 }),
        requireAdminOnly()],
        function (req, res) {

            const errors = validationResult(req);
            if (!errors.isEmpty()) {
                return res.status(422).json(errors.array());
            }

            dbHelper.professeur.add(req.body.username,
                passwordHash.generate(req.body.password),
                req.body.num_prof,
                req.body.nom,
                req.body.prenom)
                .then(() => {
                    res.end();
                }).catch((err) => res.status(400).json({ err }));
        });

    //////////////////////
    // Route promotion
    //////////////////////

    app.get('/promotion',
        [require('connect-ensure-login').ensureLoggedIn(),
        requireAdminOnly()],
        function (req, res) {
            dbHelper.promotion.all()
                .then((rows) => res.json(rows.result)).catch((err) => res.status(400).json({ err }));
        });

    app.get('/promotion/:promo_id',
        [require('connect-ensure-login').ensureLoggedIn(),
        requireAdminOnly()],
        function (req, res) {
            dbHelper.promotion.byId(req.params.promo_id)
                .then((rows) => res.json(rows.result));
        });

    app.post('/promotion',
        [require('connect-ensure-login').ensureLoggedIn(),
        body('id_departement', 'Département invalide').exists().isInt({ min: 1, max: 99999999999 }),
        body('annee', 'Date invalide').exists().isISO8601(),
        body('option', 'Option invalide').exists().isLength({ min: 2, max: 255 }),
        requireAdminOnly()],
        function (req, res) {

            const errors = validationResult(req);
            if (!errors.isEmpty()) {
                return res.status(422).json(errors.array());
            }

            dbHelper.promotion.add(req.body.id_departement,
                req.body.annee,
                req.body.option)
                .then(() => {
                    res.end();
                }).catch((err) => res.status(400).json({ err }));
        });

    app.delete('/promotion/:id',
        [require('connect-ensure-login').ensureLoggedIn(),
        body('id', 'Promotion invalide').exists().isInt({ min: 1, max: 99999999999 }),
        requireAdminOnly()],
        function (req, res) {

            const errors = validationResult(req);
            if (!errors.isEmpty()) {
                return res.status(422).json(errors.array());
            }

            dbHelper.promotion.remove(req.params.id)
                .then(() => res.end()).catch((err) => res.status(400).json({ err }));
        });

    app.patch('/promotion/:id',
        [require('connect-ensure-login').ensureLoggedIn(),
        param('id', 'Promotion invalide').exists().isInt({ min: 1, max: 99999999999 }),
        body('id_departement', 'Departement invalide').exists().isInt({ min: 1, max: 99999999999 }),
        body('date', 'Date invalide').exists().isISO8601(),
        body('option', 'Option invalide').exists().isLength({ min: 2, max: 255 }),
        requireAdminOnly()],
        function (req, res) {

            const errors = validationResult(req);
            if (!errors.isEmpty()) {
                return res.status(422).json(errors.array());
            }

            dbHelper.promotion.rename(req.params.id,
                req.body.id_departement,
                req.body.date,
                req.body.option)
                .then(() => res.end()).catch((err) => res.status(400).json({ err }));
        });

    //////////////////////
    // Route departement
    //////////////////////

    app.get('/departement',
        [require('connect-ensure-login').ensureLoggedIn(),
        requireAdminOnly()],
        function (req, res) {

            dbHelper.departement.all()
                .then((rows) => res.json(rows.result)).catch((err) => res.status(400).json({ err }));
        });

    app.get('/departement/:dpt_id',
        [require('connect-ensure-login').ensureLoggedIn(),
        requireAdminOnly()],
        function (req, res) {
            dbHelper.departement.byId(req.params.dpt_id)
                .then((rows) => res.json(rows.result));
        });

    app.post('/departement',
        [require('connect-ensure-login').ensureLoggedIn(),
        body('nom', 'Nom invalide').exists().isLength({ min: 2, max: 100 }),
        requireAdminOnly()],
        function (req, res) {

            const errors = validationResult(req);
            if (!errors.isEmpty()) {
                return res.status(422).json(errors.array());
            }

            dbHelper.departement.add(req.body.nom)
                .then(() => {
                    res.end();
                }).catch((err) => res.status(400).json({ err }));
        });

    app.delete('/departement/:id',
        [require('connect-ensure-login').ensureLoggedIn(),
        param('id', 'Departemenr invalide').exists().isInt({ min: 1, max: 99999999999 }),
        requireAdminOnly()],
        function (req, res) {

            const errors = validationResult(req);
            if (!errors.isEmpty()) {
                return res.status(422).json(errors.array());
            }

            dbHelper.departement.remove(req.params.id)
                .then(() => res.end()).catch((err) => res.status(400).json({ err }));
        });

    app.patch('/departement/:id',
        [require('connect-ensure-login').ensureLoggedIn(),
        param('id', 'Departement invalide').exists().isInt({ min: 1, max: 99999999999 }),
        body('nom', 'Nom invalide').exists().isLength({ min: 2, max: 100 }),
        requireAdminOnly()],
        function (req, res) {

            const errors = validationResult(req);
            if (!errors.isEmpty()) {
                return res.status(422).json(errors.array());
            }

            dbHelper.departement.rename(
                req.params.id,
                req.body.nom)
                .then(() => res.end()).catch((err) => res.status(400).json({ err }));
        });

    //////////////////////
    // Route Profil / login
    //////////////////////

    // Authentification pour accéder aux parties privées de l'api (on n'en a pas dans cet exemple)
    // et aux templates privés
    // C'est ici qu'on utilise passport pour créer une session utilisateur
    app.post('/login',
        // les validator sont trop contraignant. Nous préférons les utiliser seulement lors de l'ajout d'user
        // [body('username', 'Nom d\'utilisateur invalide').exists().isLength({ min: 6, max: 100 }),
        // body('password', 'Mot de passe invalide').exists().isLength({ min: 6, max: 100 }),
        // ],
        function (req, res, next) {
            if (!req.body.username) {
                return res.send({ success: false, message: 'Saisissez un nom d\'utilisateur' });
            }
            if (!req.body.password) {
                return res.send({ success: false, message: 'Saisissez un mot de passe' });
            }
            passport.authenticate('local', function (err, user) {
                if (err) {
                    return next(err); // will generate a 500 error
                }
                if (!user) {
                    return res.send({ succes: false, message: 'Authentification échouée' });
                }
                req.login(user, function (err) {
                    if (err) {
                        return next(err);
                    }
                    return res.send({ success: true, message: 'Authentification reussite', ...req.session.passport.user });
                });
            })(req, res, next);
        });

    app.get('/session', function (req, res) {

        // session remplie
        if (req.session.passport && req.session.passport.user) {
            res.json({ success: true, message: 'Session récupérée', ...req.session.passport.user });
        }
        else {
            res.json({ success: false });
        }

        res.end();
    });

    //////////////////////
    // Route Aide/FAQ
    //////////////////////

    return app;
};





