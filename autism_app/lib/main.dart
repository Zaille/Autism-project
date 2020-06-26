import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:autismtest/home.dart';

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
      title: 'ASD Screening',
      theme: ThemeData(
        brightness: Brightness.light,
        accentColor: Colors.blueGrey,
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
        backgroundColor: Colors.white.withOpacity(0.7),
        cardColor: Colors.lightBlue.withOpacity(0.2),
        highlightColor: Colors.grey.withOpacity(0.6),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
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
        accentColor: Colors.blueAccent,
        cardColor: Colors.blueGrey,
        highlightColor: Colors.black.withOpacity(0),
      ),
      home: HomePage(),
    );
  }
}
