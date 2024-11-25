import 'package:flutter/material.dart';
import 'package:mobile_app_final_project/pages/detail.dart';
import 'package:mobile_app_final_project/pages/login.dart';
import 'package:mobile_app_final_project/pages/signup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/signup': (context) => SignupPage(),
        '/detail': (context) => const DetailPage()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}