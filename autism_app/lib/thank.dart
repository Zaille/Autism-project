import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Thank extends StatefulWidget {
  @override
  ThankState createState() {
    return ThankState();
  }
}

class ThankState extends State<Thank> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 40.0, bottom: 40.0, left: 40.0),
          child: Text("Thank You",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Color(0xffaaaaaa),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Color(0xFFC9F1FD),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 3,
                blurRadius: 5,
                offset: Offset(0, 4), // changes position of shadow
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
          child: Text("          Lorem ipsum dolor sit amet, consectetur adipiscing "
              "elit. Sed non risus. Suspendisse lectus tortor, "
              "dignissim sit amet, adipiscing nec, ultricies sed, "
              "dolor. Cras elementum ultrices diam. Maecenas ligula "
              "massa, varius a, semper congue, euismod non, mi. "
              "Cras elementum ultrices diam. Maecenas ligula "
              "massa, varius a, semper congue, euismod non, mi.\n\n\n\n"
              "          Lorem ipsum dolor sit amet, consectetur adipiscing "
              "elit. Sed non risus. Suspendisse lectus tortor, "
              "dignissim sit amet, adipiscing nec, ultricies sed, "
              "dolor. Cras elementum ultrices diam. Maecenas ligula "
              "massa, varius a, semper congue, euismod non, mi.",
            textAlign: TextAlign.justify
          ),
        ),
        Center(
          child: Container (
            padding: const EdgeInsets.only(top: 60.0),
            child: RaisedButton(
              onPressed: () {}, // TODO : Envoyer vers page Questions
              textColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 100.0),
              color: Colors.blue,
              child: const Text('Finish', style: TextStyle(fontSize: 20)),
              shape: RoundedRectangleBorder (
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
