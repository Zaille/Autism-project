import 'package:autismtest/copyright.dart';
import 'package:autismtest/form.dart';
import 'package:autismtest/main.dart';
import 'package:autismtest/roundedContainer.dart';
import 'package:autismtest/submitButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LinkPage extends StatefulWidget {
  LinkPage({Key key, this.responses, this.score}) : super(key: key);

  final List<bool> responses;
  final int score;

  @override
  LinkPageState createState() {
    return LinkPageState();
  }
}

class LinkPageState extends State<LinkPage> {

  Widget nextPage;
  String text;

  @override
  Widget build(BuildContext context) {

    if(widget.score < 3) {
      nextPage = MyApp();
      text = "There is a Low-risk."
          "\n\n     If child is younger than 24 months, screen again "
          "after second birthday."
          "\n Otherwise, no further action required unless "
          "surveillance indicates risk for ASD.";
    }
    else if(widget.score < 8) {
      nextPage = FormPage(responses: widget.responses,);
      text = "There is a Medium-risk."
          "\n\n     You will be administer a Follow-Up interview. "
          "Some of your responses might present a risk, "
          "you will be ask more details about thoses-ones. "
          "You should be aware that even with the Follow-Up, "
          "a significant number of the children who screen positive "
          "on the M-CHAT-R will not be diagnosed with ASD; however, "
          "these children are at high risk for other developmental "
          "disorders or delays, and therefore, evaluation is warranted "
          "for any child who screens positive.";
    }
    else {
      nextPage = FormPage();
      text = "There is a High-risk."
          "\n\n Lorem ipsum dolor sit amet, consectetur adipiscing "
          "elit. Sed non risus. Suspendisse lectus tortor, "
          "dignissim sit amet, adipiscing nec, ultricies sed, "
          "dolor. Cras elementum ultrices diam. Maecenas ligula "
          "massa, varius a, semper congue, euismod non, mi. "
          "Cras elementum ultrices diam. Maecenas ligula "
          "massa, varius a, semper congue, euismod non, mi.";
    }

    return Scaffold(
      floatingActionButton: Container(
        padding: EdgeInsets.symmetric(vertical: 50),
        width: 300,
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => nextPage),
            );
          },
          label: Text("NEXT"),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0)),),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          RoundedContainer(
            title: "Results",
            titleSize: 30.0,
            color: Colors.lightBlue.withOpacity(0.2),
            children: [
              Container(
                padding: EdgeInsets.all(8),
                child: Text(
                    text,
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.justify
                ),
              ),
            ]
          ),
          Spacer(),
          Copyright(),
        ],
      ),
    );
  }
}
