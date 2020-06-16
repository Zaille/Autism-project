'use strict';

const express = require('express');
const app = express();
const router = express.Router();
const api = require('./api.js');
const auth = require('./auth.js');
const webAppRouter = require('./Web App/webAppRouter');
const path = require('path');

const passport = auth(app);
const port = 3000;
app.set('views', path.join(__dirname, '/Web App/views'));
app.set('view engine', 'pug');

app.use('/api', api(passport));

app.use('/img',express.static(path.join(__dirname, 'Web App/public/images')));

app.use('/private', require('connect-ensure-login').ensureLoggedIn(),
    express.static('private'),
);

app.get('/logout', function (req, res) {
    res.sendFile('public/logout.html', {'root': __dirname});
});

app.get('/supprime_session', function (req, res) {
    req.logout();
    res.redirect('/');
});

app.get('/home', function (req, res) {
    res.render('home');
});

const server = app.listen(port, function () {
    console.log('My app is listening at http://127.0.0.1:%s', port);
});

// -----------------------------------------------------------------------------

const runAtExit = function (options, exitCode) {
    require('./dbhelper.js').atExit(options, exitCode);
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
