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
                res.status(400).json({error: "emptyRequest"});
            }
            else {
                /*req.files['files[]'].forEach(elem => {
                    splitPath = elem.name.split('.');
                    path = req.body.email + '_video' + i + '.' + splitPath[splitPath.length - 1];
                    elem.mv('./api/videos/' + path);
                    i = i + 1;
                });*/
                dbHelper.formUpload.createUser([
                    req.body.childFirstName,
                    req.body.childLastName,
                    parseInt(req.body.childAge),
                    req.body.parentFirstName,
                    req.body.parentLastName,
                    req.body.email,
                    parseInt(req.body.phoneNumber),
                ]).catch((err) => {
                    error = true;
                    res.status(400).json(err);
                });
                dbHelper.formUpload.getIdByMail(req.body.email)
                    .then((rows) => res.status(201).json(rows.result[0]))
                    .catch((err) => res.status(400).json(err));
            }
        }
        catch (err) {
            res.status(500).send(err);
        }
    });

    app.post('/uploadResponses', function (req, res) {
        console.log("Uploading responses !");
        //console.dir(req.body);
        let yesNoIdx = 0;
        dbHelper.responseUpload.getQuestionsByGroup(req.body.groupId)
            .then((rows) => rows.result.forEach( function(elem, index) {
                console.log(elem);
                switch (elem["type"]) {
                    case 1: //YesNoQuestion Type
                        dbHelper.responseUpload.createAnswer([
                            req.body.patientId,
                            req.body.groupId,
                            index + 1,
                            req.body.yesNoAnswers[yesNoIdx],
                            null,
                            null,
                            null,
                        ]).catch((err) => {
                            res.status(400).json(err);
                        });
                        yesNoIdx++;
                        return;
                    case 2: //Index of a previous YesNoAnswers
                        dbHelper.responseUpload.createAnswer([
                            req.body.patientId,
                            req.body.groupId,
                            index + 1,
                            null,
                            req.body.answerChoice,
                            null,
                            null,
                        ]).catch((err) => {
                            res.status(400).json(err);
                        });
                        return;
                    case 3: //Example give by the parent
                        dbHelper.responseUpload.createAnswer([
                            req.body.patientId,
                            req.body.groupId,
                            index + 1,
                            null,
                            null,
                            req.body.example,
                            null,
                        ]).catch((err) => {
                            res.status(400).json(err);
                        });
                        return;
                    case 4: //Description ask to the parent
                        dbHelper.responseUpload.createAnswer([
                            req.body.patientId,
                            req.body.groupId,
                            index + 1,
                            true,
                            null,
                            null,
                            req.body.description,
                        ]).catch((err) => {
                            res.status(400).json(err);
                        });
                        yesNoIdx++;
                        return;
                }
            }))
            .then((rows) => res.status(200).send())
            .catch((err) => {
                console.log(err);
                res.status(400).json(err);
            });
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
