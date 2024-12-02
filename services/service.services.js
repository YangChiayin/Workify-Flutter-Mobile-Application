//this is for the service selected -plumbery, electritian, cleaning, flooring

const ServiceModel = require("../model/service.model");
const UserModel = require('../model/user.model');

class serviceService {
    // Save selected service and userID in the "service" table in the database
    static async saveSelectedService(email, serviceName, serviceDate) {
        try {
            // Optionally, find the user to validate the userId exists
            const user = await UserModel.findOne({ email });
            if (!user) {
                throw new Error("User not found");
            }

            // Create a new service record
            const newService = new ServiceModel({
                userID: user.userID,  // Store userId in the service record
                serviceName,
                serviceDate 
                    // Store the serviceName in the service record
            });

            return await newService.save();
        } catch (err) {
            throw err;
        }
    }

}

module.exports = serviceService;
