dbHelper = require("./dbhelper");

module.exports = function (app) {

    app.post('/uploadFiles', function (req,res) {
        console.log("Uploading files !");
        console.dir(req.body);
        console.dir(req.files);
        let splitPath;
        let path;
        let i = 1;
        try {
            if (/*!req.files ||*/ !req.body) {
                res.status(400).send();
            }
            else {
                /*req.files['files[]'].forEach(elem => {
                    splitPath = elem.name.split('.');
                    path = req.body.email + '_video' + i + '.' + splitPath[splitPath.length - 1];
                    elem.mv('./api/videos/' + path);
                    i = i + 1;
                });*/
                /*dbHelper.formUpload.createUser([
                    req.body.childFirstName,
                    req.body.childLastName,
                    req.body.childAge,
                    req.body.parentFirstName,
                    req.body.parentLastName,
                    req.body.email,
                    req.body.phoneNumber,
                ], function (err, rows) {
                    if (err) throw err;
                });*/
                dbHelper.formUpload.createUser([
                    req.body.childFirstName,
                    req.body.childLastName,
                    parseInt(req.body.childAge),
                    req.body.parentFirstName,
                    req.body.parentLastName,
                    req.body.email,
                    parseInt(req.body.phoneNumber),
                ]).catch((err) => res.status(400).json({ err }));//if (err["errno"] == 1062)
                dbHelper.formUpload.getIdByMail(req.body.email)
                    .then((rows) => res.status(201).json(rows.result[0]))
                    .catch((err) => res.status(400).json({err}));

            }
        }
        catch (err) {
            res.status(500).send(err);
        }
    });

    app.post('/uploadResponses', function (req, res) {
        console.log("Uploading responses !");
        console.dir(req.body);
        res.status(201).send();
    });

    /* Get all scores */
    app.get('/scores', function (req, res) {
        dbHelper.patient.scores()
            .then((rows) => res.json(rows.result))
            .catch((err) => res.status(400).json({ err }));
    });

    /* Get all information of a patient */
    app.get('/info/:id', function (req, res) {
        dbHelper.patient.scores()
            .then((rows) => res.json(rows.result))
            .catch((err) => res.status(400).json({ err }));
    });
};
