const mongoose = require('mongoose');

// Create the MongoDB connection
const connection = mongoose.createConnection('mongodb://localhost:27017/workifyDb')
  .on('open', () => {
    console.log("MongoDB connected");
  })
  .on('error', (err) => {
    console.error("MongoDB connection error:", err);
  });
module.exports = connection;