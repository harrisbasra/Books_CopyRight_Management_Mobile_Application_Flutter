import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

bool Check = false;
class EditsEditPage extends StatelessWidget {
  String text;
  String ID;
  String USER;
  final controller = TextEditingController();

  EditsEditPage({required this.text, required this.ID, required this.USER}) {
    controller.text = text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit your Version",
          textAlign: TextAlign.center,
          style: TextStyle(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 10,),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextField(
                    controller: controller,
                    maxLines: null, // Allow multiple lines
                    decoration: const InputDecoration(
                      border: InputBorder.none, // Hide default border inside the container
                      hintText: 'Enter your text here', // Placeholder text
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 20),
        child: Container(
          color: Colors.transparent,
          child: ElevatedButton(
            onPressed: () {
              // Perform the book search and save logic here
              _saveEditedVersion();
              if(Check){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Version Saved Successfully"),
                  ),
                );
              }
              else{
                // ScaffoldMessenger.of(context).showSnackBar(
                //   SnackBar(
                //     content: Text("Some Error Occurred"),
                //   ),
                // );
              }
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              primary: Color.fromRGBO(241, 59, 58, 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: Container(
              width: 120,
              height: 50,
              child: const Center(
                child: Text(
                  "Speichern",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _saveEditedVersion() async {

    // Initialize Firestore if not already initialized
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp();
    }


    // Get a reference to the Firestore instance
    final firestore = FirebaseFirestore.instance;
    print("IDDDD: $ID");

    // Search for the book_name and author_name using the provided bookID
    DocumentSnapshot bookSnapshot = await firestore.collection('edits').doc(ID).get();

    if (bookSnapshot.exists) {
      String bookName = bookSnapshot.get('book_name');
      String authorName = bookSnapshot.get('author_name');
      print("HEHE1");
      // Get the edited text from the text field
      String editedText = controller.text;

      // Check if the user has already edited the book
      QuerySnapshot editsSnapshot = await firestore
          .collection('edits')
          .where('book_name', isEqualTo: bookName)
          .where('author_name', isEqualTo: authorName)
          .where('user_name', isEqualTo: USER)
          .get();
      print("HEHE2");
      if (editsSnapshot.docs.isNotEmpty) {

        print("HEHE3");

        // If the user has already edited the book, update the existing document
        String editDocId = editsSnapshot.docs.first.id;
        await firestore.collection('edits').doc(editDocId).update({
          'text': editedText,
        });
      } else {
        // If the user has not edited the book previously, create a new document
        await firestore.collection('edits').add({
          'book_name': bookName,
          'author_name': authorName,
          'text': editedText,
          'user_name': USER,
        });
      }

      Check = true;
    } else {
      // Show a snackbar or display a message to indicate that the book was not found
      Check = false;
    }
  }
}
