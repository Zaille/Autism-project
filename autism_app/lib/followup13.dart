import 'package:autismtest/roundedContainer.dart';
import 'package:autismtest/submitButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Followup13 extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return Followup13State();
  }
}

class Followup13State extends State<Followup13> {

  bool _selected = null;
  final String title = "FollowUp 13";
  int state = 0;

  @override
  Widget build(BuildContext context) {
    if (state == 0) return firstElement();
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
              "Does he/she walk without holding on to anything?",
              style: TextStyle(fontSize: 20,),
              textAlign: TextAlign.center,
            ),
            _yesOrNoRadio(),
          ],
        ),
        Spacer(),
        SubmitButton(
          text: "VALIDATE",
          padding: EdgeInsets.symmetric(vertical: 120, horizontal: 50),
          onPressed: () {
            setState(() {
              if (_selected == null) Fluttertoast.showToast(msg: "Complete the field");
              else print(_selected);
            });
          },
        ),
      ],
    );
  }

  Widget _yesOrNoRadio() {
    return Row(
      children: <Widget>[
        Spacer(),
        Expanded(
          flex: 4,
          child: RadioListTile(
            value: true,
            groupValue: _selected,
            onChanged: (newValue) => setState(() => _selected = newValue),
            title: Text("Yes"),
          ),
        ),
        Expanded(
          flex: 4,
          child: RadioListTile(
            value: false,
            groupValue: _selected,
            onChanged: (newValue) => setState(() => _selected = newValue),
            title: Text("No"),
          ),
        ),
        Spacer(),
      ],
    );
  }
}