
import 'package:flutter/material.dart';
import 'package:autismtest/MyCustomForm.dart';

void main() {
  runApp(MaterialApp(
    title: 'Application',
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Center(
          child: MyCustomForm(),
        ),
      ),
    );
  }
}



