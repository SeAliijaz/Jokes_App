import 'package:flutter/material.dart';
import 'package:jokes_app/Jokes_App-WorkSpace/home_Screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      ///title of App
      title: 'Jokes-App',

      ///theme
      theme: ThemeData(
        primarySwatch: Colors.red,
        primaryColor: Colors.blue,
      ),

      ///DebugShowCheckedModeBanner
      debugShowCheckedModeBanner: false,

      ///home
      home: HomeScreen(),
    );
  }
}
