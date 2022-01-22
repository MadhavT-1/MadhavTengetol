const db = require('../db/models');
const hero = db.Hero;

exports.findAll = (req, res) => {
    hero.findAll()
        .then(heroes => {
            res.json(heroes);
        })
        .catch(err => {
            res.status(500).send({
                message: err.message || "Some error occurred while retrieving heroes."
            });
        });
};

exports.findOne = (req, res) => {
    const id = parseInt(req.params.id);
    hero.findByPk(id)
        .then((data) => { res.json(data) })
        .catch((err) => {
            res.status(500)
                .send({ message: err.message || "Some Error retriving hero Data" })
        });
};

exports.create = (req, res) => {
    hero.create({
        heroName: req.body.heroName,
        film: req.body.film,
    })
        .then((data) => { res.json(data) })
        .catch((err) => {
            res.status(500)
                .send({ message: err.message || "Some Error creating hero" })

        });
};

