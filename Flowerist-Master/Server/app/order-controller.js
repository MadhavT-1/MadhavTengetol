const db = require('../db1/models');
const orders = db.OrderDetails;

exports.placeOrder=(req,res)=>{

    // console.log(req.body);
    const productprice = parseInt(req.body.price)
    const orderItem = {

        userid: req.body.userid,
        productid: req.body.productid,
        productname:req.body.productname,
        quantity: req.body.quantity,
        price:productprice,	
        total:req.body.total,
        orderdate: new Date
    }
    console.log(orderItem);

    orders.create(orderItem).then(result=>{

        res.status(200).json({message: ' Updated In Database'});

    }).catch(error =>{

        res.send({message : 'Error in inserting'})

    })

    
}

exports.getOrders = (req,res)=>{
    orders.findAll().then(success =>{
        res.status(200).send(success);

    }).catch(error =>{
        res.status(404).send(error);
    })
}

exports.myOrders=(req,res)=>{
    const userid = parseInt(req.body.userid);
    console.log(userid);
    orders.findAll({where : {userid : userid}}).then(success=>{

        res.send(success);

    }).catch(error =>{
        res.json({message : 'Orders Not Found'})
    })
}