import 'package:autismtest/copyright.dart';
import 'package:autismtest/roundedContainer.dart';
import 'package:autismtest/submitButton.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Followup13 extends StatefulWidget{
  Followup13({Key key, this.nextPage}) : super(key: key);

  final nextPage;

  @override
  State<StatefulWidget> createState() {
    return Followup13State();
  }
}

class Followup13State extends State<Followup13> {

  bool selected;
  final String title = "FollowUp 13";

  @override
  Widget build(BuildContext context) {
    return firstElement();
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
          padding: EdgeInsets.symmetric(vertical: 100, horizontal: 50),
          onPressed: () {
            //Need a response
            if (selected == null) Fluttertoast.showToast(msg: "Complete the field");
            //Send data
            else  widget.nextPage([selected], null, null, null, selected);
          },
        ),
        Copyright(),
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
            groupValue: selected,
            onChanged: (newValue) => setState(() => selected = newValue),
            title: Text("Yes"),
          ),
        ),
        Expanded(
          flex: 4,
          child: RadioListTile(
            value: false,
            groupValue: selected,
            onChanged: (newValue) => setState(() => selected = newValue),
            title: Text("No"),
          ),
        ),
        Spacer(),
      ],
    );
  }
}