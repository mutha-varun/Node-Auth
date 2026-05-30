const express = require("express");
const authRouter = express.Router();
const bcrpytjs = require("bcryptjs"); 
const User = require("../model/user");
const jwt = require("jsonwebtoken");
const auth = require("../middleware/auth");

authRouter.post("/api/signup", async  (req, res)=>{
    try {
        const {name, email, password} = req.body;

        const existingUser = await User.findOne({email});

        if(existingUser){
            return res.status(400).json({
                msg: "User with same email already exists!"
            });
        }

        const hashPassword = await bcrpytjs.hash(password, 8);

        let user = new User({
            email,
            password: hashPassword,
            name
        });
        user = await user.save();
        res.json(user);

    } catch (error) {
        res.status(500).json({
            error: error.message
        });
    }
});

authRouter.post("/api/signin", async(req, res)=>{
    try{
        const {email, password} = req.body;
        
        const user = await User.findOne({email});

        if(!user){
            return res.status(400).json({
                msg: "User does not exists!"
            });
        }
         
        const isMatch = await bcrpytjs.compare(password, user.password);

        if(!isMatch){
            return res.status(400).json({
                msg: "Incorrect credentials"
            });
        }
        
        const token = jwt.sign({id: user._id}, "passwordKey");

        res.json({
            token,
            ...user._doc
        });

 
    }catch(error){
        return res.status(500).json({
            error: error.message
        });
    }
});

authRouter.post("/tokenIsValid", async (req, res)=>{
    try{
        const token = req.header("x-auth-token");
        if(!token){
            return res.json(false);
        }
        const verified = jwt.verify(token, "passwordKey");
        if(!verified){
            return res.json(false);
        }

        const user = await User.findById(verified.id);
        if(!user){
            return res.json(false);
        }
        res.json(true);
    }catch(e){
        res.status(500).json({
            error: e.message
        });
    }
});

authRouter.get("/",auth, async(req, res)=>{
    const user = await User.findById(req.user);
    res.json({...user._doc, token: req.token});

});


module.exports = authRouter; 
