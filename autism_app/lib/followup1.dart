import 'package:autismtest/copyright.dart';
import 'package:autismtest/copyright.dart';
import 'package:autismtest/copyright.dart';
import 'package:autismtest/roundedContainer.dart';
import 'package:autismtest/submitButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Followup1 extends StatefulWidget{
  Followup1({Key key, this.nextPage}) : super(key: key);

  final nextPage;

  @override
  State<StatefulWidget> createState() {
    return Followup1State();
  }
}

class Followup1State extends State<Followup1> {

  List<bool> _selected = new List<bool>.filled(7, null, growable: true);
  int thirdChoice = -1;
  final myTextController = TextEditingController();
  final String title = "FollowUp 1";
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
                "Please give an example of how he/she will respond if you point at something:",
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
          padding: EdgeInsets.symmetric(vertical: 120, horizontal: 50),
          onPressed: () {
              if (myTextController.text == "") Fluttertoast.showToast(msg: "Complete the field");
              else print(myTextController.text);
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
                "If you point at something, what does your child typically do?",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              )
            ]
        ),
        RoundedContainer(
          displayTitle: false,
          children: <Widget>[
            Text("Look at object?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            _yesOrNoRadio(0),
          ],
        ),
        RoundedContainer(
          displayTitle: false,
          children: <Widget>[
            Text("Point to object?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            _yesOrNoRadio(1),
          ],
        ),
        RoundedContainer(
          displayTitle: false,
          children: <Widget>[
            Text("Look and comment on object?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            _yesOrNoRadio(2),
          ],
        ),
        RoundedContainer(
          displayTitle: false,
          children: <Widget>[
            Text("Look if you point and say “look!”?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            _yesOrNoRadio(3),
          ],
        ),
        RoundedContainer(
          displayTitle: false,
          children: <Widget>[
            Text("Ignores you?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            _yesOrNoRadio(4),
          ],
        ),
        RoundedContainer(
          displayTitle: false,
          children: <Widget>[
            Text("Look around room randomly?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            _yesOrNoRadio(5),
          ],
        ),
        RoundedContainer(
          displayTitle: false,
          children: <Widget>[
            Text("Look at your finger?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            _yesOrNoRadio(6),
          ],
        ),
        SubmitButton(
          text: "VALIDATE",
          padding: EdgeInsets.symmetric(vertical: 100, horizontal: 50),
          onPressed: () {
            setState(() {
              //Need responses
              if (_selected.contains(null)) Fluttertoast.showToast(msg: "Need all responses");
              //Respond "Yes" to a "FAIL" example
              else if (_selected.sublist(4, 7).contains(true)) {
                //And "Yes" to "PASS"
                if (_selected.sublist(0, 4).contains(true))
                  setState(() {
                    state ++;
                  });
                //FAILED
                else print("FAILED");
              }
              //PASS
              else if (!_selected.sublist(4, 7).contains(true)) print(_selected);
            });
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
                title: Text("Look at object?"),
              ) : Container(),
            _selected[1]?
              RadioListTile(
                value: 1,
                groupValue: thirdChoice,
                onChanged: (newValue) => setState(() => thirdChoice = newValue),
                title: Text("Point to object?"),
              ) : Container(),
            _selected[2]?
              RadioListTile(
                value: 2,
                groupValue: thirdChoice,
                onChanged: (newValue) => setState(() => thirdChoice = newValue),
                title: Text("Look and comment on object?"),
              ) : Container(),
            _selected[3]?
              RadioListTile(
                value: 3,
                groupValue: thirdChoice,
                onChanged: (newValue) => setState(() => thirdChoice = newValue),
                title: Text("Look if you point and say “look!”?"),
              ) : Container(),
            _selected[4]?
              RadioListTile(
                value: 4,
                groupValue: thirdChoice,
                onChanged: (newValue) => setState(() => thirdChoice = newValue),
                title: Text("Ignores you?"),
              ) : Container(),
            _selected[5]?
              RadioListTile(
                value: 5,
                groupValue: thirdChoice,
                onChanged: (newValue) => setState(() => thirdChoice = newValue),
                title: Text("Look around room randomly?"),
              ) : Container(),
            _selected[6]?
              RadioListTile(
                value: 6,
                groupValue: thirdChoice,
                onChanged: (newValue) => setState(() => thirdChoice = newValue),
                title: Text("Look at your finger?"),
              ) : Container(),
          ],
        ),
        SubmitButton(
          text: "VALIDATE",
          padding: EdgeInsets.symmetric(vertical: 100, horizontal: 50),
          onPressed: () {
            if (thirdChoice == -1) Fluttertoast.showToast(msg: "Complete the field");
            else print(thirdChoice);
            widget.nextPage(_selected, thirdChoice, null, null);
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