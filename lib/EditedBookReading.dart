import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'BookEditPage.dart';
import 'EditsEditPage.dart';

class EditedBookReading extends StatefulWidget {
  final String bookId;
  final String USER;
  EditedBookReading({required this.bookId, required this.USER});

  @override
  _EditedReadBookPageState createState() => _EditedReadBookPageState();
}

class _EditedReadBookPageState extends State<EditedBookReading> {
  String bookName = "";
  String bookText = "";
  String bookID = "";
  String EditID = "";

  @override
  void initState() {
    super.initState();
    _fetchBookData();
  }

  Future<void> _fetchBookData() async {
    try {
      final firestore = FirebaseFirestore.instance;

      print("widget.bookId: $widget.bookId");
    QuerySnapshot editsSnapshot = await firestore
        .collection('edits')
        .where('book_name', isEqualTo: widget.bookId)
        .where('user_name', isEqualTo: widget.USER)
        .get();

    print(bookName);
      print(widget.USER);

    EditID = editsSnapshot.docs.first.id;

      final DocumentSnapshot doc = await FirebaseFirestore.instance.collection('edits').doc(EditID).get();
      setState(() async {
        bookName = doc['book_name'];
        bookText = doc['text'];
        bookID = widget.bookId;
        //......................................................................
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditsEditPage(text: bookText, ID: EditID, USER: widget.USER), // Pass documentID to BookPage
          ),
        );

      });
    } catch (e) {
      print('Error fetching book data: $e');

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Read Book'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              bookName,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 2.0, // Adjust the width as needed
                ),
                borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
              ),
              child: Container(
                padding: EdgeInsets.all(8.0), // Add padding to separate text from the border
                child: Text(
                  bookText,
                  maxLines: 100,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            )

          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 20),
        child: Container(
          color: Colors.transparent,
          child: ElevatedButton(
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditsEditPage(text: bookText, ID: EditID, USER: widget.USER),
                ),
              );
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
                  "Edit Text",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
