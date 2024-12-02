import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert'; 
import 'config.dart';

//I changed to a statefullWiget so I can have the search bar
class ServicesPage extends StatelessWidget {
   final String email; // Receive email as a parameter
  const ServicesPage({super.key, required this.email});

//save the info in the database
void saveServiceToDatabase(BuildContext context, String serviceName, String email) async {
  try {
    final response = await http.post(
      Uri.parse(userInfo),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email, // User's email
        "serviceName": serviceName, // Name or type of the service
        //remember json doesnt accept datetime so we need to convert it to string
        "serviceDate": DateTime.now().toIso8601String(), 
      }),
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      //getting the serviceID
       final serviceID = result['data']['serviceId'];
      if (result["status"]) {
         Navigator.pushNamed(
            context,
            '/description',
            //i am passing so I can save the description in the database - chec main.dart
            arguments: serviceID
          );
        // Service saved successfully
        // showErrorDialog(context, 'Service saved successfully!');
      
      } else {
         showErrorDialog(context, 'Failed to save service');
      }
    } else {
        showErrorDialog(context, 'Error: ${response.reasonPhrase}');
    }
  } catch (e) {
        showErrorDialog(context, 'Error: $e');
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
            ),
          body:  ListView(
          children: [
            // "Emergency" Section Title
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Emergency",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
             //List of services
              const Padding(padding: EdgeInsets.all(16.0)), //add space
              //add round image
              ListTile(  
                  leading: const CircleAvatar(
                  radius: 48, // Image radius
                  backgroundImage: NetworkImage('assets/images/electrician.jpg'),
                ),
                title: const Text("Electrician"),
                onTap: () {
                    saveServiceToDatabase(context, "Electrician", email);
                  },
                  ),
                  

              const Padding(padding: EdgeInsets.all(16.0)),
              //add round image
              ListTile(
                leading: const CircleAvatar(
                  radius: 48, // Image radius
                  backgroundImage: NetworkImage('assets/images/cleaning.jpg'),
                ),
                title: const Text("Cleaning"),
                onTap: () {
                    saveServiceToDatabase(context, "Cleaning", email);
                  },),

              const Padding(padding: EdgeInsets.all(16.0)),
              //add round image
              ListTile(
                leading: const CircleAvatar(
                  radius: 48, // Image radius
                  backgroundImage: NetworkImage('assets/images/plumbing.jpg'),
                ),
                title: const Text("Plumbing"),
                onTap: () {
                    saveServiceToDatabase(context, "Plumbing", email);
                },
                ),

              const Padding(padding: EdgeInsets.all(16.0)),
              //add round image
              ListTile(
                leading: const CircleAvatar(
                  radius: 48, // Image radius
                  backgroundImage: NetworkImage('assets/images/flooring.jpg'),
                ),
                title: const Text("Flooring"),
                  onTap: () {
                    saveServiceToDatabase(context, "Flooring", email);
                  },
                ),
              ]
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
      
        // @override
        // State<StatefulWidget> createState() {
        //   // TODO: implement createState
        //   throw UnimplementedError();
        // }
}