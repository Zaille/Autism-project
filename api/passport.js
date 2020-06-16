const LocalStrategy = require('passport-local').Strategy;
const passport = require('passport');
const dbHelper = require('./dbhelper.js');
const passwordHash = require('password-hash');

module.exports = function (app) {

    app.use(require('express-session')({
        secret: '335168427281550942558874596817021745493361659792786727130465314100646280159669855912074179323195635128975738471722436311998661821090372618672360773865293922854984524342349588135783484469197640',
        resave: false,
        saveUninitialized: false,
        key: 'jsucks',
        cookie: {
            path: '/',
            httpOnly: true,
            maxAge: null, // session cookie, deleted when the browser is closed
        },
    }));

    // Initialize Passport and restore authentication state.
    app.use(passport.initialize());
    app.use(passport.session());

    // CONFIG
    const admin_password = 'admin1';
    const admin_mail = 'admin@admin.com';

    passport.use(new LocalStrategy({
            usernameField: 'email',
            passwordField: 'password',
            passReqToCallback: true,
        },
        function (email, password, cb) {

            if (email === admin_mail) {
                if (passwordHash.verify(password, passwordHash.generate(admin_password))) {
                    cb(null, {type: 1});
                    return;
                } else {
                    cb(null, false);
                    return;
                }
            }

            dbHelper.users.byUsername(email)
                .then((rows) => {
                    //User doesn't exist
                    if (rows.result.length !== 1) {
                        cb(null, false);
                    } else if (passwordHash.verify(password, rows.result[0].password)) {
                        //User is admin
                        if (rows.result[0].type === 1) {
                            cb(null, {type: rows.result[0].type});
                        }
                        //User is patient
                        else if (rows.result[0].type === 2) {
                            dbHelper.patient.byUserId(rows.result[0].id)
                                .then((elem) => {
                                    cb(null, elem.result[0]);
                                });
                        }
                    } else {
                        //User ok but wrong password
                        cb(null, false);
                    }
                }, err => cb(err));
        },
    ));

    // Store data into session
    passport.serializeUser(function (user_session, cb) {
        cb(null, user_session);
    });

    // Get data from session
    passport.deserializeUser(function (user_session, cb) {
        cb(null, user_session);
    });

    //Routes de connexion/deconnexion
    app.post('/login', passport.authenticate('login', {
        successRedirect: '/matieres',
        failureRedirect: '/connexion',
        failureFlash: true,
    }));

    app.post('/signup', passport.authenticate('signup', {
        successRedirect: '/connexion',
        failureRedirect: '/inscription',
        failureFlash: true,
    }));

    app.get('/logout', function (req, res, next) {
        if (req.session) {
            req.session.destroy(function (err) {
                if (err) return next(err);
                else return res.redirect('/');
            });
        }
    });

    app.get('/logout', function (req, res) {
        res.sendFile('public/logout.html', {'root': __dirname});
    });

    app.get('/supprime_session', function (req, res) {
        req.logout();
        res.redirect('/');
    });

};
