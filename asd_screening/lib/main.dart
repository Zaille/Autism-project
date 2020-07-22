import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:asdscreening/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      title: 'ASD Screening',
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        accentColor: Colors.blueGrey,
        backgroundColor: Colors.white,
        cardColor: Colors.lightBlue.withOpacity(0.2),
        highlightColor: Colors.grey.withOpacity(0.6),
        textTheme: TextTheme(
          headline1: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 26,
            color: Colors.blueGrey,
          ),
          headline2: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.black,
          ),
          bodyText1: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 20,
            color: Colors.black,
          ),
          bodyText2: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 16,
            color: Colors.black,
          ),
          caption: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 14,
            color: Colors.black,
          ),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        accentColor: Colors.blueAccent,
        cardColor: Colors.blueGrey,
        backgroundColor: Colors.grey[800],
        highlightColor: Colors.black.withOpacity(0),
        textTheme: TextTheme(
          headline1: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 26,
            color: Colors.white.withOpacity(0.7),
          ),
          headline2: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.white.withOpacity(0.7),
          ),
          bodyText1: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 20,
            color: Colors.white.withOpacity(0.7),
          ),
          bodyText2: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 16,
            color: Colors.white.withOpacity(0.7),
          ),
          caption: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 14,
            color: Colors.white.withOpacity(0.7),
          ),
        ),
      ),
      home: HomePage(),
    );
  }
}