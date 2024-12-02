import 'package:flutter/material.dart';
import 'package:mobile_app_final_project/pages/description.dart';
import 'package:mobile_app_final_project/pages/detail.dart';
import 'package:mobile_app_final_project/pages/login.dart';
import 'package:mobile_app_final_project/pages/review.dart';
import 'package:mobile_app_final_project/pages/servicesPage.dart';
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
        '/detail': (context) => const DetailPage(),
     //   '/description': (context) => DescriptionPage(),
        '/checkout': (context) => DetailPage() //update this with Arsh screen 
        

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
            return MaterialPageRoute(
            builder: (context) => DescriptionPage(serviceID: serviceID), // Pass the serviceID to the DescriptionPage
          );
        }
         if(settings.name == '/review'){
            final serviceID = settings.arguments as String;
            return MaterialPageRoute(
            builder: (context) => ReviewPage(serviceID: serviceID), // Pass the serviceID to the reviewPage
          );
        }
        },

        
      debugShowCheckedModeBanner: false,
    );
  }
}