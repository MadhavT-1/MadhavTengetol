module.exports = app => {
    const express = require('express');
    const Router = express.Router();
    const AccountController = require('./account-controller');

    Router.get('/accounts', AccountController.findAll);
    Router.get('/accounts/:id', AccountController.findOne);
    Router.post('/accounts/create', AccountController.create);
    Router.put('/accounts/update/:id', AccountController.update);
    Router.delete('/accounts/delete/:id', AccountController.destroy);

    app.use('/app', Router);
}