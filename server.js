'use strict';

const express = require('express');
const app = express();
const api = require('./api/api.js');

app.use('/', api);
app.use('/img',express.static('./web_app/public/images'));
app.use('/web_app/public', express.static('public'));

const server = app.listen(8080, function () {
    let port = server.address().port;
    console.log('My app is listening at http://127.0.0.1:%s', port);
});

// -----------------------------------------------------------------------------

const runAtExit = function (options, exitCode) {
    require('./api/dbhelper.js').atExit(options, exitCode);
};

const registerAtExit = function () {
    // Do something when app is closing
    process.on('exit', runAtExit.bind(null, {cleanup: true}));

    // Catches ctrl+c event
    process.on('SIGINT', runAtExit.bind(null, {exit: true}));

    // Catches "kill pid" (for example: nodemon restart)
    process.on('SIGUSR1', runAtExit.bind(null, {exit: true}));
    process.on('SIGUSR2', runAtExit.bind(null, {exit: true}));

    // Catches uncaught exceptions
    process.on('uncaughtException', runAtExit.bind(null, {exit: true}));
};

registerAtExit();
