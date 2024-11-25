//import the services
const userService = require("../services/user.services");

exports.register = async(req,res,next)=>{
    try{
        const {email,password} = req.body;
        const successRes = await userService.registerUser(email,password);

        res.json({status: true, success: "User registered successfully"});
    }catch(error){0
        throw error;
    }
}

exports.login = async (req, res, next) => {
    try {
        const { email, password } = req.body;

        // Validate user credentials
        const user = await userService.validateUser(email, password);

        if (!user) {
            return res.status(401).json({ status: false, error: "Invalid credentials" });
        }

        res.json({ status: true, success: "Login successful", user });
    } catch (error) {
        next(error); // Pass errors to the global error handler
    }
};