const mongoose= require('mongoose');
//import the bcrypt library
const bcrypt = require("bcrypt");
const db = require('../config/db');

const { Schema } = mongoose;

const userSchema = new Schema({
    email:{
        type: String,
        required:true,
        lowercase:true,
        unique:true
    },
    password:{
        type:String,
        required:true
    }

});

userSchema.pre('save',async function(){
    try{
        var user = this;
        const salt = await(bcrypt.genSalt(10));
        //the password encrypted will be stored here
        const hashpass = await bcrypt.hash(user.password,salt);
        //save it in the database
        user.password = hashpass;
        
    }catch(error){

    }

});
const UserModel = db.model('user', userSchema);


module.exports = UserModel;