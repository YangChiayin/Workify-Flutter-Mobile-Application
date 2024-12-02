const router = require("express").Router();
const serviceController = require("../controller/service.controller");

// endpoint to save selected service
router.post("/saveService", serviceController.saveService);
// endpoint to save issue description
router.post("/saveIssueDescription", serviceController.saveIssueDescription);
//endpoint to save the checkout info
router.post("/saveCheckoutInfo", serviceController.saveCheckoutInfo);

//endpoint to save the checkout info
router.post("/saveReviewInfo", serviceController.saveReviewInfo);
module.exports = router;
