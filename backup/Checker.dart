import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test/main.dart';


class Checker extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              // Handle back button press
            },
          ),
          title: Center(
            child: Text(
              'Checker',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                       // Navigator.push(context, MaterialPageRoute(builder: (context)=> MyHomePage()));
                      },
                      child: Text('Main'),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                       // Navigator.push(context, MaterialPageRoute(builder: (context)=> otp_page()));
                      },
                      child: Text('OTP Page'),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        //Navigator.push(context, MaterialPageRoute(builder: (context)=> success_page()));
                      },
                      child: Text('Success Page '),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        //Navigator.push(context, MaterialPageRoute(builder: (context)=> sign_in()));
                      },
                      child: Text('Sign In'),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        //Navigator.push(context, MaterialPageRoute(builder: (context)=> my_order036()));
                      },
                      child: Text('My Orders (036)'),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                       // Navigator.push(context, MaterialPageRoute(builder: (context)=> Review_Page032()));
                      },
                      child: Text('Review Page  (032)'),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        //Navigator.push(context, MaterialPageRoute(builder: (context)=> search_bar024()));
                      },
                      child: Text('Search Page (024)'),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        //Navigator.push(context, MaterialPageRoute(builder: (context)=> setting_page040()));
                      },
                      child: Text('Setting Page (040)'),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        //Navigator.push(context, MaterialPageRoute(builder: (context)=> Order_Details037()));
                      },
                      child: Text('Order Details (037)'),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        //Navigator.push(context, MaterialPageRoute(builder: (context)=> Order_Cancellation038()));
                      },
                      child: Text('Order Cancellation (038)'),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                       // Navigator.push(context, MaterialPageRoute(builder: (context)=> review_page031()));
                      },
                      child: Text('Review Page (031)'),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                       // Navigator.push(context, MaterialPageRoute(builder: (context)=> payment_page034()));
                      },
                      child: Text('Payment Page (034)'),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                       // Navigator.push(context, MaterialPageRoute(builder: (context)=> payment_confirmation035()));

                      },
                      child: Text('Payment Confirmation (035)'),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        // Button 2 onPressed logic
                      },
                      child: Text('Button 2'),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        // Button 3 onPressed logic
                      },
                      child: Text('Button 3'),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        // Button 15 onPressed logic
                      },
                      child: Text('Button 15'),
                    ),
                  ],
                )


              ],
            ),
          ),
        )
      ,
    );
  }

}