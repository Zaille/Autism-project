import 'package:autismtest/copyright.dart';
import 'package:autismtest/navigationButtons.dart';
import 'package:autismtest/roundedContainer.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Followup16 extends StatefulWidget{
  Followup16({Key key, this.nextPage}) : super(key: key);

  final nextPage;

  @override
  State<StatefulWidget> createState() {
    return Followup16State();
  }
}

class Followup16State extends State<Followup16> {

  List<bool> selected = new List<bool>.filled(5, null, growable: true);
  String example;
  int thirdChoice = -1;
  final exampleController = TextEditingController();
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
    if(example != null) exampleController.text = example;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        RoundedContainer(
          context: context,
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
          previousFunction: () {},
          nextFunction: () {
            //Need a response
            if (exampleController.text == "") Fluttertoast.showToast(msg: "Complete the field");
            //Next question
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
    return ListView(
      children: <Widget>[
        RoundedContainer(
          context: context,
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
          context: context,
          outerTitle: false,
          children: <Widget>[
            Text("Look toward the thing you are looking at?",
              style: TextStyle(fontSize: 18), textAlign: TextAlign.center,
            ),
            _yesOrNoRadio(0),
          ],
        ),
        RoundedContainer(
          context: context,
          outerTitle: false,
          children: <Widget>[
            Text("Point toward the thing you are looking at?",
              style: TextStyle(fontSize: 18), textAlign: TextAlign.center,
            ),
            _yesOrNoRadio(1),
          ],
        ),
        RoundedContainer(
          context: context,
          outerTitle: false,
          children: <Widget>[
            Text("Look around to see what you are looking at?",
              style: TextStyle(fontSize: 18), textAlign: TextAlign.center,
            ),
            _yesOrNoRadio(2),
          ],
        ),
        RoundedContainer(
          context: context,
          outerTitle: false,
          children: <Widget>[
            Text("Ignore you?",
              style: TextStyle(fontSize: 18), textAlign: TextAlign.center,
            ),
            _yesOrNoRadio(3),
          ],
        ),
        RoundedContainer(
          context: context,
          outerTitle: false,
          children: <Widget>[
            Text("Look at your face?",
              style: TextStyle(fontSize: 18), textAlign: TextAlign.center,
            ),
            _yesOrNoRadio(4),
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
            //"Yes" in "Pass"
            else if (selected.sublist(0,3).contains(true)) {
              //Both "Pass" and "Fail" contain "Yes => Next question
              if (selected.sublist(3,5).contains(true)) setState(() {
                state ++;
              });
              //Only "Pass" contains "Yes" => PASS
              else widget.nextPage(16, selected, null, example, null, true);
            }
            //"Yes" only in "Fail" => FAIL
            else widget.nextPage(16, selected, null, example, null, false);
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
          context: context,
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
              title: Text("Look toward the thing you are looking at?"),
            ) : Container(),
            selected[1]?
            RadioListTile(
              value: 1,
              groupValue: thirdChoice,
              onChanged: (newValue) => setState(() => thirdChoice = newValue),
              title: Text("Point toward the thing you are looking at?"),
            ) : Container(),
            selected[2]?
            RadioListTile(
              value: 2,
              groupValue: thirdChoice,
              onChanged: (newValue) => setState(() => thirdChoice = newValue),
              title: Text("Look around to see what you are looking at?"),
            ) : Container(),
            selected[3]?
            RadioListTile(
              value: 3,
              groupValue: thirdChoice,
              onChanged: (newValue) => setState(() => thirdChoice = newValue),
              title: Text("Ignore you?"),
            ) : Container(),
            selected[4]?
            RadioListTile(
              value: 4,
              groupValue: thirdChoice,
              onChanged: (newValue) => setState(() => thirdChoice = newValue),
              title: Text("Look at your face?"),
            ) : Container(),
          ],
        ),
        NavigationButtons(
          prevCondition: state > 0,
          previousFunction: () {
            setState(() => state --);
          },
          nextFunction: () {
            if (thirdChoice == -1) Fluttertoast.showToast(msg: "Complete the field");
            else widget.nextPage(16, selected, thirdChoice, example, null, thirdChoice < 3);
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