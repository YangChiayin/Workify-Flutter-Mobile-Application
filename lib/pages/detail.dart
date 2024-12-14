import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mobile_app_final_project/pages/config.dart';


class DetailPage extends StatelessWidget {
   final String serviceID;
  const DetailPage({super.key, required this.serviceID});

  // Function to fetch the email
  Future<String> fetchEmail(String serviceID) async {
    try {
      final response = await http.get(Uri.parse('$getEmail/$serviceID'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['email']; 
      } else {
        throw Exception('Failed to fetch email');
      }
    } catch (e) {
      return 'Error: $e';
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
       // Retrieve the serviceID from arguments
   
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Worker Details',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Worker name: John Smith',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Arrival Time: 4:00 PM ',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 14),
            //button to continue to next screen
            ElevatedButton(
             onPressed: () async {
                try {
                  // Fetch email and store it in a variable
                  final email = await fetchEmail(serviceID);
                  print('Fetched Email: $email');
                  // Navigate to the next screen and pass the email
                     Navigator.pushNamed(
                        context,
                        '/servicesPage',
                         arguments: email,
                      );
                } catch (e) {
                  // Handle error if the fetch fails
                   showErrorDialog(context, 'Error: $e');
                }
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
