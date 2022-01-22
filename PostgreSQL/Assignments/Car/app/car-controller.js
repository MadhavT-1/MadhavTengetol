const db = require('../db/models');
const carModel = db.Cars;

exports.findAll = (req, res) => {
    carModel.findAll()
        .then(cars => {
            res.json(cars);
        })
        .catch(err => {
            res.send('error: ' + err);
        });
};

exports.findOne = (req, res) => {
    carModel.findOne({
        where: {
            id: req.params.id
        }
    })
        .then(car => {
            res.json(car);
        })
        .catch(err => {
            res.send('error: ' + err);
        });
};

exports.create = (req, res) => {
    carModel.create({
       carName: req.body.carName,
       brand: req.body.brand,
    })
        .then(car => {
            res.json(car);
        })
        .catch(err => {
            res.send('error: ' + err);
        });
};
exports.update = (req, res) => {
    const id = parseInt(req.params.id);
    carModel.update({
        carName: req.body.carName,
        brand: req.body.brand,
    }, {
        where: {
            id: id
        }
    })
        .then(car => {
            res.json(car);
        })
        .catch(err => {
            res.send('error: ' + err);
        });
};

exports.delete = (req, res) => {
    const id = parseInt(req.params.id);
    carModel.destroy({
        where: {
            id: id
        }
    })
        .then(car => {
            res.json(car);
        })
        .catch(err => {
            res.send('error: ' + err);
        });
}
