const express = require('express');
const cors = require('cors');
const body_parser = require('body-parser');

//import npm 
const userRouter = require('./routers/user.router');
const serviceRouter = require('./routers/service.router'); // Import the new router


const app = express();
app.use(body_parser.json());
app.use(cors());

app.use('/',userRouter);
app.use('/services', serviceRouter); // Add the service router

app.use(express.json());

module.exports = app;
