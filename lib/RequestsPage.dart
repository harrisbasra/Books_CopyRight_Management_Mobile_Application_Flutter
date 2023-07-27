import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RequestsPage extends StatelessWidget {
  void _acceptUser(String userId) {
    FirebaseFirestore.instance.collection('users').doc(userId).update({
      'valid': true,
    }).then((value) {
      // Success: Data updated
      print('User $userId accepted.');
    }).catchError((error) {
      // Error handling
      print('Error accepting user $userId: $error');
    });
  }

  void _denyUser(String userId) {
    FirebaseFirestore.instance.collection('users').doc(userId).delete().then((value) {
      // Success: Document deleted
      print('User $userId denied.');
    }).catchError((error) {
      // Error handling
      print('Error denying user $userId: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Einstellungen"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').where('valid', isEqualTo: false).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          List<User> userList = [];
          snapshot.data!.docs.forEach((doc) {
            userList.add(User(
              id: doc.id,
              name: doc['name'],
              valid: doc['valid'],
              email: doc['email'],
              password: doc['password'],
            ));
          });

          return ListView.builder(
            itemCount: userList.length,
            itemBuilder: (context, index) {
              final user = userList[index];
              return UserRow(
                user: user,
                onAccept: () => _acceptUser(user.id),
                onDeny: () => _denyUser(user.id),
              );
            },
          );
        },
      ),
    );
  }
}



class UserRow extends StatelessWidget {
  final User user;
  final void Function() onAccept;
  final void Function() onDeny;

  UserRow({required this.user, required this.onAccept, required this.onDeny});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
            color: Colors.grey, // Set the background color to grey
            child: Theme(
            data: ThemeData(
            primaryColor: Colors.grey, // Set the text color to grey
            textTheme: TextTheme(
            // Customize the text color for ListTile
            subtitle1: TextStyle(color: Colors.white), // Adjust the color to your preference
        ),
        ),
          child: ListTile(
            leading: Text(user.name, style: TextStyle(fontSize: 20),),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.check),
                  onPressed: onAccept,
                ),
                IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: onDeny,
                ),
              ],
            ),
          ),
        )
        ),
      ),
    );
  }
}

class User {
  final String name;
  final String id;
  final String password;
  final String email;
  bool valid;

  User({required this.id, required this.password, required this.name, required this.valid, required this.email });
}

