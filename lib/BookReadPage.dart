import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'BookEditPage.dart';

class ReadBookPage extends StatefulWidget {
  final String bookId;
  final String USER;
  ReadBookPage({required this.bookId, required this.USER});

  @override
  _ReadBookPageState createState() => _ReadBookPageState();
}

class _ReadBookPageState extends State<ReadBookPage> {
  String bookName = "";
  String bookText = "";
  String bookID = "";

  @override
  void initState() {
    super.initState();
    _fetchBookData();
  }

  Future<void> _fetchBookData() async {
    try {
      final DocumentSnapshot doc =
      await FirebaseFirestore.instance.collection('books').doc(widget.bookId).get();
      setState(() {
        bookName = doc['book_name'];
        bookText = doc['text'];
        bookID = widget.bookId;
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
                  builder: (context) => BookEditPage(text: bookText, ID: bookID, USER: widget.USER),
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
