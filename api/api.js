const express = require('express');
const app = express();
const bodyParser = require('body-parser');
const fileUpload = require('express-fileupload');

// PATHS //
app.set('views', './web_app/public/views');
app.set('view engine', 'pug');

// BODYPARSER SETUP //
app.use(bodyParser.urlencoded({extended: true}));
app.use(bodyParser.json());

// FILE UPLOAD SETUP //
app.use(fileUpload({
    createParentPath: true,
}));

// PASSPORT SETUP //
const auth = require('./passport.js');
auth(app);

// ROUTES SETUP //
let routes = require('./routes.js');
routes(app);

module.exports = app;