const UserModel = require('../model/user.model');
const bcrypt = require("bcrypt");

class userService{
    //here we will store our data in the database
    static async registerUser(email,password){
        try{
            const createUser = new UserModel({email,password});
            return await createUser.save();
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