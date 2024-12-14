import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'config.dart';

class SignupPage extends StatelessWidget {
  //i removed the const because I added the controllers
   SignupPage({super.key});

  // Create controllers to store the email and password input
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  //create a function to snd the email and password to backkend
  void registerUser(BuildContext context) async {
    print("registerUser was called");
    if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty){
      print("I got tothe loop");
        //we will create an object that we will send to our backend - this will be send in the req body
        var reqBody={
          "email": emailController.text,
          "password": passwordController.text
        };

        try {
          // this make a call to the backend and will get the response from the backend 
          var response = await http.post(
            Uri.parse(registration),
            //we need to define we are passing a json
            headers: {"Content-Type": "application/json"},
            body: jsonEncode(reqBody)
          );
          print("this is the line before the response");
          print(response);

          // Handle the response from the server
          // Modified response handling
          if (response.statusCode == 200 || response.statusCode == 201) { // Added 201 status
            // Show success message and navigate to login regardless of specific success message
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Success'),
                  content: const Text('Registration successful! Please login.'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close dialog
                        Navigator.pushReplacementNamed(context, '/login'); // Navigate to login
                      },
                      child: const Text('OK'),
                    ),
                  ],
                );
              },
            );
          } else {
            // Show error for non-200/201 status codes
            showErrorDialog(context, 'Error registering. Please try again later. Status: ${response.statusCode}');
            print("Response body: ${response.body}"); // Debug print to see actual response
          }
        } catch (e) {
          // Show error for any exceptions during the request
          showErrorDialog(context, 'An error occurred. Please try again later. Error: $e');
          print("Error: $e"); // Debug print for errors
        }
    } else {
      // Show error for empty fields
      showErrorDialog(context, 'Email and password cannot be empty');
      print("Email or password cannot be empty"); // Debug feedback
    }
  }

  // Function to show error dialog - similar to login page
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Workify',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            const Text(
              'Create an account',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Text(
              'Enter your email to sign up for this app',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            //I Rremoved the const to be able to save the input
            TextField(
               controller: emailController,
              style: const TextStyle(color: Colors.black),
              decoration: const InputDecoration(
                labelText: 'Email',
                hintText: 'email@domain.com',
                labelStyle: TextStyle(color: Colors.grey),
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1),
                ),
              ),
            ),
            const SizedBox(height: 16),
             TextField(
              controller: passwordController, // Attach the password controller
              obscureText: true,
              style: const TextStyle(color: Colors.black),
              decoration: const InputDecoration(
                labelText: 'Password',
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
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Handle login logic
                print("I pressed the button");
                registerUser(context); // Added context parameter

              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 10),
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
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(child: Divider(thickness: 1, color: Colors.grey[300])),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    'or',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ),
                Expanded(child: Divider(thickness: 1, color: Colors.grey[300])),
              ],
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: () {
                // Handle Google sign-in
              },
              icon: Image.asset(
                'assets/images/google_icon.png',
                width: 25,
              ),
              label: const Text(
                'Continue with Google',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.grey[200],
                padding: const EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                side: BorderSide.none,
              ),
            ),
            const SizedBox(height: 8),
            OutlinedButton.icon(
              onPressed: () {
                // Handle Apple sign-in
              },
              icon: const Icon(
                Icons.apple,
                size: 28,
                color: Colors.black,
              ),
              label: const Text(
                'Continue with Apple',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.grey[200],
                padding: const EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                side: BorderSide.none,
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 4,
                children: [
                  const Text(
                    'By clicking continue, you agree to our',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/terms');
                    },
                    child: const Text(
                      'Terms of Service',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Text(
                    'and',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/privacy');
                    },
                    child: const Text(
                      'Privacy Policy',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
