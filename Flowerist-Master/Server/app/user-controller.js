
const db = require('../db1/models');
const bcrypt = require('bcrypt');
const saltRounds = 10;
const salt = bcrypt.genSaltSync(saltRounds);
const user = db.Users;
const jwt = require('jsonwebtoken');



exports.register = (req,res,next) =>{

    password = req.body.password;
    
    const hash = bcrypt.hashSync(password, salt);

    // const bodyEmail = req.body.email;
   
    const newUser ={
        firstname:req.body.firstName,
        lastname:req.body.lastName,
        email:req.body.email,
        contact:req.body.contact,
        address:req.body.address,
        password:hash       
    };

    // if(!newUser.firstname || !newUser.lastname || !newUser.email ||
    //     !newUser.contact || !newUser.address){
    //     res.status(400).json({message : 'please Enter Valid Information'})
    //     next();
    // }
    

    console.log("New User ",newUser);
    user.create(newUser)
                    .then( success => {
                        console.log('success');
                        res.status(200).json({ message : "registration successfull...!"});
                    }).catch(error =>{
                        res.status(500).json({
                            message : "Error in registration"
                        });
                    });
    


    // user.findOne({where : {email : bodyEmail}}).then(result=>{

    //     console.log(result.email);
        
    //     if(result.email === bodyEmail){
    //         res.status(500).send({message : 'Email already registered..'})
    //     }
    //     else{
    //         res.send({message: 'registration Successfully..'})
    //         user.create(newUser).then(result=>{
    //             res.status(200).send({message: 'registration Successfully..'})
    //         });
            
    //     }

        // user.create(newUser).then(success=>{
        //     res.status(200).send({message : 'Registration successfull.'})
        // }).catch(error =>{
        //     res.status(500).json({message : error})
        // })
      
        
    // }).catch(error=>{
        
    // })


};

exports.login = (req,res)=>{
    const email = req.body.email;
    const password = req.body.password;

    if(!email || !password){
        res.status(400).send({message:'Please enter valid information'});
    }

if(email =="admin@flowerist.com" && password =="Pass@123"){
    const token = jwt.sign({email : email},'Very_Long_Admin_secret_Key');
    res.status(200).json({token : token,userid:'admin'});
}else{

    user.findOne({where : {email : email}}).then(result =>{
        console.log('=====================');
        
        const hash = result.password

            if(!bcrypt.compareSync(password, hash)){
                res.status(401).json({message:'Wrong password'});
            }
            //TODO : create a token and send to user

        const token = jwt.sign({email : email},'Long_secret_Key');
            
        res.status(200).json({token : token,userid : result.id});
     
    }).catch(error =>{
       
        res.status(401).json({error : 'login failed'});
    }); 
}
}


exports.getAllUsers = (req,res) =>{
    user.findAll().then(result=>{
        res.status(200).send(result);
    }).catch(error=>{
        res.send({message : 'Error'});
    })
}

exports.myInfo=(req,res)=>{

    const userid  =parseInt(req.body.userid);

    user.findAll({where : {id : userid}}).then(success =>{
        res.send(success);
    }).catch(error =>{
        res.json({message : 'No User Found'});
    })
}
