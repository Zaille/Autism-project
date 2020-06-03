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
    byUserId: (id) => query(prepareQuery(`
select 
    *
from 
    authentication 
where 
    patientId = ?;`, [id])),
}


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
