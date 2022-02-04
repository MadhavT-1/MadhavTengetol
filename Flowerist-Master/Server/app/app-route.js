module.exports = app =>{
    const express = require('express');
    const router = express.Router();
    const userController = require('./user-controller');
    const productController = require('./product-controller');
    const cartController = require('./cart-controller');
    const orderController = require('./order-controller')
    const checkAuth = require('../middleware/checkAuth');

// ===================  Product Controller    ======================    //
    router.get('/products',productController.getAll);



    // =========================   Admin Part  =======================

    router.post('/admin/addflower',productController.addFlower);

    router.get('/admin/getflowers',productController.getAll);

    router.put('/admin/update',productController.update);

    router.delete('/admin/remove/:name',productController.removeFlower);

    router.get('/admin/getusers',userController.getAllUsers);

    router.get('/admin/getorders',orderController.getOrders)

    
// ===================  User Controller    ======================   //
    router.post('/register',userController.register);

    router.post('/login',userController.login);

    router.post('/myprofile',userController.myInfo);


 // ===================  cart Controller    ======================   //

    router.post('/getcart',cartController.getAllCartItems);

    router.post('/addtocart',cartController.addProduct);

    router.put('/updatecart',cartController.updateCart);

    router.post('/findone',cartController.findCart)

    router.post('/loadcart',cartController.loadCart)


    // ===================  Order Controller    ======================   //

    router.post('/addorder',orderController.placeOrder);

    router.post('/getmyorders',orderController.myOrders);

    

    app.use('/app',router);

    
}