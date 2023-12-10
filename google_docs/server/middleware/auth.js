const jwt = require('jsonwebtoken');
const auth = async(req,res,next)=>{
    try {
        const token = req.header('x-auth-token');
        if(!token)
            return res.status(401).json({msg:"No Auth token , access denied"});
       
            const verified=jwt.verify(token,"passwordKey");
            if(!verified)
            return res.status(401).
        json({msg:"Token verification failed ,Authorisation denied"});
   
        req.user = verified.indexOf;
        req.token= token;
        next();
    } catch (e) {
        res.status(500).json({error: e.message});
    }
};
module.exports = auth;