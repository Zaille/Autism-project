import 'package:autismtest/copyright.dart';
import 'package:autismtest/copyright.dart';
import 'package:autismtest/copyright.dart';
import 'package:autismtest/roundedContainer.dart';
import 'package:autismtest/submitButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Followup2 extends StatefulWidget{
  Followup2({Key key, this.nextPage}) : super(key: key);

  final nextPage;

  @override
  State<StatefulWidget> createState() {
    return Followup2State();
  }
}

class Followup2State extends State<Followup2> {

  List<bool> selected = new List<bool>.filled(3, null, growable: true);
  String description;
  final String title = "FollowUp 2";
  int state = 0;

  @override
  Widget build(BuildContext context) {
    if (state == 0) return firstElement();
    if (state == 1) return secondElement();
    if (state == 2) return thirdElement();
    return Spacer();
  }

  Widget firstElement() {
    return ListView(
      children: <Widget>[
        RoundedContainer(
            title: title,
            color: Colors.lightBlue.withOpacity(0.2),
            children: [
              Text(
                "You reported that you have wondered if you child is deaf. What led you to wonder that?\n Does he/she…",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              )
            ]
        ),
        RoundedContainer(
          displayTitle: false,
          children: <Widget>[
            Text("Often ignore sounds?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            _yesOrNoRadio(0),
          ],
        ),
        RoundedContainer(
          displayTitle: false,
          children: <Widget>[
            Text("Often ignore people?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            _yesOrNoRadio(1),
          ],
        ),
        SubmitButton(
          text: "VALIDATE",
          padding: EdgeInsets.symmetric(vertical: 100, horizontal: 50),
          onPressed: () {
            if ((selected.sublist(0,2).contains(null)))Fluttertoast.showToast(msg: "No response selected");
            else setState(() {
              state ++;
            });
          },
        ),
        Copyright(),
      ],
    );
  }

  Widget secondElement() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        RoundedContainer(
          title: title,
          children: [
            Text("Has your child’s hearing been tested?", style: TextStyle(fontSize: 18),),
            _yesOrNoRadio(2)
          ],
        ),
        Spacer(),
        SubmitButton(
          text: "VALIDATE",
          onPressed: () {
            if (selected[2] == null) Fluttertoast.showToast(msg: "No response selected");
            else if (selected[2]) setState(() {
              state ++;
            });
            else widget.nextPage(selected, null, null, null, !selected.sublist(0,3).contains(true));
          },
        ),
        Copyright(),
      ],
    );
  }

  Widget thirdElement() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        RoundedContainer(
          title: title,
          children: [
            Text(
              "What were the results of the hearing test?",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            RadioListTile(
              value: "Hearing in normal range",
              groupValue: description,
              onChanged: (newValue) => setState(() => description = newValue),
              title: Text("Hearing in normal range"),
            ),
            RadioListTile(
              value: "Hearing below normal",
              groupValue: description,
              onChanged: (newValue) => setState(() => description = newValue),
              title: Text("Hearing below normal"),
            ),
            RadioListTile(
              value: "Results inconclusive or not definitive",
              groupValue: description,
              onChanged: (newValue) => setState(() => description = newValue),
              title: Text("Results inconclusive or not definitive"),
            ),
          ],
        ),
        Spacer(),
        SubmitButton(
          text: "VALIDATE",
          onPressed: () {
            if (description == null) Fluttertoast.showToast(msg: "No response selected");
            else widget.nextPage(selected, null, null, description, !selected.sublist(0,3).contains(true));
          },
        ),
        Copyright(),
      ],
    );
  }

  Widget _yesOrNoRadio(index) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: RadioListTile(
              value: true,
              groupValue: selected[index],
              onChanged: (newValue) => setState(() => selected[index] = newValue),
              title: Text("Yes"),
            ),
          ),
          Expanded(
            child: RadioListTile(
              value: false,
              groupValue: selected[index],
              onChanged: (newValue) => setState(() => selected[index] = newValue),
              title: Text("No"),
            ),
          ),
        ],
      ),
    );
  }
}