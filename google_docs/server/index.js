const express=require("express");
require("dotenv").config();
const mongoose = require("mongoose");
const cors = require("cors");
const authRouter = require("./routes/auth");

const PORT = process.env.PORT | 3001;

const app=express();
app.use(cors());
app.use(express.json());
app.use(authRouter);
mongoose.connect(process.env.DB)
.then(()=>{
    console.log("Connection ");
})
.catch((e)=>{
    console.log(e);
});

app.listen(PORT,"0.0.0.0",()=>{
    console.log(`connected at port ${PORT}`);
});