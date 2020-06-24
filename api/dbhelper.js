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

const prepareQuery = function (unformatted_query, inserts) {
    return mysql.format(unformatted_query, inserts);
};

const query = function (sql_query) {
    console.log(sql_query);
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
    byUserId: (id) => query(prepareQuery(`
select
    *
from
    authentication
where
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

module.exports.formUpload =  {
    file: (data) => query(prepareQuery(`
Insert into pictures
values (?,?,?,?,?);`), data),

    getIdByMail: (email) => query(prepareQuery(`
select
    patientId
from
    users
where
    parentMail = ?;`, [email])),

    createUser: (data) => query(prepareQuery(`
insert into
    users (firstName, lastName, age, parentFirstName, parentLastName, parentMail, phoneNumber)
values
    (?);`, [data])),
};

module.exports.responseUpload = {
    createAnswer: (data) => query(prepareQuery(`
Insert into answers (patientId, groupId, questionId, yesNoAnswer, answerChoice, example, description)
values (?)
on duplicate key update
questionId = ?,
yesNoANswer = ?,
answerChoice = ?,
example = ?,
description = ?;`, [data, data[2], data[3], data[4], data[5], data[6]])),

    getQuestionsByGroup: (id) => query(prepareQuery(`
select
    questionId, type
from
    questions
where
    groupId = ?;`, [id])),
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
