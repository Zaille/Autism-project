import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:autismtest/home.dart';
import 'package:autismtest/MyCustomForm.dart';

import 'MyCustomForm.dart';

void main() => runApp(Index());

class Index extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      title: 'M-CHAT-R Test',
      home: MyApp(),
    );
  }
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
        resizeToAvoidBottomPadding: false,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(0.0), // here the desired height
          child: AppBar(),
        ),
        body: Center(
          child: Home(),
        ),
      ),
    );
  }
}

//Scaffold(

//body:
//)