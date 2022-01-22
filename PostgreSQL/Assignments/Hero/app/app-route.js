const { Router } = require('express');

module.exports = app => {
    const express = require('express');
    const Router = express.Router();
    const heroController = require('./hero-controller');

    Router.get('/hero', heroController.findAll);
    Router.get('/hero/:id', heroController.findOne);
    // Router.post('/hero', heroController.create);

    Router.use('/app', Router);

}
