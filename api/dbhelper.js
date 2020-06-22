'use strict';
const mysql = require('mysql');

const dbCon = mysql.createConnection({
    host: 'localhost',
    user: 'admin',
    password: 'password',
    database: 'patientDatabase',
    multipleStatements: true,
});

// Connection to the database.
dbCon.connect(function (err) {
    if (err) throw err;
    console.log('Connected to database!');
});

// Callback function to promise
const cbToPromise = function (fn, ...args) {
    return new Promise(function (resolve, reject) {
        fn(...args, (err, res, fields) => {
            if (err) {
                reject(err);
            }
            else {
                resolve({'result': res, 'fields': fields});
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
    byUsername: (mail) => query(prepareQuery(`
select
    mail,
    password,
    type
from
    authentication
where
    mail = ?;`, [mail])),
}

module.exports.patient = {

    profile: (id) => query(prepareQuery(`
SELECT
    a.mail, p.firstName, p.lastName, p.age, p.parentFirstName, p.parentLastName, p.city, p.phoneNumber
FROM
    authentication a, patients p 
WHERE
    a.userId = p.patientId AND a.userId = ?;`, [id])),

    byUserId: (id) => query(prepareQuery(`
SELECT
    *
FROM
    authentication
WHERE
    patientId = ?;`, [id])),

    scores: () => query(`
SELECT
    u.firstName, u.lastName, u.age, s.score
FROM
    users u, scores s
WHERE
    u.patientId = s.patientId;`),

    infoById: (id) => query(prepareQuery(`
SELECT *
FROM users u, anwsers a, scores s, pictures p
WHERE u.patientId =  a.patientId
AND u.patientId =  s.patientId
AND u.patientId = p.patientId
AND u.patientId  = ?;`), [id])
}

module.exports.doctor = {
    profile: (id) => query(prepareQuery(`
SELECT
    a.mail, d.firstName, d.lastName, d.city, d.clinic
FROM
    authentication a, doctors d
WHERE
    a.userId = d.doctorId AND a.userId = ?;`, [id]))
}

module.exports.upload =  {
    file: (data) => query(prepareQuery(`
Insert into pictures
values (?,?,?,?,?);`), data),

    getIdByMail: (email) => query(prepareQuery(`
Select patientId from users
where parentMail = ?;`), email),

    createUser: (data) => query(prepareQuery(`
        Insert into users (firstName, lastName, age, parentFirstName, parentLastName, parentMail, phoneNumber)
        values (?,?,?,?,?,?,?),`), data),
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
