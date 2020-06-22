const dbHelper = require("./dbhelper");

module.exports = function (app) {

    /************ PAGES ************/

    app.get('/', function (req, res) {
        res.render('home');
    });

    app.get('/doctor_profile', function (req, res) {
        res.render('doctor_profile', {
            firstName: req.body.firstName,
            lastName: req.body.lastName,
            email: req.body.email,
            clinic: req.body.clinic,
            city: req.body.city,
        });
    });

    app.get('/user_profile', function (req, res) {
        res.render('user_profile');
    });

    app.get('/erreur', function (req, res) {
        res.redirect('/');
    });

    /************ API ************/

    app.post('/api/upload', function (req,res) {
        console.log("Upload !");
        console.dir(req.body);
        console.dir(req.files);
        let splitPath;
        let path;
        let i = 1;
        try {
            if (!req.files || !req.body) {
                res.status(400).send();
            }
            else {
                req.files['files[]'].forEach(elem => {
                    splitPath = elem.name.split('.');
                    path = req.body.email + '_video' + i + '.' + splitPath[splitPath.length - 1];
                    elem.mv('./api/videos/' + path);
                    i = i + 1;
                });
                res.status(201).send();
            }
            dbHelper.upload.createUser([
                req.body.childFirstName,
                req.body.childLastName,
                req.body.childAge,
                req.body.parentFirstName,
                req.body.parentLastName,
                req.body.email,
                req.body.phoneNumber,
            ]);
        }
        catch (err) {
            res.status(500).send(err);
        }
    });

    /* Get patient profile */
    app.get('/api/patient/profile/:id', function (req, res) {
        dbHelper.patient.profile(req.params.id)
            .then((rows) => res.json(rows.result))
            .catch((err) => res.status(400).json({ err }));
    });

    /* Get doctor profile */
    app.get('/api/doctor/profile/:id', function (req, res) {
        dbHelper.doctor.profile(req.params.id)
            .then((rows) => res.json(rows.result))
            .catch((err) => res.status(400).json({ err }));
    });

    /* Get all scores */
    app.get('/api/scores', function (req, res) {
        dbHelper.patient.scores()
            .then((rows) => res.json(rows.result))
            .catch((err) => res.status(400).json({ err }));
    });

    /* Get all information of a patient */
    app.get('/api/info/:id', function (req, res) {
        dbHelper.patient.profile()
            .then((rows) => res.json(rows.result))
            .catch((err) => res.status(400).json({ err }));
    });

};
