import 'package:autismtest/submitButton.dart';
import "package:flutter/material.dart";
import 'package:autismtest/roundedContainer.dart';

class QuestionWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return QuestionState();
  }
}

class QuestionState extends State<QuestionWidget> {

  final _formKey = GlobalKey<FormState>();
  int questionIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            RoundedContainer(
              title: "Question " + questionIndex.toString(),
              color: Colors.lightBlue.withOpacity(0.2),
              children: [
                Text(""),
              ],
            ),
            SubmitButton(
              text: "VALIDATE",
              onPressed: () {
                Scaffold.of(context).showSnackBar(new SnackBar(
                    content: new Text("Need response")));
              },
            ),
          ],
        ),
    );
  }

}