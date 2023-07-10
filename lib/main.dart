import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test/pages/splash_screen00.dart';
import 'package:test/pages/cart_page33.dart';
void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Netikask Live',
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(primarySwatch: Colors.yellow),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashScreen(),
      // home: CartPage(),
    );
  }
}
