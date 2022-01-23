module.exports = app => {
    const express = require('express');
    const router = express.Router();
    const heroController = require('./heros-controller');


    router.get('/hero', heroController.findAll);
    router.get('/hero/:id', heroController.findOne);
    router.post('/hero/create', heroController.create);
    router.put('/hero/update/:id', heroController.update);
    router.delete('/hero/delete/:id', heroController.delete);



    app.use('/app', router);

}