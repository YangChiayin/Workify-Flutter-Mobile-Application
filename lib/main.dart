import 'package:flutter/material.dart';
import 'package:mobile_app_final_project/pages/description.dart';
import 'package:mobile_app_final_project/pages/detail.dart';
import 'package:mobile_app_final_project/pages/login.dart';
import 'package:mobile_app_final_project/pages/review.dart';
import 'package:mobile_app_final_project/pages/servicesPage.dart';
import 'package:mobile_app_final_project/pages/signup.dart';
import 'package:mobile_app_final_project/pages/checkout.dart';
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
       '/detail': (context) => const DetailPage(),
      },
      // Handle the route for ServicesPage with email
      
        onGenerateRoute: (settings) {
        
        if (settings.name == '/servicesPage') {
          final email = settings.arguments as String;
          return MaterialPageRoute(
            builder: (context) => ServicesPage(email: email), // Pass the email to the ServicesPage
          );
        }
        if(settings.name == '/description'){
            final serviceID = settings.arguments as String;
            // final email = settings.arguments as String;
            return MaterialPageRoute(
            builder: (context) => DescriptionPage(serviceID: serviceID), // Pass the serviceID to the DescriptionPage
          );
        }
  
        if (settings.name == '/checkout') {
          final args = settings.arguments as Map<String, dynamic>; // Use a Map for multiple arguments
          final serviceID = args['serviceID'] as String;
          final description = args['description'] as String;
          
          return MaterialPageRoute(
            builder: (context) => Checkout(serviceID: serviceID, description: description), // Pass the parameters to the Checkout page
          );
        }
      //   if(settings.name == '/detail'){
      //       final serviceID = settings.arguments as String;
      //       return MaterialPageRoute(
      //       builder: (context) => DetailPage(), // Pass the serviceID to the reviewPage
      //     );
      //  }
         if(settings.name == '/review'){
            final serviceID = settings.arguments as String;
            return MaterialPageRoute(
            builder: (context) => ReviewPage(serviceID: serviceID), // Pass the serviceID to the reviewPage
          );
        }
         return null;
        },     
      debugShowCheckedModeBanner: false,
    );
  }
}