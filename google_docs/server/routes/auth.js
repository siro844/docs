const express=require('express');
const User = require('../models/user');
// const app=express();
const authRouter= express.Router();
authRouter.post("/api/signup",async (req,res)=>{
    try{
        const {name,email,profilePic} =req.body;
        //if email doesnt exist only then store the data
        //does the email exist??
        let user = await User.findOne({
            email:email
        });
        if(!user){
            user = new User({
                name:name,
                email:email,
                profilePic:profilePic,
            });
            user = await user.save();
        }

        res.json({user:user});//res.json({user:user})
    }catch(e){

    }
});
module.exports=authRouter;