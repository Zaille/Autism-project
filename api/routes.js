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

};
