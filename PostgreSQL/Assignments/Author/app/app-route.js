module.exports = app => {
    const express = require('express');
    const router = express.Router();
    const authorController = require('./author-controller');


    router.get('/authors', authorController.findAll);
    router.get('/authors/:id', authorController.findById);
    router.post('/authors/create', authorController.create);
    router.put('/authors/update/:id', authorController.update);
    router.delete('/authors/delete/:id', authorController.delete);


    app.use('/app', router);

}