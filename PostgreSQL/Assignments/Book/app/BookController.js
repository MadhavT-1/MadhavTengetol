const db = require('../db/models');
const book = db.Books;

exports.findAll = (req, res) => {
    book.findAll()
        .then((data)=>{res.json(data)})
        .catch((err)=>{
            res.status(500)
                 .send({message:err.message|| " Some Error retriving Books Data"})
        })
};

exports.findOne = (req, res) => {
    const id = parseInt(req.params.id);
    book.findByPk(id)
        .then((data)=>{res.json(data)})
        .catch((err)=>{
            res.status(500)
                 .send({message:err.message|| "Some Error retriving Book Data"})
        }
)};

exports.create = (req, res) => {
    book.create({
        bookName: req.body.bookName,
        author: req.body.author,
        publishDate: req.body.publishDate
    })
        .then((data)=>{res.json(data)})
        .catch((err)=>{
            res.status(500)
                 .send({message:err.message|| "Some Error creating Book"})
        })
};

exports.update = (req, res) => {
    const id = parseInt(req.params.id);
    book.update({
        bookName: req.body.bookName,
        author: req.body.author,
        publishDate: req.body.publishDate
    }, {
        where: {id: id}
    })
        .then((data)=>{res.json(data)})
        .catch((err)=>{
            res.status(500)
                 .send({message:err.message|| "Some Error updating Book"})
        })
};


exports.destroy = (req, res) => {
    const id = parseInt(req.params.id);
    book.destroy({
        where: {id: id}
    })
        .then((data)=>{res.json(data)})
        .catch((err)=>{
            res.status(500)
                 .send({message:err.message|| "Some Error deleting Book"})
        })
};

