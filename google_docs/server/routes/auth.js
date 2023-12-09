const express=require('express');
const User = require('../models/user');
// const app=express();
const jwt = require('jsonwebtoken');
const auth = require('../middleware/auth');
const authRouter= express.Router();
authRouter.post('/api/signup',async (req,res)=>{
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
        const token = jwt.sign({id:user._id},"passwordKey");

        res.json({user,token});//res.json({user:user})
    }catch(e){
        res.status(500).json({error:e.message});
    }
});
authRouter.get('/',auth,async(req,res)=>{
    const user = await User.findById(req.user);
    res.json({
        user,
        token:req.token,
    })
});

module.exports=authRouter;