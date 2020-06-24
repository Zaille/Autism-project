import 'package:autismtest/copyright.dart';
import 'package:autismtest/navigationButtons.dart';
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

  List<bool> selected = new List<bool>.filled(7, null, growable: true);
  String example;
  int thirdChoice = -1;
  final exampleController = TextEditingController();
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
    if(example != null) exampleController.text = example;
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
                  example = "";
                  state ++;
                });
              },
            ),
          ],
        ),
        Spacer(),
        NavigationButtons(
          prevCondition: state > 0,
          previousFunction: () {
            setState(() => state --);
          },
          nextFunction: () {
            if (exampleController.text == "") Fluttertoast.showToast(msg: "Complete the field");
            else {
              example = exampleController.text;
              setState(() {
                state ++;
              });
            }
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
        NavigationButtons(
          prevCondition: state > 0,
          previousFunction: () {
            setState(() => state --);
            },
          nextFunction: () {
              //Need responses
              if (selected.contains(null)) Fluttertoast.showToast(msg: "Need all responses");
              //Respond "Yes" to a "FAIL" example
              else if (selected.sublist(4, 7).contains(true)) {
                //And "Yes" to "PASS"
                if (selected.sublist(0, 4).contains(true))
                  setState(() {
                    state ++;
                  });
                //FAIL
                else widget.nextPage(1, selected, null, example, null, false);
              }
              //PASS
              else if (!selected.sublist(4, 7).contains(true))
                widget.nextPage(1, selected, null, example, null, true);
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
            selected[0]?
            RadioListTile(
              value: 0,
              groupValue: thirdChoice,
              onChanged: (newValue) => setState(() => thirdChoice = newValue),
              title: Text("Look at object?"),
            ) : Container(),
            selected[1]?
            RadioListTile(
              value: 1,
              groupValue: thirdChoice,
              onChanged: (newValue) => setState(() => thirdChoice = newValue),
              title: Text("Point to object?"),
            ) : Container(),
            selected[2]?
            RadioListTile(
              value: 2,
              groupValue: thirdChoice,
              onChanged: (newValue) => setState(() => thirdChoice = newValue),
              title: Text("Look and comment on object?"),
            ) : Container(),
            selected[3]?
            RadioListTile(
              value: 3,
              groupValue: thirdChoice,
              onChanged: (newValue) => setState(() => thirdChoice = newValue),
              title: Text("Look if you point and say “look!”?"),
            ) : Container(),
            selected[4]?
            RadioListTile(
              value: 4,
              groupValue: thirdChoice,
              onChanged: (newValue) => setState(() => thirdChoice = newValue),
              title: Text("Ignores you?"),
            ) : Container(),
            selected[5]?
            RadioListTile(
              value: 5,
              groupValue: thirdChoice,
              onChanged: (newValue) => setState(() => thirdChoice = newValue),
              title: Text("Look around room randomly?"),
            ) : Container(),
            selected[6]?
            RadioListTile(
              value: 6,
              groupValue: thirdChoice,
              onChanged: (newValue) => setState(() => thirdChoice = newValue),
              title: Text("Look at your finger?"),
            ) : Container(),
          ],
        ),
        NavigationButtons(
          prevCondition: state > 0,
          previousFunction: () {
            setState(() => state --);
          },
          nextFunction: () {
            //Need response
            if (thirdChoice == -1) Fluttertoast.showToast(msg: "Complete the field");
            //Send data
            else widget.nextPage(1, selected, thirdChoice, example, null, thirdChoice < 4);
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