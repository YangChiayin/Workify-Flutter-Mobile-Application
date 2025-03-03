const UserModel = require('../model/user.model');
const bcrypt = require("bcrypt");
const ServiceModel = require('../model/service.model');

class userService{

    //here we will store the email and password in the database
    static async registerUser(email,password){
        try{

            // Check if the email already exists in the database
            const existingUser = await UserModel.findOne({ email });
            if (existingUser) {
                // If the email already exists, throw an error with a message
                throw new Error('Email is already registered');
            }
            const createUser = new UserModel({email,password});
            const savedUser = await createUser.save();

            return { userID: savedUser.userID, email: savedUser.email };
       
        }catch(err){
            throw err;
        }
    }

     // Validate user credentials
     static async validateUser(email, password) {
        try {
            // Find user by email
            const user = await UserModel.findOne({ email });
            if (!user) {
                return null; // User not found
            }

            // Compare password with stored hashed password
            const isMatch = await bcrypt.compare(password, user.password);
            if (!isMatch) {
                return null; // Password mismatch
            }

            return user; // Return user if validation is successful
        } catch (err) {
            throw err;
        }
    }
}

module.exports = userService;
