import 'package:autismtest/roundedContainer.dart';
import 'package:autismtest/submitButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Followup17 extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return Followup17State();
  }
}

class Followup17State extends State<Followup17> {

  List<bool> _selected = new List<bool>.filled(5, null, growable: true);
  final exampleController = TextEditingController();
  final describeController = TextEditingController();
  final String title = "FollowUp 17";
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
                "Please give an example of how he/she would try to get you to watch him/her:",
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
            setState(() {
              if (exampleController.text == "") Fluttertoast.showToast(msg: "Complete the field");
              else print(exampleController.text);
            });
          },
        ),
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
                "Does he/she…",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              )
            ]
        ),
        RoundedContainer(
          displayTitle: false,
          children: <Widget>[
            Text("Say “Look!” or “Watch me!”?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            _yesOrNoRadio(0),
          ],
        ),
        RoundedContainer(
          displayTitle: false,
          children: <Widget>[
            Text("Babble or make a noise to get you to watch what he/ she is doing?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            _yesOrNoRadio(1),
          ],
        ),
        RoundedContainer(
          displayTitle: false,
          children: <Widget>[
            Text("Look at you to get praise or comment?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            _yesOrNoRadio(2),
          ],
        ),
        RoundedContainer(
          displayTitle: false,
          children: <Widget>[
            Text("Keep looking to see if you are looking?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            _yesOrNoRadio(3),
          ],
        ),
        RoundedContainer(
          displayTitle: false,
          children: <Widget>[
            Text("Other (describe):", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            _yesOrNoRadio(4),
          ],
        ),
        (_selected[4] == true)
            ? RoundedContainer(
          displayTitle: false,
          children: [
            TextField(
              controller: describeController,
              minLines: 2,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: "Describe",
                border: OutlineInputBorder(),
              ),
            ),
          ],
        )
            : Container(),
        SubmitButton(
          text: "VALIDATE",
          padding: EdgeInsets.symmetric(vertical: 120, horizontal: 50),
          onPressed: () {
            //Need responses
            if (_selected.contains(null)) Fluttertoast.showToast(msg: "Need all responses");
            //Not enough "Yes"
            else if (_selected.contains(true)) print("PASS");
            //More than 2 "Yes" = PASS
            else print("FAIL");
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
                "Does your child look you in the eye every day?",
                style: TextStyle(fontSize: 20,),
                textAlign: TextAlign.center,
              ),
              _yesOrNoRadio(6),
            ],
          ),
          Spacer(),
          SubmitButton(
            text: "VALIDATE",
            padding: EdgeInsets.symmetric(vertical: 120, horizontal: 50),
            onPressed: () {
              setState(() {
                if (_selected[6] == null) Fluttertoast.showToast(msg: "Complete the field");
                else if (_selected[6] == true)
                  setState(() {
                    state ++;
                  });
                else print("FAILED");
              });
            },
          ),
        ],
      );
    }

  Widget forthElement() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        RoundedContainer(
          title: title,
          children: [
            Text(
              "On a day when you are together all day, does he/she look you in the eye at least 5 times?",
              style: TextStyle(fontSize: 20,),
              textAlign: TextAlign.center,
            ),
            _yesOrNoRadio(6),
          ],
        ),
        Spacer(),
        SubmitButton(
          text: "VALIDATE",
          padding: EdgeInsets.symmetric(vertical: 120, horizontal: 50),
          onPressed: () {
            setState(() {
              if (_selected[6] == null) Fluttertoast.showToast(msg: "Complete the field");
              else if (_selected[6] == true) print("PASS");
              else print("FAILED");
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