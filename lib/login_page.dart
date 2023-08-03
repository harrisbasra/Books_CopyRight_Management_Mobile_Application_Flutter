import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test/HomePage.dart';
import 'package:test/sign_up.dart';

import 'message.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String username = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 90),
              Image.asset(
                'assets/images/img.png', // Replace 'assets/logo.png' with your logo path
                width: 110,
                height: 110,
              ),
              SizedBox(height: 20),
              Text(
                "Login",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 100),
              _buildTextField("Email", emailController),
              SizedBox(height: 15),
              _buildTextField("Passwort", passwordController),
              SizedBox(height: 20),
              Row(
                children: [
                  Checkbox(
                    value: false,
                    onChanged: (value) {},
                  ),
                  Text("Eingeloggt bleiben"),
                  Spacer(),
                  Text(
                    "Passwort vergessen ?",
                    style: TextStyle(color: Colors.blue),
                  ),
                ],
              ),
              SizedBox(height: 70),
              ElevatedButton(
                onPressed: () async {
                  final email = emailController.text.trim();
                  String E = "support@hypno-skript.com";
                  String P = "app#Jmm123!";
                  final password = passwordController.text.trim();
                  bool loginSuccess = await signInWithEmailPassword(email, password, context);
                  if(email.toString() == E){
                    if(password.toString() == P){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(isAdmin: true, username: 'Admin',)));
                    }
                  }
                  else if (loginSuccess) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(isAdmin: false, username: username,)));
                  }
                  else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Invalid email/username or password"),
                      ),
                    );
                  }
                },
                child: Container(
                  width: 120,
                  height: 50,
                  child: Center(
                    child: Text(
                      "Zu den Texten",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(241, 59, 58, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              SizedBox(height: 15,),
              InkWell(
                onTap: () {
    //                 recognizer: TapGestureRecognizer()..onTap = ( ) async {
    // var ur I "https:
    // if(await canLaunch(url)
    // await launch(url);
    // throw "Cannot load Uri" •
    // 1
                },
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan( text: "Die ",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black, // You can change the color if needed
                        ),),
                      TextSpan( text: "Datenschutzerklärung",
                        recognizer: TapGestureRecognizer()..onTap = () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => PrivacyPolicyPage()));
                        },
                        style: TextStyle(
                          fontSize: 12,
                          color: Color.fromRGBO(241, 59, 58, 1), // You can change the color if needed
                        ),),
                      TextSpan( text: " habe ich gelesen und bin damit einverstanden",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black, // You can change the color if needed
                        ),),
                    ],

                ),
    ),

    ),
              SizedBox(height: 70),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
                },
                child: Text(
                  "Neu hier? Hier registrieren",
                  style: TextStyle(fontSize: 12),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String heading, TextEditingController controller) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black.withOpacity(0.5), width: 1),
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: heading,
          border: InputBorder.none,
          hintStyle: TextStyle(fontSize: 15),
        ),
      ),
    );
  }

  Future<bool> signInWithEmailPassword(String email, String password, BuildContext context) async {
    try {
      // Initialize Firebase if it's not already initialized
      await Firebase.initializeApp();

      // Get a reference to the "users" collection in Firestore
      final usersRef = FirebaseFirestore.instance.collection('users');

      // Query the Firestore collection for the provided email/username
      final querySnapshot = await usersRef.where('email', isEqualTo: email).limit(1).get();

      // Check if the email/username exists in Firestore
      if (querySnapshot.docs.isEmpty) {
        // Email/username not found in Firestore
        return false;
      }

      // Extract the document data and check the password
      final userData = querySnapshot.docs.first.data();
      if (userData['password'] == password) {
        // Password matches, authentication successful
        if(userData['valid']==true){
          username = userData['name'];

          return true;
        }
        else{
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Give us a moment we are reviewing your registration"),
            ),
          );
        }
        return false;
      } else {

        return false;
      }
    } catch (e) {
      // Handle any errors that may occur during the process (e.g., Firebase initialization, Firestore queries, etc.)
      print('Error during login: $e');
      return false;
    }
  }
}
