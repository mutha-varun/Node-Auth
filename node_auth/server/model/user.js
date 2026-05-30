const mongoose = require("mongoose");

const userSchema = mongoose.Schema({
    name: {
        required: true,
        type: String,
        trime: true,
    },
    email: {
        required: true,
        type: String,
        trime: true,
        validate: {
            validator: (value)=>{  
                const re =
                    /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;

                return value.match(re);
            },
            message: "Please enter valid email"
        }
    },
    password:{
        required: true,
        type: String
    }
});

const User = mongoose.model("User", userSchema);

module.exports = User;