import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'login_page.dart';

class main_enterance extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          color: Color.fromRGBO(34, 40, 98, 1.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset(
                    'assets/images/img.png',
                    width: 190,
                    height: 190,
                  ),
                ),
                SizedBox(height: 80),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginPage()));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Zum Login",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.grey,
                          radius: 20,
                          child: Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }

}