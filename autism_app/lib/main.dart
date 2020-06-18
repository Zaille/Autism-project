import 'package:autismtest/followup.dart';
import 'package:autismtest/followup1.dart';
import 'package:autismtest/followup2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:autismtest/home.dart';
import 'package:autismtest/thank.dart';
import 'package:autismtest/form.dart';
import 'package:autismtest/questions.dart';

import 'instructions.dart';


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
        body: Center(
          child: FollowUp(responses: [true, false, false, true, true, true, true, true, true, true, true, true, true, false, true, true, true, false, false, true]),
        ),
      ),
    );
  }
}
