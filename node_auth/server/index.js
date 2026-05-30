const express = require("express");
const mongoose = require("mongoose");
const authRouter = require("./routes/auth");

const PORT = process.env.PORT || 3000;
const app = express();

app.use(express.json());
app.use(authRouter); 

const DB = "mongodb+srv://muthavarun07_db_user:stfjqfivfLH00hx1@cluster0.h0qktzp.mongodb.net/?appName=Cluster0"

mongoose.connect(DB).then(
    ()=>{
        console.log("Connection Successful");
    }).catch(
    (e)=>{
        console.log(e);
    });


app.listen(PORT, "0.0.0.0", ()=>{
   console.log(`contected at port ${PORT}`);
});