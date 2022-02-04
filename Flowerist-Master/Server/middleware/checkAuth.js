//token verification
const jwt = require('jsonwebtoken');

module.exports = (req,res,next) =>{

    try{

        const token = req.headers.authorization.split(" ")[1];
        const decodedToken = jwt.verify(token, 'Long_secret_Key');
        req.userData = { email: decodedToken.email, userId: decodedToken.userId };
      

        // jwt.verify(token,'Long_secret_Key');
        next();
    }
    catch(error){
        return res.status(401).json({message : 'Auth Failed'});
    }
};