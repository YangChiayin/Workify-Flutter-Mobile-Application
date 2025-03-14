const serviceService = require("../services/service.services");
const ServiceModel = require("../model/service.model");
const UserModel = require("../model/user.model");

//save the hired service in the database
exports.saveService = async (req, res, next) => {
    try {
        const { email, serviceName, serviceDate } = req.body;

        // Save the service in the database
        const savedService = await serviceService.saveSelectedService(email, serviceName, serviceDate);
        //getting the data saved in the database, including the id for the service selected
        res.status(200).json({ status: true, success: "Service saved successfully", data:  
            {
            serviceId: savedService._id, // Include the generated serviceId
            serviceName: savedService.serviceName,
            serviceDate: savedService.serviceDate,
             userId: savedService.userID,
        },
    });
    } catch (error) {
        next(error); // Pass errors to the global error handler
    }
};

//save the issue description

exports.saveIssueDescription = async (req, res) => {
    try {
      const { serviceId, issueDescription } = req.body;
  
      // Find the service record and update the issue description
      const updatedService = await ServiceModel.findByIdAndUpdate(
        serviceId,
        { issueDescription },
        //remember to add this, return the updated document
        { new: true } 
      );
  
      res.status(200).json({ status: true,success: "Description saved successfully", data:   {
        serviceId: updatedService._id, // Include the generated serviceId
        serviceName: updatedService.serviceName,
        serviceDate: updatedService.serviceDate,
        userId: updatedService.userID,
        issueDescription: updatedService.issueDescription
    }, });
    } catch (error) {
      res.status(500).json({ status: false, error: error.message });
    }
  };

  //save the rest of the information in the database: 
  exports.saveCheckoutInfo = async (req, res) => {
    try {
      const { serviceId, address, ccNumber, promoCode} = req.body;
  
      // Find the service record and update the issue description
      const updatedService = await ServiceModel.findByIdAndUpdate(
        serviceId,
        { address, ccNumber, promoCode},
        //remember to add this, return the updated document
        { new: true } 
      );
  
      res.status(200).json({ status: true, data: updatedService });
    } catch (error) {
      res.status(500).json({ status: false, error: error.message });
    }
  };

    //save the rest of the information in the database: 
    exports.saveReviewInfo = async (req, res) => {
        try {
          const { serviceId, reviewDesc} = req.body;
      
          // Find the service record and update the issue description
          const updatedService = await ServiceModel.findByIdAndUpdate(
            serviceId,
            { reviewDesc },
            //remember to add this, return the updated document
            { new: true } 
          );
      
          res.status(200).json({ status: true, data: updatedService });
        } catch (error) {
          res.status(500).json({ status: false, error: error.message });
        }
      };

      //get the service Name usng the service ID as a parameter
      exports.getServiceNameById = async (req, res) => {
        try {
            const { serviceId } = req.params;
    
            // Find the service by ID
            const service = await ServiceModel.findById(serviceId, "serviceName");
    
            // If service is not found, return an error
            if (!service) {
                return res.status(404).json({ success: false, message: "Service not found" });
            }
    
            // Respond with the serviceName
            res.status(200).json({ success: true, data: { serviceName: service.serviceName } });
        } catch (error) {
            res.status(500).json({ success: false, error: error.message });
        }
    };


// Endpoint to get user email by service ID
//router.get("/service/:serviceID/email", async (req, res) => {
  exports.getEmailById = async (req, res) => {
  try {
    const { serviceId } = req.params;

    // Find the service by its ID
    const service = await ServiceModel.findById(serviceId);

    if (!service) {
      return res.status(404).json({ message: "Service not found" });
    }

    // Use the userID from the service to find the user
    const user = await UserModel.findOne({ userID: service.userID });

    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }

    // Return the user's email
    return res.json({ email: user.email });
  } catch (error) {
    console.error("Error retrieving email:", error);
    res.status(500).json({ message: "Internal Server Error" });
  }
};