import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_app_final_project/pages/config.dart';
import 'package:mobile_app_final_project/pages/const/const.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Checkout extends StatefulWidget {
  final String serviceID;
  final String description;
  const Checkout({super.key, required this.serviceID, required this.description});

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {

  //controllers to get the info from the user 
  final TextEditingController addressController = TextEditingController();
  final TextEditingController creditCardController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();
  final TextEditingController expirationDateController = TextEditingController();
  final TextEditingController promoCodeController = TextEditingController();
  


  String? serviceName;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchServiceName();
  }

  Future<void> fetchServiceName() async {
    final apiUrl = '${getServiceName}/${widget.serviceID}';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        setState(() {
          serviceName = jsonData['data']['serviceName'];
          isLoading = false;
        });
      } else {
        setState(() {
          serviceName = "Service not found";
          isLoading = false;
        });
      }
    } catch (error) {
      setState(() {
        serviceName = "Error fetching service";
        isLoading = false;
      });
    }
  }

  
  // API call method to send the description to the backend
  Future<void> sendCheckoutInfo(BuildContext context, String serviceID) async {
    
    final String address = addressController.text; // Get the description
    final String ccNumber = creditCardController.text;
    final String cvv = cvvController.text;
     final String expDate = expirationDateController.text;
     final String promoCode = promoCodeController.text;


    // Validate input
    if (address.isEmpty) {
      showErrorDialog(context, 'Address cannot be empty');
      return;
    }

    if (ccNumber.isEmpty || cvv.isEmpty || expDate.isEmpty) {
      showErrorDialog(context, 'Enter all the credit card info');
      return;
    }


    try {
      // Send POST request
      final response = await http.post(
        Uri.parse(checkoutInfo),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'serviceId': serviceID, 'address': address, 'ccNumber': ccNumber, 'promoCode': promoCode}),
      );

      if (response.statusCode == 200) {
          final result = jsonDecode(response.body);
          //getting the serviceID
        //  final serviceID = result['data']['serviceId'];
            if (result["status"]) {
              Navigator.pushNamed(
                  context,
                  '/detail',
                  arguments: serviceID,
                );
              // Navigator.pushNamed(context, '/detail'); 
            }
        // Navigate to the next screen upon success
       
        } else {
        // Handle server error
        showErrorDialog(context, 'Failed to send description: ${response.body}');
        }
    } catch (error) {
      // Handle network or other errors
      showErrorDialog(context, 'Error: $error');
      
    }
  }

  void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        // leading: IconButton(
        //   icon: const Icon(Icons.menu, color: Colors.black),
        //   onPressed: () {},
        // ),
        title: const Text(
          'Description',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Address Section with TextField
                      const Text(
                        "Delivery Address",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      TextField(
                        controller: addressController,
                        decoration: const InputDecoration(
                          hintText: "Enter your address",
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                        ),
                      //  maxLines: 1,
                      ),
                       const SizedBox(height: 24),

                      // Payment Section
                     
                      // Credit Card Number Section
                      const Text(
                        "Credit Card Number",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      TextField(
                        controller: creditCardController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          hintText: "Enter your credit card number",
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                        ),
                        maxLength: 16, // Limit input to 16 digits
                        inputFormatters: [
                          // Add space every 4 digits for better readability
                          // Useful for credit card formatting
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(16),
                        ],
                      ),
                 //     const SizedBox(height: 16),

                      // CVV Section
                      const Text(
                        "CVV",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      TextField(
                        controller: cvvController,
                        obscureText: true,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          hintText: "Enter CVV",
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                        ),
                        maxLength: 3, // CVV is typically 3 digits
                      ),
                   //   const SizedBox(height: 16),

                      // Expiration Date Section
                      const Text(
                        "Expiration Date (MMYY)",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      TextField(
                        controller: expirationDateController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          hintText: "MMYY",
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                        ),
                        maxLength: 4, // Format MM/YY
                      ),
                      const SizedBox(height: 20),

                      // Promos Section
                          const Text(
                        "Promo Code",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      TextField(
                        controller: promoCodeController,
                        decoration: const InputDecoration(
                          hintText: "Enter the promo code",
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Divider(),
                     // const SizedBox(height: 20),
                     //cart info
                      const Text(
                        "Items in your cart",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                        Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Service Name", style: TextStyle(fontSize: 16)),
                                Text(serviceName ?? "Loading...", style: TextStyle(fontSize: 16)),
                              //  const Text("$serviceCost", style: TextStyle(fontSize: 16)),
                              ],
                            ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Description", style: TextStyle(fontSize: 16)),
                            Flexible( // Use Flexible to allow wrapping
                              child: Text(
                                widget.description,
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                            //description
                        // Row(
                        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //       children: [
                        //         Text("Description", style: TextStyle(fontSize: 16)),
                        //         Text(serviceName ?? "Loading...", style: TextStyle(fontSize: 16)),
                        //       //  const Text("$serviceCost", style: TextStyle(fontSize: 16)),
                        //       ],
                        //     ),      
                      // ListTile(
                        
                      //   title: Text(serviceName ?? "Loading..."),
                      //   subtitle: const Text("Standard Fee\nInitial visit and assessment"),
                      //   trailing: Text("$serviceCost", style: const TextStyle(fontWeight: FontWeight.bold)),
                      // ),
                      const Divider(),

                      // Subtotal, Taxes, and Total
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Subtotal", style: TextStyle(fontSize: 16)),
                                Text("$serviceCost", style: TextStyle(fontSize: 16)),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Taxes", style: TextStyle(fontSize: 16)),
                                Text("$taxRate", style: TextStyle(fontSize: 16)),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total",
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "$subTotal",
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16), // Ensure there's space at the bottom
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                                 sendCheckoutInfo(context, widget.serviceID);
                              // Handle login logic
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Place Order',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                    ],
                  ),
                ),
              ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Container(
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Colors.grey,
                width: 1.0,
              ),
            ),
          ),
          height: 70,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.home, size: 30),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.explore, size: 30),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.shopping_cart, size: 30),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.notifications, size: 30),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.person, size: 30),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
