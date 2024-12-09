//model: this is for the service selected -plumbery, electritian, cleaning, flooring

const mongoose = require("mongoose");
const db = require('../config/db');

const { Schema } = mongoose;

// Define schema for services
const serviceSchema = new Schema({
    userID: {
        type: String,
        required: true,
      },
    serviceName: {
        type: String,
        required: true,
    },
    createdAt: {
        type: Date,
        default: Date.now,
    },
    issueDescription: {
        type: String,
        required: false
    },
    address: {
        type: String,
        required: false
    },
    ccNumber: {
      type: String,
      required: false
    },
      promoCode: {
        type: String,
        required: false
    },
      reviewDesc: {
        type: String,
        required: false
    }
});

const ServiceModel = db.model("service", serviceSchema);

module.exports = ServiceModel;
