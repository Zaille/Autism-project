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
        primaryColor: Colors.blueGrey,
        accentColor: Colors.blueGrey,
        backgroundColor: Colors.white.withOpacity(0.7),
        cardColor: Colors.lightBlue.withOpacity(0.2),
        buttonColor: Colors.blueGrey,
        highlightColor: Colors.grey.withOpacity(0.6),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.white.withOpacity(0.87),
        accentColor: Colors.blueGrey,
        backgroundColor: Colors.blueGrey.withOpacity(0.4),
        cardColor: Colors.black,
        buttonColor: Colors.blueGrey,
        highlightColor: Colors.black.withOpacity(0),
      ),
      home: HomePage(),
    );
  }
}
