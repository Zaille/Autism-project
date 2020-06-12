import 'package:autismtest/submitButton.dart';
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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
              decoration: BoxDecoration(
                color: Color(0xFFC9F1FD),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFC9F1FD).withOpacity(1),
                    spreadRadius: 10,
                    blurRadius: 5,
                  ),
                ],
              ),
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
                ],
              )
          ),
          SubmitButton(
            text: "START",
            onPressed: () {},
          ),
          Center(
              child: Container(
//                  transform: Matrix4.translationValues(0.0, -50.0, 0.0),
                  padding: const EdgeInsets.symmetric( vertical: 10.0, horizontal: 50 ),
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
