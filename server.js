'use strict';

const express = require('express');
const app = express();
const api = require('./api/api');
const router = express.Router();
const webAppRouter = require('./web_app/webAppRouter');
const path = require('path');

app.use('/', express.static('public'));
app.use('/api', api);
app.use('/img',express.static(path.join(__dirname, 'web_app/public/images')));
app.use('/private', require('connect-ensure-login').ensureLoggedIn(),    
    express.static('private'),
);

const server = app.listen(8080, function () {
    let port = server.address().port;
    console.log('My app is listening at http://127.0.0.1:%s', port);
});

app.set('views', path.join(__dirname, '/web_app/views'));
app.set('view engine', 'pug');

app.get('/logout', function (req, res) {
    res.sendFile('public/logout.html', {'root': __dirname});
});

app.get('/supprime_session', function (req, res) {
    req.logout();
    res.redirect('/');
});

app.get('/', function (req, res) {
    res.render('home');
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

module.exports = router ;

