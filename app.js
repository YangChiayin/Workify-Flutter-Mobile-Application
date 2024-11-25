const express = require('express');
const cors = require('cors');
const body_parser = require('body-parser');

//import 
const userRouter = require('./routers/user.router');

const app = express();
app.use(body_parser.json());

app.use('/',userRouter);
app.use(express.json());
app.use(cors());
module.exports = app;
