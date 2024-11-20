import 'package:flutter/material.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

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
            const TextField(
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
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
            const TextField(
              obscureText: true,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
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
