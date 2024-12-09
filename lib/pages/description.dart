import 'package:flutter/material.dart';
import 'config.dart';
import 'dart:convert'; // for jsonEncode
import 'package:http/http.dart' as http;

class DescriptionPage extends StatelessWidget {
  final String serviceID;
  //final String email; //receive the serviceID as a parameter, so I can use the API to save the description in the database
  // DescriptionPage({super.key, required this.serviceID, required this.email});
  DescriptionPage({super.key, required this.serviceID});

  final TextEditingController descController = TextEditingController();
//add the method to send the info to the database

  // API call method to send the description to the backend
  Future<void> sendDescription(BuildContext context, String serviceID) async {
    
    final String description = descController.text; // Get the description

    // Validate input
    if (description.isEmpty) {
      showErrorDialog(context, 'Description cannot be empty');
      return;
    }

    try {
      // Send POST request
      final response = await http.post(
        Uri.parse(descriptionInfo),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'serviceId': serviceID, 'issueDescription': description}),
      );

      if (response.statusCode == 200) {
          final result = jsonDecode(response.body);
          //getting the serviceID
          final serviceID = result['data']['serviceId'];
            if (result["status"]) {
              Navigator.pushNamed(
                  context,
                  '/checkout',
                  //i am passing so I can save the checkout info in the database - chec main.dart
                // arguments: serviceID
                arguments: {
                  'serviceID': serviceID,
                  'description': description,
                },
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Please add a description of your needs',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            //textbox to add the description
            // Multiline TextBox with padding
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextField(
                controller: descController,
                maxLines: 5, // Allow multiline input
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: 'Enter your description...',
                  contentPadding: const EdgeInsets.all(16.0), // Padding inside the textbox
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14),
            //button to continue to next screen
            ElevatedButton(
              onPressed: () {
                // Handle  logic
               sendDescription(context, serviceID);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Continue',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
          
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
                onPressed: () {
                   Navigator.pushNamed(
                  context,
                  '/servicesPage',
                  arguments: serviceID,
                );
                },
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
      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.only(bottom: 10, right: 10),
      //   child: FloatingActionButton.extended(
      //     backgroundColor: Colors.white,
      //     onPressed: () {},
      //     label: const Text('Chat'),
      //     icon: const Icon(Icons.chat),
      //   ),
      // ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
