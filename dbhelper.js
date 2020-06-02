/* eslint-env node */
'use strict';

// This module alows connection to a mysql/mariadb dadtabase
const mysql = require('mysql');

const dbCon = mysql.createConnection({
    host: 'localhost',
    user: 'admin',           // maybe too much privilege
    password: 'password',    // for internal testing purposes only !!
    database: 'polydb',
    multipleStatements: true, // security hole if not using prepared queries !!
});

// Connection to the database.
dbCon.connect(function (err) {
    if (err) {
        throw err;
    }
    console.log('Connected to database!');
});

// Callback function to promise
const cbToPromise = function (fn, ...args) {
    return new Promise(function (resolve, reject) {
        fn(...args, (err, res, fields) => {
            if (err) {
                /* return */
                reject(err);
            }
            else {
                /* return */
                resolve({'result': res, 'fields': fields}); // return not needed, implicit ?
            }
        });
    });
};

const prepareQuery = function (unformated_query, inserts) {
    return mysql.format(unformated_query, inserts);
};

const query = function (sql_query) {
    return cbToPromise(dbCon.query.bind(dbCon), sql_query);
};

// --------------------------------------------------------------------------

module.exports.users = {
    byUsername: (username) => query(prepareQuery(`
select 
    id, 
    password, 
    type 
from 
    user 
where 
    username = ?;`, [username])),
    byId: id => query(prepareQuery(`
select 
    username 
from 
    user 
where 
	id = ?;`, [id])),
};

module.exports.etudiant = {
    list: () => query(`
SELECT * FROM etudiant ORDER by nom;`),
    all: () => query(`
SELECT 
	etudiant.id as id_etu,
	etudiant.id_promotion, 
	promotion.option,
	etudiant.num_etu, 
	etudiant.nom, 
	etudiant.prenom,
	ROUND(sum_pts_activite.somme_pts_activite, 2) AS somme_pts_activite,
	sum_pts_evenement.somme_pts_evenement	
FROM 
	etudiant 
	LEFT OUTER JOIN (SELECT 
				 participe_activite.id_etu,
				 SUM(activite.points) AS somme_pts_activite
			FROM 
				participe_activite
				JOIN activite ON (activite.id = participe_activite.id_activite)
			WHERE 
				participe_activite.etat = 1 -- activite completée
			GROUP BY participe_activite.id_etu) AS sum_pts_activite ON (sum_pts_activite.id_etu = etudiant.id)
	LEFT OUTER JOIN (SELECT 
				 participe_evenement.id_etu,
				 SUM(evenement.polypoints) AS somme_pts_evenement
			FROM 
				participe_evenement
				JOIN evenement ON (evenement.id = participe_evenement.id_evenement)
			WHERE 
				participe_evenement.etat = 1 -- evenement completé
			GROUP BY participe_evenement.id_etu) AS sum_pts_evenement ON (sum_pts_evenement.id_etu = etudiant.id)
	LEFT OUTER JOIN promotion ON etudiant.id_promotion = promotion.id
ORDER BY 
    etudiant.nom;`),
    byName: (name, surname) => query(prepareQuery(`
SELECT
    etudiant.id
FROM
    etudiant
WHERE
    etudiant.nom = ? AND etudiant.prenom = ?;`, [surname, name])),
    byId: (id) => query(prepareQuery(`
SELECT 
	etudiant.id as id_etu,
	etudiant.id_promotion, 
	promotion.option,
	etudiant.num_etu, 
	etudiant.nom, 
	etudiant.prenom,
	ROUND(sum_pts_activite.somme_pts_activite, 2) AS somme_pts_activite,
	sum_pts_evenement.somme_pts_evenement	
FROM 
	etudiant 
	LEFT OUTER JOIN (SELECT 
				 participe_activite.id_etu,
				 SUM(activite.points) AS somme_pts_activite
			FROM 
				participe_activite
				JOIN activite ON (activite.id = participe_activite.id_activite)
			WHERE 
				participe_activite.etat = 1 AND -- activite completée
				participe_activite.id_etu = ? -- opti, check ici plutot que dans la requete parente
			GROUP BY participe_activite.id_etu) AS sum_pts_activite ON (sum_pts_activite.id_etu = etudiant.id)
	LEFT OUTER JOIN (SELECT 
				 participe_evenement.id_etu,
				 SUM(evenement.polypoints) AS somme_pts_evenement
			FROM 
				participe_evenement
				JOIN evenement ON (evenement.id = participe_evenement.id_evenement)
			WHERE 
				participe_evenement.etat = 1 AND -- evenement completé
				participe_evenement.id_etu = ? -- opti, check ici plutot que dans la requete parente
			GROUP BY participe_evenement.id_etu) AS sum_pts_evenement ON (sum_pts_evenement.id_etu = etudiant.id)
	LEFT OUTER JOIN promotion ON etudiant.id_promotion = promotion.id 
WHERE
	-- l'user à gagné des pts à un moment donné
	-- (sum_pts_activite.somme_pts_activite IS NOT NULL OR
	-- sum_pts_evenement.somme_pts_evenement IS NOT NULL) AND
    etudiant.id = ?;`, [id, id, id])),
    // utilisée exclusivement pour remplir la session
    byUserId: (user_id) => query(prepareQuery(`									  
SELECT 
 	user.id AS id_user,
	user.username,
	user.type,
	etudiant.id as id_etu,
	departement.id AS id_departement,
	departement.nom AS departement,
	etudiant.id_promotion, 
	promotion.option,
	etudiant.num_etu, 
	etudiant.nom, 
	etudiant.prenom,
	ROUND(sum_pts_activite.somme_pts_activite, 2) AS somme_pts_activite,
	sum_pts_evenement.somme_pts_evenement	
FROM 
	etudiant 
	LEFT OUTER JOIN (SELECT 
				 participe_activite.id_etu,
				 SUM(activite.points) AS somme_pts_activite
			FROM 
				participe_activite
				JOIN activite ON (activite.id = participe_activite.id_activite)
				JOIN association_etu_user ON (association_etu_user.id_etu = participe_activite.id_etu)
			WHERE 
				participe_activite.etat = 1 AND -- activite completée
				association_etu_user.id_user = ? -- opti, check ici plutot que dans la requete parente
			GROUP BY participe_activite.id_etu) AS sum_pts_activite ON (sum_pts_activite.id_etu = etudiant.id)
	LEFT OUTER JOIN (SELECT 
				 participe_evenement.id_etu,
				 SUM(evenement.polypoints) AS somme_pts_evenement
			FROM 
				participe_evenement
				JOIN evenement ON (evenement.id = participe_evenement.id_evenement)
				JOIN association_etu_user ON (association_etu_user.id_etu = participe_evenement.id_etu)
			WHERE 
				participe_evenement.etat = 1 AND -- evenement completé
				association_etu_user.id_user = ? -- opti, check ici plutot que dans la requete parente
			GROUP BY participe_evenement.id_etu) AS sum_pts_evenement ON (sum_pts_evenement.id_etu = etudiant.id)
	LEFT OUTER JOIN promotion ON (etudiant.id_promotion = promotion.id)
	LEFT OUTER JOIN departement ON (promotion.id_departement = departement.id)
	LEFT OUTER JOIN association_etu_user ON (etudiant.id = association_etu_user.id_etu)
	LEFT OUTER JOIN user ON (user.id = association_etu_user.id_user)
WHERE
	user.id = ?;`, [user_id, user_id, user_id])),
    responsable: {
        all: () => query(`
SELECT 
	evenement.id AS id_evenement,
	evenement.id_responsable,
	evenement.titre,
	etudiant.num_etu,
	etudiant.nom,
	etudiant.prenom
FROM 
	evenement
	JOIN etudiant ON etudiant.id = evenement.id_responsable;`),
    },
    add: (username, password,
        id_promotion,
        num_etu, nom,
        prenom) => query(prepareQuery(`
INSERT INTO user (username, password, type) VALUE (?, ?, 3);
SELECT LAST_INSERT_ID() INTO @last_user_id;
INSERT INTO etudiant (id_promotion, num_etu, nom, prenom) VALUE (?, ?, ?, ?);
INSERT INTO association_etu_user (id_user, id_etu) VALUE (@last_user_id, LAST_INSERT_ID());`, [username, password,
        id_promotion, num_etu,
        nom, prenom])),
    remove: (etu_id) => query(prepareQuery(`
DELETE user FROM user JOIN association_etu_user on id = id_user WHERE id_etu = ?;
DELETE FROM etudiant WHERE id = ?;`, [etu_id, etu_id])),
    rename: (id, id_promotion, num_etu,
        nom, prenom) => query(prepareQuery(`
UPDATE etudiant SET id_promotion = ?, 
					num_etu = ?,
					nom = ?, 
			    	prenom = ?
WHERE id = ?;`, [id_promotion, num_etu, nom, prenom, id])),
};

module.exports.professeur = {
    all: () => query('select * FROM professeur'),
    byId: (id) => query(prepareQuery('select * from professeur where id = ?', [id])),
    byUserId: (user_id) => query(prepareQuery(`
SELECT 
	user.id, 
	user.username, 
	user.type, 
	professeur.id, 
	professeur.num_prof, 
	professeur.prenom,
	professeur.nom
FROM 
	user 
	JOIN association_prof_user ON (association_prof_user.id_user = user.id)
	JOIN professeur ON (association_prof_user.id_prof = professeur.id) 
where user.id = ?;`, [user_id])),
    add: (username, password,
        num_prof, nom,
        prenom) => query(prepareQuery(`
INSERT INTO user (username, password, type) VALUE (?, ?, 2);
SELECT LAST_INSERT_ID() INTO @last_user_id;
INSERT INTO professeur (num_prof, nom, prenom) VALUE (?, ?, ?);
INSERT INTO association_prof_user (id_user, id_prof) VALUE (@last_user_id, LAST_INSERT_ID());`, [username, password,
        num_prof, nom,
        prenom])),
    rename: (id, num_prof,
        nom, prenom) => query(prepareQuery(`
UPDATE professeur SET num_prof = ?, prenom = ?, nom = ? WHERE id = ?;`, [num_prof, prenom, nom, id])),
};

module.exports.promotion = {
    all: () => query('SELECT * FROM promotion;'),
    byId: (id) => query(prepareQuery(`
	select 
	id,
	id_departement, 
	EXTRACT(YEAR FROM annee) as annee, 
	option 
	FROM promotion where id = ?`, [id])),
    add: (id_departement, annee, option) => query(prepareQuery('INSERT INTO promotion (id_departement, annee, option) VALUE (?, STR_TO_DATE(?, \'%Y-%m-%dT%H:%i:%s.000Z\'), ?);', [id_departement, annee, option])),
    remove: (id) => query(prepareQuery('DELETE FROM promotion WHERE id = ?;', [id])),
    rename: (id, id_departement, annee, option) => query(prepareQuery('UPDATE promotion SET id_departement = ?, annee = STR_TO_DATE(?, \'%Y-%m-%dT%H:%i:%s.000Z\'), option = ? WHERE id = ?;', [id_departement, annee, option, id])),
};

module.exports.departement = {
    all: () => query('SELECT * FROM departement;'),
    byId: (id) => query(prepareQuery('select * from departement where id = ?', [id])),
    add: (nom) => query(prepareQuery('INSERT INTO departement (nom) VALUE (?);', [nom])),
    remove: (id) => query(prepareQuery('DELETE FROM departement WHERE id = ?;', [id])),
    rename: (id, nom) => query(prepareQuery('UPDATE departement SET nom = ? WHERE id = ?;', [nom, id])),
};

module.exports.activite = {
    all: () => query(`
SELECT 
	etudiant.nom,
	etudiant.prenom,
	activite.date, 
	activite.sujet, 
	activite.points,	
	activite.rapport_pdf
FROM 
	activite
	JOIN participe_activite ON (participe_activite.id_activite = activite.id)
	JOIN etudiant ON (participe_activite.id_etu = etudiant.id);`),
    add: (id_etu, rpt_path, date_ajout, sujet_titre, nb_points) => query(prepareQuery(`
INSERT INTO activite (rapport_pdf, date, sujet, points) VALUE 
                     (?, STR_TO_DATE(?, '%Y-%m-%dT%H:%i:%s.000Z'), ?, ?);
SELECT LAST_INSERT_ID() INTO @last_activite_id;
INSERT INTO participe_activite (id_etu, id_activite, etat) VALUE (?, @last_activite_id, 1);`, [rpt_path, date_ajout, sujet_titre, nb_points, id_etu])),
    bySubject: (sujet) => query(prepareQuery('SELECT * FROM activite WHERE sujet = ?', [sujet])),
    remove: (id) => query(prepareQuery('DELETE FROM activite WHERE id = ?;', [id])),
    // rename: (id, nom) => query(prepareQuery(`UPDATE activite SET nom = ? WHERE id = ?;`, [nom, id])),
    byEtuId: (etu_id) => query(prepareQuery(`
SELECT sujet, date, points FROM 
participe_activite
INNER JOIN activite ON participe_activite.id_activite = activite.id
WHERE participe_activite.id_etu = ? AND etat = 1;`, [etu_id])),
};

module.exports.evenement = {
    all: () => query(prepareQuery(`
SELECT * FROM evenement ORDER BY evenement.date_debut DESC;`)),
    add: (id_responsable, titre, image, description, date_d, date_f, lieu, polypoints, places) => query(prepareQuery(`
INSERT INTO evenement (id_responsable, titre, image, description,                               date_debut, date_fin, lieu, polypoints, places) VALUE 
                      (?,                  ?,     ?,           ?, STR_TO_DATE(?, '%Y-%m-%dT%H:%i:%s.000Z'), STR_TO_DATE(?, '%Y-%m-%dT%H:%i:%s.000Z'), ?, ?, ?);
SELECT LAST_INSERT_ID() INTO @last_event_id;
INSERT INTO participe_evenement(id_etu, id_evenement, etat) VALUE (?, @last_event_id, 0);
`, [id_responsable, titre, image, description, date_d, date_f, lieu, polypoints, places, id_responsable])),
    participeByEtuId: (etu_id) => query(prepareQuery(`
SELECT 
    titre, 
    lieu,
    date_debut, 
    polypoints 
FROM 
    participe_evenement
    JOIN evenement ON (participe_evenement.id_evenement = evenement.id)
WHERE 
    participe_evenement.id_etu = ? AND 
	etat = 0;`, [etu_id])),
    terminesByEtuId: (etu_id) => query(prepareQuery(`
SELECT 
    titre, 
    lieu,
    date_debut, 
    polypoints 
FROM 
    participe_evenement
    JOIN evenement ON (participe_evenement.id_evenement = evenement.id)
WHERE 
    participe_evenement.id_etu = ? AND 
	etat = 1;`, [etu_id])),
    organisesByUserId: (etu_id) => query(prepareQuery(`
SELECT * 
FROM 
	evenement 
WHERE 
	evenement.id_responsable = ?;`, [etu_id])),
    byEventId: (event_id) => query(prepareQuery(`
SELECT * FROM evenement WHERE 
evenement.id = ?;`, [event_id])),
    getPlaceCount: (id_evenement) => query(prepareQuery(`
SELECT COUNT(id_etu) as nbplaceused FROM participe_evenement WHERE participe_evenement.id_evenement = ?;`, [id_evenement])),
};

module.exports.participe_evenement = {
    allEtu: (id_evenement) => query(prepareQuery(`
SELECT id_etu, num_etu, nom, prenom, promotion.option FROM participe_evenement
INNER JOIN 
	etudiant ON participe_evenement.id_etu = etudiant.id
INNER JOIN
	promotion ON promotion.id = etudiant.id_promotion
WHERE participe_evenement.id = ?;`, [id_evenement])),
    allPendingEtu: (id_evenement) => query(prepareQuery(`
SELECT id_etu, num_etu, nom, prenom, promotion.option FROM participe_evenement
INNER JOIN 
	etudiant ON participe_evenement.id_etu = etudiant.id
INNER JOIN
	promotion ON promotion.id = etudiant.id_promotion
WHERE participe_evenement.id_evenement = ? AND participe_evenement.etat = 0;`, [id_evenement])),
    byEventId: (id_evenement) => query(prepareQuery(`
SELECT * 
FROM participe_evenement WHERE 
id_evenement = ?;`, [id_evenement])),
    add: (id_etu, id_evenement, etat) => query(prepareQuery(`
INSERT INTO participe_evenement ( id_etu, id_evenement, etat ) Value ( ?, ?, ? );`, [id_etu, id_evenement, etat])),
    setParticipation: (etat, etu_id, id_evenement) => {
        return query(prepareQuery('UPDATE participe_evenement SET etat = ? WHERE id_etu = ? AND id_evenement = ?;', [etat, etu_id, id_evenement]));
    },
};


// --------------------------------------------------------------------------

module.exports.atExit = function (options, exitCode) {

    if (options.cleanup) {
        console.log('Cleaning up..');
        dbCon.end();
        console.log('Done !');
    }

    if (exitCode || exitCode === 0) {
        console.log('Exit signal: ', exitCode);
    }

    if (options.exit) {
        console.log('Forcing exit !');
        process.exit();
    }
};
