import 'package:autismtest/copyright.dart';
import 'package:autismtest/navigationButtons.dart';
import 'package:autismtest/roundedContainer.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Followup11 extends StatefulWidget{
  Followup11({Key key, this.nextPage}) : super(key: key);

  final nextPage;

  @override
  State<StatefulWidget> createState() {
    return Followup11State();
  }
}

class Followup11State extends State<Followup11> {

  List<bool> selected = new List<bool>.filled(6, null, growable: true);
  String example;
  int thirdChoice = -1;
  final exampleController = TextEditingController();
  final String title = "FollowUp 11";
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
                "What make your child smile?",
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
            Text("Smile when you smile?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            _yesOrNoRadio(0),
          ],
        ),
        RoundedContainer(
          context: context,
          outerTitle: false,
          children: <Widget>[
            Text("Smile when you enter the room?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            _yesOrNoRadio(1),
          ],
        ),
        RoundedContainer(
          context: context,
          outerTitle: false,
          children: <Widget>[
            Text("Smile when you return from being away?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            _yesOrNoRadio(2),
          ],
        ),
        RoundedContainer(
          context: context,
          outerTitle: false,
          children: <Widget>[
            Text("Always smile?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            _yesOrNoRadio(3),
          ],
        ),
        RoundedContainer(
          context: context,
          outerTitle: false,
          children: <Widget>[
            Text("Smile at a favorite toy or activity?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            _yesOrNoRadio(4),
          ],
        ),
        RoundedContainer(
          context: context,
          outerTitle: false,
          children: <Widget>[
            Text(
              "Smile randomly or at nothing in particular?",
              style: TextStyle(fontSize: 18), textAlign: TextAlign.center,
            ),
            _yesOrNoRadio(5),
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
              //Both "Pass" and "Fail" contain "Yes
              if (selected.sublist(3,6).contains(true)) setState(() {
                state ++;
              });
              //Only "Pass" contains "Yes" => PASS
              else widget.nextPage(11, selected, null, example, null, true);
            }
            //"Yes" only in "Fail" => FAIL
            else widget.nextPage(11, selected, null, example, null, false);
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
              title: Text("Smile when you smile?"),
            ) : Container(),
            selected[1]?
            RadioListTile(
              value: 1,
              groupValue: thirdChoice,
              onChanged: (newValue) => setState(() => thirdChoice = newValue),
              title: Text("Smile when you enter the room?"),
            ) : Container(),
            selected[2]?
            RadioListTile(
              value: 2,
              groupValue: thirdChoice,
              onChanged: (newValue) => setState(() => thirdChoice = newValue),
              title: Text("Smile when you return from being away?"),
            ) : Container(),
            selected[3]?
            RadioListTile(
              value: 3,
              groupValue: thirdChoice,
              onChanged: (newValue) => setState(() => thirdChoice = newValue),
              title: Text("Always smile?"),
            ) : Container(),
            selected[4]?
            RadioListTile(
              value: 4,
              groupValue: thirdChoice,
              onChanged: (newValue) => setState(() => thirdChoice = newValue),
              title: Text("Smile at a favorite toy or activity?"),
            ) : Container(),
            selected[5]?
            RadioListTile(
              value: 5,
              groupValue: thirdChoice,
              onChanged: (newValue) => setState(() => thirdChoice = newValue),
              title: Text("Smile randomly or at nothing in particular?"),
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
            else widget.nextPage(11, selected, thirdChoice, example, null, thirdChoice < 3);
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