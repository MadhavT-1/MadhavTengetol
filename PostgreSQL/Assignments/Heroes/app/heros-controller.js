const db = require('../db/models');
const Hero = db.Hero;

exports.findAll = (req, res) => {
    Hero.findAll()

        .then(heros => {
            res.json(heros);
        })
        .catch(err => {
            res.status(500).send({
                message: err.message || "Some error occurred while retrieving heros."
            });
        });
};

exports.findOne = (req, res) => {
    const id = parseInt(req.params.id);
    Hero.findByPk(id)
        .then(hero => {
            if (!hero) {
                return res.status(404).send({
                    message: "Hero not found with id " + id
                });
            }
            res.json(hero);
        })
        .catch(err => {
            res.status(500).send({
                message: "Error retrieving hero with id " + id
            });
        });
};

exports.create = (req, res) => {
    Hero.create({
        heroName: req.body.heroName,
        film: req.body.film
    })
        .then(hero => {
            res.send({ message: "Hero created successfully!" });
        })
        .catch(err => {
            res.status(500).send({
                message: err.message || "Some error occurred while creating the Hero."
            });
        });
};

exports.update = (req, res) => {
    const id = parseInt(req.params.id);
    Hero.update({
        heroName: req.body.heroName,
        film: req.body.film
    }, { where: { id: id } })
        .then(hero => {
            res.send({ message: "Hero updated successfully!" });
        })
        .catch(err => {
            res.status(500).send({
                message: "Error updating hero with id=" + id
            });
        });
};

exports.delete = (req, res) => {
    const id = parseInt(req.params.id);
    Hero.destroy({
        where: { id: id }
    })
        .then(hero => {
            res.send({ message: "Hero deleted successfully!" });
        })
        .catch(err => {
            res.status(500).send({
                message: "Could not delete hero with id=" + id
            });
        });
}

