const url = 'http://10.0.0.165:3000/';
//for the registration
//the route is the url + the name of the route added in the backend 
const registration = "${url}registration";

//for the login
const login = "${url}login";

//save the service in the database
const userInfo = "${url}services/saveService";

const descriptionInfo = "${url}services/saveIssueDescription";

const checkoutInfo = "${url}services/saveCheckoutInfo";

const reviewInfo = "${url}services/saveReviewInfo";

const getServiceName = "${url}services/getServiceNameById"; //in the checkout screen we will pass the service ID

