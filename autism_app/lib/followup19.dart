import 'package:autismtest/copyright.dart';
import 'package:autismtest/roundedContainer.dart';
import 'package:autismtest/submitButton.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Followup19 extends StatefulWidget{
  Followup19({Key key, this.nextPage}) : super(key: key);

  final nextPage;

  @override
  State<StatefulWidget> createState() {
    return Followup19State();
  }
}

class Followup19State extends State<Followup19> {

  List<bool> selected = new List<bool>.filled(3, null, growable: true);
  final String title = "FollowUp 19";
  int state = 0;

  @override
  Widget build(BuildContext context) {
    if (state == 0) return firstElement();
    if (state == 1) return secondElement();
    if (state == 2) return thirdElement();
    return Spacer();
  }

  Widget firstElement() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        RoundedContainer(
          title: title,
          children: [
            Text(
              "If your child hears a strange or scary noise, will he/she look at you before responding?",
              style: TextStyle(fontSize: 20,),
              textAlign: TextAlign.center,
            ),
            _yesOrNoRadio(0),
          ],
        ),
        Spacer(),
        SubmitButton(
          text: "VALIDATE",
          padding: EdgeInsets.symmetric(vertical: 100, horizontal: 50),
          onPressed: () {
            //Need a response
            if (selected[0] == null) Fluttertoast.showToast(msg: "Complete the field");
            //Next question
            else if (!selected[0]) setState(() {
              state ++;
            });
            //PASS
            else widget.nextPage(19, selected, null, null, null, true);
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
            Text(
              "Does your child look at you when someone new approaches?",
              style: TextStyle(fontSize: 20,),
              textAlign: TextAlign.center,
            ),
            _yesOrNoRadio(1),
          ],
        ),
        Spacer(),
        SubmitButton(
          text: "VALIDATE",
          padding: EdgeInsets.symmetric(vertical: 100, horizontal: 50),
          onPressed: () {
            //Need a response
            if (selected[1] == null) Fluttertoast.showToast(msg: "Complete the field");
            //Next question
            else if (!selected[1]) setState(() {
              state ++;
            });
            //PASS
            else widget.nextPage(19, selected, null, null, null, true);
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
              "Does your child look at you when he/she is faced with something unfamiliar or a little scary?",
              style: TextStyle(fontSize: 20,),
              textAlign: TextAlign.center,
            ),
            _yesOrNoRadio(2),
          ],
        ),
        Spacer(),
        SubmitButton(
          text: "VALIDATE",
          padding: EdgeInsets.symmetric(vertical: 100, horizontal: 50),
          onPressed: () {
            setState(() {
              if (selected[2] == null) Fluttertoast.showToast(msg: "Complete the field");
              else widget.nextPage(19, selected, null, null, null, selected[2]);
            });
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