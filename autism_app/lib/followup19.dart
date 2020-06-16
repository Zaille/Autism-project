import 'package:autismtest/roundedContainer.dart';
import 'package:autismtest/submitButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Followup19 extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return Followup19State();
  }
}

class Followup19State extends State<Followup19> {

  List<bool> _selected = new List<bool>.filled(3, null, growable: true);
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
          padding: EdgeInsets.symmetric(vertical: 120, horizontal: 50),
          onPressed: () {
            setState(() {
              if (_selected[0] == null) Fluttertoast.showToast(msg: "Complete the field");
              else if (!_selected[0]) setState(() {
                state ++;
              });
              else print("PASS");
            });
          },
        ),
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
          padding: EdgeInsets.symmetric(vertical: 120, horizontal: 50),
          onPressed: () {
            setState(() {
              if (_selected[1] == null) Fluttertoast.showToast(msg: "Complete the field");
              else if (!_selected[1]) setState(() {
                state ++;
              });
              else print("PASS");
            });
          },
        ),
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
          padding: EdgeInsets.symmetric(vertical: 120, horizontal: 50),
          onPressed: () {
            setState(() {
              if (_selected[2] == null) Fluttertoast.showToast(msg: "Complete the field");
              else if (_selected[2]) print("PASS");
              else print("FAIL");
            });
          },
        ),
      ],
    );
  }

  Widget _yesOrNoRadio(index) {
    return Row(
      children: <Widget>[
        Spacer(),
        Expanded(
          flex: 4,
          child: RadioListTile(
            value: true,
            groupValue: _selected[index],
            onChanged: (newValue) => setState(() => _selected[index] = newValue),
            title: Text("Yes"),
          ),
        ),
        Expanded(
          flex: 4,
          child: RadioListTile(
            value: false,
            groupValue: _selected[index],
            onChanged: (newValue) => setState(() => _selected[index] = newValue),
            title: Text("No"),
          ),
        ),
        Spacer(),
      ],
    );
  }
}