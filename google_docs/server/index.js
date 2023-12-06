const express=require("express");
require("dotenv").config();
const mongoose = require("mongoose");

const PORT = process.env.PORT | 3001;

const app=express();

mongoose.connect(process.env.DB)
.then(()=>{
    console.log("Connection successful");
})
.catch((e)=>{
    console.log(e);
});

app.listen(PORT,"0.0.0.0",()=>{
    console.log(`connected at port ${PORT}`);
});