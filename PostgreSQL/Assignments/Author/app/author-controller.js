const db = require('../db/models');
const Author = db.Author;

exports.findAll = (req, res) => {
    Author.findAll()
        .then(authors => {
            res.json(authors);
        })
        .catch(err => {
            res.send(err);
        });
};

exports.findById = (req, res) => {
    const id = parseInt(req.params.id);
    Author.findByPk(id)
        .then(author => {
            res.json(author);
        })
        .catch(err => {
            res.send(err);
        });
};

exports.create = (req, res) => {
    Author.create({
        authorName: req.body.authorName,
        bookName: req.body.bookName
    })
        .then(author => {
            res.json(author);
        })
        .catch(err => {
            res.send(err);
        });
};

exports.update = (req, res) => {
    const id = parseInt(req.params.id);
    Author.update({
        authorName: req.body.authorName,
        bookName: req.body.bookName
    }, {
        where: {
            id: id
        }
    })
        .then(author => {
            res.json("Successfully updated author with id = " + id);
        })
        .catch(err => {
            res.send(err);
        });
};

exports.delete = (req, res) => {
    const id = parseInt(req.params.id);
    Author.destroy({
        where: {
            id: id
        }
    })
        .then(author => {
            res.json("Successfully deleted author with id = " + id);
        })
        .catch(err => {
            res.send(err);
        });
}