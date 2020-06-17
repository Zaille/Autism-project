import 'package:autismtest/copyright.dart';
import 'package:autismtest/roundedContainer.dart';
import 'package:autismtest/submitButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Followup16 extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return Followup16State();
  }
}

class Followup16State extends State<Followup16> {

  List<bool> _selected = new List<bool>.filled(5, null, growable: true);
  int thirdChoice = -1;
  final exampleController = TextEditingController();
  final describeController = TextEditingController();
  final String title = "FollowUp 16";
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
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                "What does he/she do when you turn to look at something?",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            TextField(
              controller: exampleController,
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
                  state = 1;
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
              if (exampleController.text == "") Fluttertoast.showToast(msg: "Complete the field");
              else setState(() {
                state = 1;
              });
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
              Text(
                "Does your child…",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              )
            ]
        ),
        RoundedContainer(
          displayTitle: false,
          children: <Widget>[
            Text("Look toward the thing you are looking at?",
              style: TextStyle(fontSize: 18), textAlign: TextAlign.center,
            ),
            _yesOrNoRadio(0),
          ],
        ),
        RoundedContainer(
          displayTitle: false,
          children: <Widget>[
            Text("Point toward the thing you are looking at?",
              style: TextStyle(fontSize: 18), textAlign: TextAlign.center,
            ),
            _yesOrNoRadio(1),
          ],
        ),
        RoundedContainer(
          displayTitle: false,
          children: <Widget>[
            Text("Look around to see what you are looking at?",
                style: TextStyle(fontSize: 18), textAlign: TextAlign.center,
            ),
            _yesOrNoRadio(2),
          ],
        ),
        RoundedContainer(
          displayTitle: false,
          children: <Widget>[
            Text("Ignore you?",
              style: TextStyle(fontSize: 18), textAlign: TextAlign.center,
            ),
            _yesOrNoRadio(3),
          ],
        ),
        RoundedContainer(
          displayTitle: false,
          children: <Widget>[
            Text("Look at your face?",
              style: TextStyle(fontSize: 18), textAlign: TextAlign.center,
            ),
            _yesOrNoRadio(4),
          ],
        ),
        SubmitButton(
          text: "VALIDATE",
          padding: EdgeInsets.symmetric(vertical: 100, horizontal: 50),
          onPressed: () {
            //Need responses
            if (_selected.contains(null)) Fluttertoast.showToast(msg: "Need all responses");
            //"Yes" in "Pass"
            else if (_selected.sublist(0,3).contains(true)) {
              //Both "Pass" and "Fail" contain "Yes
              if (_selected.sublist(3,5).contains(true)) setState(() {
                state = 2;
              });
              //Only "Pass" contains "Yes"
              else print("PASS");
            }
            //"Yes" only in "Fail"
            else print("FAIL");
          },
        ),
        Copyright(),
      ],
    );
  }

  Widget thirdElement() {
    return ListView(
      children: <Widget>[
        RoundedContainer(
          title: title,
          children: [
            Text(
              "Which one does he/she do most often?",
              style: TextStyle(fontSize: 20,),
              textAlign: TextAlign.center,
            ),
            _selected[0]?
            RadioListTile(
              value: 0,
              groupValue: thirdChoice,
              onChanged: (newValue) => setState(() => thirdChoice = newValue),
              title: Text("Look toward the thing you are looking at?"),
            ) : Container(),
            _selected[1]?
            RadioListTile(
              value: 1,
              groupValue: thirdChoice,
              onChanged: (newValue) => setState(() => thirdChoice = newValue),
              title: Text("Point toward the thing you are looking at?"),
            ) : Container(),
            _selected[2]?
            RadioListTile(
              value: 2,
              groupValue: thirdChoice,
              onChanged: (newValue) => setState(() => thirdChoice = newValue),
              title: Text("Look around to see what you are looking at?"),
            ) : Container(),
            _selected[3]?
            RadioListTile(
              value: 3,
              groupValue: thirdChoice,
              onChanged: (newValue) => setState(() => thirdChoice = newValue),
              title: Text("Ignore you?"),
            ) : Container(),
            _selected[4]?
            RadioListTile(
              value: 4,
              groupValue: thirdChoice,
              onChanged: (newValue) => setState(() => thirdChoice = newValue),
              title: Text("Look at your face?"),
            ) : Container(),
          ],
        ),
        SubmitButton(
          text: "VALIDATE",
          onPressed: () {
            setState(() {
              if (thirdChoice == -1) Fluttertoast.showToast(msg: "Complete the field");
              else print(thirdChoice);
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