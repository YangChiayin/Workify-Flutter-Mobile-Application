//import the services
const userService = require("../services/user.services");

//handle the service the user hired 
exports.hireService = async (req, res, next) => {
    try {
      const { email, serviceType, serviceDate } = req.body;
  
      const service = await userService.hireService(email, serviceType, serviceDate);
  
      res.json({
        status: true,
        success: "Service hired successfully",
        service,
      });
    } catch (error) {
      next(error);
    }
    console.error(error); //for debugginh
    return res.status(500).json({
      status: false,
      error: "An error occurred, please try again later"
    });
  };

exports.register = async(req,res,next)=>{
    try{
        const {email,password} = req.body;
        const { userID } = await userService.registerUser(email, password);
        
        res.status(200).json(
            {status: true, success: "User registered successfully", userID});
    }catch(error){0
         //if the response from the registerUser service is 'Email is already registered', send a status 400 to avoid crashing the server
    if (error.message === 'Email is already registered') {
        return res.status(400).json({
          status: false,
          error: "Email is already registered"
        });
    }
     //handlign any other error to avoid a crash
     console.error(error); //for debugginh
     return res.status(500).json({
       status: false,
       error: "An error occurred, please try again later"
     });
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