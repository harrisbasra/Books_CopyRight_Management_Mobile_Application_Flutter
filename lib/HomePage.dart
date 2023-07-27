import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:test/RequestsPage.dart';

import 'BookPage.dart';
import 'EditedBookReadPage.dart';

String USER = "";
class HomePage extends StatelessWidget {
   String username = "John Doe"; // Replace with the actual username
   bool isAdmin = false;


  HomePage({required this.username, required this.isAdmin}) {
    USER = username;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40,),
              Row(
                children: [
                  Text(
                    'Hello, $username',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Expanded(child: SizedBox(width: 10)),
                Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Container(

                    child: Icon(Icons.logout),
                  ),
                ),
              ),


                ],
              ),


              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Type book name here',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                '“Original Texte',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              ShowBook(
                // bookNames: bookNames,
                // authorNames: authorNames,
              ), // Call the ShowBook class here
              SizedBox(height: 5),
              Text(
                '“Bearbeitete Texte”',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              ShowEdits(
                // bookNames: bookNames,
                // authorNames: authorNames,
              ) // Call the ShowBook class here
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                // Implement the home button functionality here
              },
            ),
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                if(isAdmin==true){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RequestsPage(), // Pass documentID to BookPage
                    ),
                  );
                }
                else{
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Only Admin Can Access This Feature"),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}


class ShowBook extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CollectionReference booksCollection =
    FirebaseFirestore.instance.collection('books');

    return StreamBuilder<QuerySnapshot>(
      stream: booksCollection.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        List<QueryDocumentSnapshot<Object?>>? books = snapshot.data?.docs;

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: books!.map((book) {
              String bookName = book['book_name'];
              String authorName = book['author_name'];

              return GestureDetector( // Wrap the Container with GestureDetector
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookPage(ID: book.id, USER : USER ), // Pass documentID to BookPage
                    ),
                  );
                },
                child: Container(
                  width: 100,
                  height: 200,
                  margin: EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(34, 40, 98, 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.asset(
                          'assets/images/book.png',
                          width: 50,
                          height: 50,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        bookName,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        authorName,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}

class ShowEdits extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    CollectionReference editsCollection =
    FirebaseFirestore.instance.collection('edits');

    return StreamBuilder<QuerySnapshot>(
      stream: editsCollection.where('user_name', isEqualTo: USER).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        List<QueryDocumentSnapshot<Object?>>? books = snapshot.data?.docs;

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: books!.map((book) {
              String bookName = book['book_name'];
              String authorName = book['author_name'];

              return GestureDetector( // Wrap the Container with GestureDetector
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditedBookPage(ID: book.id, USER: book['user_name']),
                    ),
                  );
                },
                child: Container(
                  width: 100,
                  height: 200,
                  margin: EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(34, 40, 98, 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.asset(
                          'assets/images/book.png',
                          width: 50,
                          height: 50,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        bookName,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        authorName,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
