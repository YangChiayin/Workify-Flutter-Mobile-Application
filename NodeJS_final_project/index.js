const express = require('express');
const app = require('./app');
const cors = require('cors');

const db = require('./config/db');
//importing the user schema 
const UserModel = require('./model/user.model');
const ServiceMode = require('./model/service.model');

const port = 3000;

app.get('/',(req,res)=>{
    res.send("hello wold");
});
app.use(cors());

app.listen(port, () => {
    console.log(`Server listening on http://localhost:${port}`);
});