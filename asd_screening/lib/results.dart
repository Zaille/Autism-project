import 'package:asdscreening/copyright.dart';
import 'package:asdscreening/form.dart';
import 'package:asdscreening/main.dart';
import 'package:asdscreening/roundedContainer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResultsPage extends StatefulWidget {
  ResultsPage({Key key, this.responses, this.score}) : super(key: key);

  final List<bool> responses;
  final int score;

  @override
  ResultsPageState createState() {
    return ResultsPageState();
  }
}

class ResultsPageState extends State<ResultsPage> {

  Widget nextPage;
  String text;
  String description;

  @override
  Widget build(BuildContext context) {

    if(widget.score < 3) {
      nextPage = MyApp();
      text = "Low-risk.";
      description =
          "     If child is younger than 24 months, screen again "
          "after second birthday."
          "\n Otherwise, no further action required unless "
          "surveillance indicates risk for ASD.";
    }
    else if(widget.score < 8) {
      nextPage = FormPage(responses: widget.responses, score: widget.score,);
      text = "Medium-risk.";
      description =
          "     You will be administer a Follow-Up interview because " +
          widget.score.toString() + " of your responses might present "
          "ASD risk for your child. "
          "You will be ask more details about thoses-ones.\n\n"
          "     You should be aware that even with the Follow-Up, "
          "a significant number of the children who screen positive "
          "on the M-CHAT-R will not be diagnosed with ASD; however, "
          "these children are at high risk for other developmental "
          "disorders or delays, and therefore, evaluation is warranted "
          "for any child who screens positive.\n\n"
          "     You will have to complete a form with your information "
          "in order to be followed by a specialist";
    }
    else {
      nextPage = FormPage(responses: widget.responses, score: widget.score,);
      text = "High-risk.";
      description =
          "  It is acceptable to bypass the Follow-Up and refer "
          "immediately for diagnostic evaluation and eligibility "
          "evaluation for early intervention.\n\n"
          "You will have to complete a form with your information"
          "in order to be followed by a specialist";
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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0)),),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          RoundedContainer(
              context: context,
              title: "Results",
              titleSize: 30.0,
              color: Theme.of(context).cardColor,
              children: [
                Text(
                    text + "\n",
                    style: Theme.of(context).textTheme.bodyText1,
                    textAlign: TextAlign.justify
                ),
                Text(
                    description,
                    style: Theme.of(context).textTheme.bodyText2,
                    textAlign: TextAlign.justify
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
