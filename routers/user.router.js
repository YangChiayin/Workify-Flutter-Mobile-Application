// we will create an API

const router = require('express').Router();

const userController = require("../controller/user.controller");

router.post('/registration',userController.register);

// Login endpoint
router.post('/login', userController.login);

module.exports = router;