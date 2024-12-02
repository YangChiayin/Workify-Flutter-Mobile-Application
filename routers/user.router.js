// we will create an API

const router = require('express').Router();

const userController = require("../controller/user.controller");


router.post('/registration',userController.register);

// Login endpoint
router.post('/login', userController.login);

// Hire a service
//router.post("/hireService", userController.hireService);

//router.post("/saveService", serviceController.saveService);

module.exports = router;