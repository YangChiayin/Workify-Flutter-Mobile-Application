const app = require('./app');

const db = require('./config/db');
//importing the user schema 
const UserModel = require('./model/user.model');

const port = 3000;

app.get('/',(req,res)=>{
    res.send("hello wold");
});

app.listen(port, () => {
    console.log(`Server listening on http://localhost:${port}`);
});