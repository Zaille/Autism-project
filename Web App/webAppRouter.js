// res.render('home', {'root': __dirname});
const express = require('express');
const app = express();

app.get('/home', function (req, res) {
    res.render('home');
});

app.get('/erreur', function (req, res) {
    res.redirect('/');
});