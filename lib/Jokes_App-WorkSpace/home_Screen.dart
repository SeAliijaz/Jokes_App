import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  ///Method to Fetch API

  @override
  Widget build(BuildContext context) {
    ///Size
    final Size s = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
        centerTitle: true,
      ),
      body: Container(
        height: s.height,
        width: s.width,
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
