const express=require("express");
require("dotenv").config();
const mongoose = require("mongoose");
const cors = require("cors");
const authRouter = require("./routes/auth");
const documentRouter = require("./routes/document");
const http=require('http');

const PORT = process.env.PORT | 3001;

const app=express();
var server = http.createServer(app);
var io = require("socket.io")(server);
app.use(cors());
app.use(express.json());
app.use(authRouter);
app.use(documentRouter);
mongoose.connect(process.env.DB)
.then(()=>{
    console.log("Connection ");
})
.catch((e)=>{
    console.log(e);
});

// io.on('connection',(socket)=>{
//     socket.on('join',(documentId)=>{
//         socket.join(documentId);
//         console.log("joined");
//     });
// });
io.on("connection", (socket) => {
    socket.on("join", (documentId) => {
        socket.join(documentId);
        console.log("joined");
    });
});


server.listen(PORT,"0.0.0.0",()=>{
    console.log(`connected at port ${PORT}`);
});