'use strict';
const express = require('express');
const app = express();
const api = require('./api/api');

app.use('/', express.static('public'));
app.use('/private', express.static('private'));
app.use('/api', api);

const server = app.listen(8080, function () {
    let port = server.address().port;
    console.log('My app is listening at http://127.0.0.1:%s', port);
});


