/* eslint-env node */
'use strict';

// Ce module nodejs gère l'API de notre site
// Il définit l'ensemble des routes (relative à "/api") corresponant aux
// points d'entrée de l'API

// Expressjs
const express = require('express');
const path = require('path');
const dbHelper = require('./dbhelper');
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


// Comme c'est un module nodejs il faut exporter les fonctions qu'on veut rendre publiques
// ici on n'exporte qu'une seule fonction (anonyme) qui est le "constructeur" du module
// Cette fonction prend en paramètre un objet "passport" pour la gestion de l'authentification
module.exports = (passport) => {
    const app = express();
    app.use(express.json());
    app.use(express.urlencoded());
    app.use(express.static('public'));
    app.use('/uploads', express.static('uploads'));

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

    return app;
};





