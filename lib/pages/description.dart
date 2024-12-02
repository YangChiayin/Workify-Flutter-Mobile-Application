import 'package:flutter/material.dart';
import 'config.dart';
import 'dart:convert'; // for jsonEncode
import 'package:http/http.dart' as http;

class DescriptionPage extends StatelessWidget {
  final String serviceID; //receive the serviceID as a parameter, so I can use the API to save the description in the database
  DescriptionPage({super.key, required this.serviceID});

  final TextEditingController descController = TextEditingController();
//add the method to send the info to the database

  // API call method to send the description to the backend
  Future<void> sendDescription(BuildContext context, String serviceID) async {
    
    final String description = descController.text; // Get the description

    // Validate input
    if (description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Description cannot be empty')),
      );
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
              // Navigator.pushNamed(
              //     context,
              //     '/review',
              //     //i am passing so I can save the checkout info in the database - chec main.dart
              //     arguments: serviceID
              //   );
               Navigator.pushNamed(context, '/detail'); 
            }
        // Navigate to the next screen upon success
       
        } else {
        // Handle server error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to send description: ${response.body}')),
        );
        }
    } catch (error) {
      // Handle network or other errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () {},
        ),
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
            SizedBox(
              //using % of the screen to make it responsive
              width: MediaQuery.of(context).size.width * 0.8,
            child: TextField(
              //here I will add the controller
              controller: descController, 
           //   obscureText: true,
              style: const TextStyle(color: Colors.black),
              decoration: const InputDecoration(
                //labelText: 'Pa',
                contentPadding: EdgeInsets.symmetric(vertical: 80.0),
                labelStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 2),
                
                ),
                
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1),
                ),
              ),
            ),
            ),
            const SizedBox(height: 14),
            //button to continue to next screen
            ElevatedButton(
              onPressed: () {
                // Handle login logic
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
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10, right: 10),
        child: FloatingActionButton.extended(
          backgroundColor: Colors.white,
          onPressed: () {},
          label: const Text('Chat'),
          icon: const Icon(Icons.chat),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
