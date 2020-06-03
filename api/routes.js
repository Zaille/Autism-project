module.exports = function (app) {

    app.post('/upload', function (req,res) {
        console.log("Upload !");
        console.dir(req.body);
        console.dir(req.files);
        try {
            if (!req.files) {
                res.redirect('/');
            }
            else {
                let image = req.files.file;
                image.mv('./api/images/' + image.name);
                res.redirect('/');
            }
        }
        catch (err) {
            res.status(500).send(err);
        }
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
