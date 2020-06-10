import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: <Widget>[
              Image.asset(
                'images/home_pic.jpg',
              ),
              Center(
                child: Container(
                  padding: const EdgeInsets.only(top: 70.0),
                  child: Text('M-CHAT-R/F™', style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)
                  ),
                ),
              ),
            ],
          ),
          Container(
            transform: Matrix4.translationValues(0.0, -30.0, 0.0),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFFFFFF), Color(0xFFC9F1FD)]
                )
            ),
            height: 30,
          ),
          Container(
              transform: Matrix4.translationValues(0.0, -30.08, 0.0),
              color: Color(0xFFC9F1FD),
              height: 350.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(top: 20.0, left: 35),
                    child: Text("What is M-CHAT-R/F™ ?",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Color(0xffb6c6ca)
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    child: Text("          Lorem ipsum dolor sit amet, consectetur adipiscing "
                        "elit. Sed non risus. Suspendisse lectus tortor, "
                        "dignissim sit amet, adipiscing nec, ultricies sed, "
                        "dolor. Cras elementum ultrices diam. Maecenas ligula "
                        "massa, varius a, semper congue, euismod non, mi.\n\n"
                        "          Lorem ipsum dolor sit amet, consectetur adipiscing "
                        "elit. Sed non risus. Suspendisse lectus tortor, "
                        "dignissim sit amet, adipiscing nec, ultricies sed, "
                        "dolor. Cras elementum ultrices diam. Maecenas ligula "
                        "massa, varius a, semper congue, euismod non, mi.", textAlign: TextAlign.justify,
                    ),
                  ),
                  Center(
                    child: Container (
                      child: RaisedButton(
                        onPressed: () {}, // TODO : Envoyer vers page Instructions
                        textColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 100.0),
                        color: Colors.blue,
                        child: const Text('Start', style: TextStyle(fontSize: 20)),
                        shape: RoundedRectangleBorder (
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                  ),
                ],
              )
          ),
          Container(
            transform: Matrix4.translationValues(0.0, -30.0, 0.0),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFFC9F1FD), Color(0xFFFFFF)]
                )
            ),
            height: 30,
          ),
          Center(
              child: Container(
                  transform: Matrix4.translationValues(0.0, -50.0, 0.0),
                  padding: const EdgeInsets.only( top: 25.0, left: 50.0, right: 50 ),
                  child: Text("© 2009 Diana Robins, Deborah Fein, & Marianne Barton.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 12,
                        color: Color(0xffaaaaaa)
                    ),
                  )
              )
          )
        ],
      ),
    );
  }
}
