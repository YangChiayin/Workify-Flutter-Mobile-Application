const mongoose= require('mongoose');
//import the bcrypt library
const bcrypt = require("bcrypt");
const db = require('../config/db');
//this will help us to generate a unique user id to every new user
const { v4: uuidv4 } = require("uuid"); 

const { Schema } = mongoose;

const userSchema = new Schema({
    userID: {
        type: String,
        required: true,
        unique: true, // Ensure the ID is unique
        default: uuidv4, // Generate a unique ID when a new user is created
      },
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