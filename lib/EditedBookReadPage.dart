import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test/BookReadPage.dart';

import 'EditedBookReading.dart';

class EditedBookPage extends StatelessWidget {
  final String ID;
  final String USER;

  EditedBookPage({required this.ID, required this.USER});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('edits').doc(ID).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error fetching data'));
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text('No data available'));
          }

          final bookData = snapshot.data?.data() as Map<String, dynamic>?;
          final bookName2 = bookData?['book_name'] as String?;
          final authorName2 = bookData?['author_name'] as String?;

          String bookName = bookName2.toString();
          String authorName = authorName2.toString();


          return Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 2,
                    color: Color.fromRGBO(34, 40, 98, 1),
                  ),
                  Positioned.fill(
                    top: MediaQuery.of(context).size.height / 10,
                    child: Center(
                      child: Image.asset(
                        'assets/images/book.png',
                        height: 200,
                        width: 200,
                      ),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height / 2,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(bottom: 20),
                      color: Color.fromRGBO(34, 40, 98, 1),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Text(
                        bookName,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.black, fontSize: 24),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      maxLines: 3,
                      authorName,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      textAlign: TextAlign.left,

                      style: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.5), fontSize: 18),
                    ),
                    Expanded(flex: 2, child: SizedBox(height: 150)),
                    Container(
                      width: MediaQuery.of(context).size.width - 40,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(241, 59, 58, 1),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: InkWell(
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditedBookReading(bookId: bookName, USER: USER), // Pass documentID to BookPage
                            ),
                          );
                        },
                        child: Center(
                          child: Text(
                            "Jetzt lesen",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,)
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
