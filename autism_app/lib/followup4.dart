import 'package:autismtest/copyright.dart';
import 'package:autismtest/copyright.dart';
import 'package:autismtest/roundedContainer.dart';
import 'package:autismtest/submitButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Followup4 extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return Followup4State();
  }
}

class Followup4State extends State<Followup4> {

  List<bool> _selected = new List<bool>.filled(11, null, growable: true);
  final myTextController = TextEditingController();
  final String title = "FollowUp 4";
  int state = 0;

  @override
  Widget build(BuildContext context) {
    if (state == 0) return firstElement();
    if (state == 1) return secondElement();
    return Spacer();
  }

  Widget firstElement() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
      RoundedContainer(
        title: title,
        children: [
          Container(
              padding: EdgeInsets.all(20),
              child: Text(
                "Please give an example of something he/she enjoys climbing on:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
          ),
          TextField(
            controller: myTextController,
            minLines: 4,
            maxLines: 10,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
          FlatButton(
            child: Text("I don't have any example"),
            color: Colors.white,
            textColor: Colors.lightBlue,
            onPressed: () {
              setState(() {
                state ++;
              });
            },
          ),
        ],
      ),
        Spacer(),
        SubmitButton(
          text: "VALIDATE",
          padding: EdgeInsets.symmetric(vertical: 100, horizontal: 50),
          onPressed: () {
            setState(() {
              if (myTextController.text == "") Fluttertoast.showToast(msg: "Complete the field");
              else print(myTextController.text);
            });
          },
        ),
        Copyright(),
      ],
    );
  }

  Widget secondElement() {
    return ListView(
      children: <Widget>[
        RoundedContainer(
          title: title,
          color: Colors.lightBlue.withOpacity(0.2),
          children: [
            Text("Does he/she enjoy climbing on…", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold), textAlign: TextAlign.center,)
          ]
        ),
        RoundedContainer(
          displayTitle: false,
          children: <Widget>[
            Text("Stairs?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            _yesOrNoRadio(0),
          ],
        ),
        RoundedContainer(
          displayTitle: false,
          children: <Widget>[
            Text("Chairs?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            _yesOrNoRadio(1),
          ],
        ),
        RoundedContainer(
          displayTitle: false,
          children: <Widget>[
            Text("Furniture?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            _yesOrNoRadio(2),
          ],
        ),
        RoundedContainer(
          displayTitle: false,
          children: <Widget>[
            Text("Playground equipment?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            _yesOrNoRadio(3),
          ],
        ),
        SubmitButton(
          text: "VALIDATE",
          padding: EdgeInsets.symmetric(vertical: 100, horizontal: 50),
          onPressed: () {
            setState(() {
              if (_selected.contains(null)) Fluttertoast.showToast(msg: "Need all responses");
              else print(_selected);
            });
          },
        ),
        Copyright(),
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