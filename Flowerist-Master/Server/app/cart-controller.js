const db = require('../db1/models');
const cart = db.Carts;
// const orders = db.
// const cart = db.Carts;

exports.addProduct = (req,res) =>{
    
    const productItem = {
        productid:req.body.productid,
        userid:req.body.userid,
        productname:req.body.productname,
        productprice:req.body.productprice,
        quantity:req.body.quantity

      }

    console.log('in express server ',productItem);
    cart.create(productItem).then(result =>{
        res.status(200).json({message : 'Added To cart'});

    }).catch(error=>{
        res.json({message:'something went wrong'});

    });
}

exports.getAllCartItems = (req,res)=>{
    let userid = req.body.id;
    console.log('in express server : ',userid);

    cart.findAll({where : {userid : userid}}).then(result=>{
        // console.log(result);
        res.status(200).send(result);

    }).catch(error=>{
        res.json({message : 'cart is empty'})
    })
}

exports.updateCart = (req,res)=>{

    const id = parseInt(req.body.productid);
    const userid = parseInt(req.body.userid);

    const quantity = parseInt(req.body.quantity )
      console.log(id," in express : ",quantity);

    cart.update({quantity:req.body.quantity,
        updatedAt: new Date},
        {where : {productid : id,userid:userid}
    }).then(result=>{
        console.log(result);
        res.status(200).json({message : 'cart updated'});
    }).catch(error=>{
        res.json({message :'Something went wrong'});
    });
}

exports.findCart = (req,res)=>{

    cart.findOne({where : {productid : req.body.productid}}).then(result=>{
        res.status(200).send({status : result.quantity});
    }).catch(error=>{
        res.send(false)
    })
}

exports.loadCart= (req,res)=>{

    const id=parseInt(req.body.userid);

    console.log('in express server : ',id);
    cart.findAll({where : {userid :id}}).then(result=>{
        res.send(result);
    }).catch(error=>{
        res.json({error : error});
    })
}