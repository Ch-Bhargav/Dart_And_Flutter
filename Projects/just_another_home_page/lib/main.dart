import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Basic Home Page'),
        ),
        body: BlankScreen(),
      ),
    );
  }
}

class BlankScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(); // Empty container representing a blank screen
  }
}
