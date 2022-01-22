module.exports = app => {
    const express = require('express');
    const Router = express.Router();
    const BookController = require('./BookController');

    Router.get('/books', BookController.findAll);
    Router.get('/books/:id', BookController.findOne);
    Router.post('/books/add', BookController.create);
    Router.put('/books/update/:id', BookController.update);
    Router.delete('/books/delete/:id', BookController.destroy);
    
    app.use('/app', Router);
}