module.exports = app => {
    const express = require('express');
    const Router = express.Router();
    const carController = require('./car-controller');

    Router.get('/cars', carController.findAll);
    Router.get('/cars/:id', carController.findOne);
    Router.post('/cars/add', carController.create);
    Router.put('/cars/update/:id', carController.update);
    Router.delete('/cars/delete/:id', carController.delete);


    app.use('/app', Router);
};