const db = require('../db1/models');
const product = db.Products;


exports.getAll =(req,res)=>{
    product.findAll().then(products =>{
        res.json(products);
    }).catch(error => console.log(error));
}

exports.update = (req,res)=>{
    // const id = parseInt(req.param.id);
    const name = req.body.name
    const item = {
        name: req.body.name,
        description:req.body.description,
        image:req.body.image,
        price:req.body.price,
        available_qty:req.body.available_qty
    }
    product.update(item,{where :{name:name}}).then(res=>{
        res.status(200).json({message :'Flower Updated...'});
    }).catch(error=>{
        res.json({message:'Error found'})
    })
}

exports.addFlower = (req,res)=>{

    const item = {
        name: req.body.name,
        description: req.body.description,
        image:req.body.image,
        price: req.body.price,
        available_qty: req.body.available_qty
    }

    product.create(item).then(result=>{

        res.status(200).json({message: ' Flower added..!'});

    }).catch(error=>{

        res.json({message:'failed....'});

    });

};

exports.removeFlower = (req,res)=>{

    const name = req.params.name;

    // console.log(name);

    product.destroy({where: {name : name}}).then(response=>{

        res.status(200).json({message: 'Flower Removed...'});

    }).catch(error=>{

        res.json({message: ' Error Happened...!'});

    });


}