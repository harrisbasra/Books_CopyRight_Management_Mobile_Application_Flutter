import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test/login_page.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                "Nutzer anlegen",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 100),
              _buildTextField("Email", _emailController),
              SizedBox(height: 15),
              _buildTextField("Nutzername", _usernameController),
              SizedBox(height: 15),
              _buildTextField("Passwort", _passwordController),
              SizedBox(height: 70),
              ElevatedButton(
                onPressed: _registerUser,
                child: Container(
                  width: 120,
                  height: 50,
                  child: Center(
                    child: Text(
                      "Profil erstellen",
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
              SizedBox(height: 80),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                },
                child: Text(
                  "Du hast schon einen Account? Hier zum Login",
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

  void _registerUser() async {
    String email = _emailController.text.trim();
    String username = _usernameController.text.trim();
    String password = _passwordController.text;

    if (email.isEmpty || username.isEmpty || password.isEmpty) {
      _showSnackBar("Please fill in all fields.");
      return;
    }

    // Check if email or username is already in use
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('users')
        .where('email', isEqualTo: email)
        .where('name', isEqualTo: username)
        .get();


    if (querySnapshot.docs.isNotEmpty) {
      for (var doc in querySnapshot.docs) {
        var data = doc.data() as Map<String, dynamic>;
        if (data['email'] == email) {
          _showSnackBar("Email is already in use.");
          return;
        } else if (data['name'] == username) {
          _showSnackBar("Username is already in use.");
          return;
        }
      }
    }

    // If email and username are unique, register the user
    await FirebaseFirestore.instance.collection('users').add({
      'email': email,
      'name': username,
      'password': password,
      'valid': false, // Assuming you want to set 'valid' to false initially
    });

    // Registration success, show a success message and navigate to Home Page
    _showSnackBar("Registration successful!");
    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
