import 'package:flutter/material.dart';
import 'config.dart';
import 'dart:convert'; // for jsonEncode
import 'package:http/http.dart' as http;

class ReviewPage extends StatelessWidget {
  final String serviceID; //receive the serviceID as a parameter, so I can use the API to save the description in the database
 ReviewPage({super.key, required this.serviceID});

  final TextEditingController reviewDescController = TextEditingController();
//add the method to send the info to the database

  // API call method to send the description to the backend
  Future<void> sendReview(BuildContext context, String serviceID) async {
    
    final String reviewDesc = reviewDescController.text; // Get the description

    // // Validate input
    // if (reviewDesc.isEmpty) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(content: Text('')),
    //   );
    //   return;
    // }

    try {
      // Send POST request
      final response = await http.post(
        Uri.parse(reviewInfo),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'reviewDesc': reviewDesc}),
      );

      if (response.statusCode == 200) {
        // Navigate to the next screen upon success
        Navigator.pushNamed(context, '/servicePage'); 
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
        title: const Text(
          'Review',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Review',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            //textbox to add the description
             SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextField(
                controller: reviewDescController,
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
                // Handle login logic
               sendReview(context, serviceID);
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
      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.only(bottom: 10, right: 10),
      //   child: FloatingActionButton.extended(
      //     backgroundColor: Colors.white,
      //     onPressed: () {},
      //     label: const Text('Chat'),
      //     icon: const Icon(Icons.chat),
      //   ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
