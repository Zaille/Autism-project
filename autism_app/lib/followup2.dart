import 'package:autismtest/copyright.dart';
import 'package:autismtest/copyright.dart';
import 'package:autismtest/copyright.dart';
import 'package:autismtest/roundedContainer.dart';
import 'package:autismtest/submitButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Followup2 extends StatefulWidget{
  Followup2({Key key, this.nextPage}) : super(key: key);

  final nextPage;

  @override
  State<StatefulWidget> createState() {
    return Followup2State();
  }
}

class Followup2State extends State<Followup2> {

  List<int> _selected = [-1, -1, -1, -1];
  final String title = "FollowUp 2";
  int state = 0;

  @override
  Widget build(BuildContext context) {
    if (state == 0) return firstElement();
    if (state == 1) return secondElement();
    if (state == 2) return thirdElement();
    return Spacer();
  }

  Widget firstElement() {
    return ListView(
        children: <Widget>[
        RoundedContainer(
          title: title,
          color: Colors.lightBlue.withOpacity(0.2),
          children: [
            Text(
              "You reported that you have wondered if you child is deaf. What led you to wonder that?\n Does he/she…",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            )
          ]
        ),
        RoundedContainer(
          displayTitle: false,
          children: <Widget>[
            Text("Often ignore sounds?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            _yesOrNoRadio(0),
          ],
        ),
        RoundedContainer(
          displayTitle: false,
          children: <Widget>[
            Text("Often ignore people?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            _yesOrNoRadio(1),
          ],
        ),
        SubmitButton(
          text: "VALIDATE",
          padding: EdgeInsets.symmetric(vertical: 100, horizontal: 50),
          onPressed: () {
            setState(() {
              if ((_selected[0] == -1) | (_selected[1] == -1))Fluttertoast.showToast(msg: "No response selected");
              else state ++;
            });
          },
        ),
        Copyright(),
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
            Text("Has your child’s hearing been tested?", style: TextStyle(fontSize: 18),),
            _yesOrNoRadio(2)
          ],
        ),
        Spacer(),
        SubmitButton(
          text: "VALIDATE",
          onPressed: () {
            setState(() {
              if (_selected[2] == -1) Fluttertoast.showToast(msg: "No response selected");
              else if (_selected[2] == 1) state ++;
              else print(_selected);
            });
          },
        ),
        Copyright(),
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
              "What were the results of the hearing test? (choose one):",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            RadioListTile(
              value: 0,
              groupValue: _selected[3],
              onChanged: (newValue) => setState(() => _selected[3] = newValue),
              title: Text("Hearing in normal range"),
            ),
            RadioListTile(
              value: 1,
              groupValue: _selected[3],
              onChanged: (newValue) => setState(() => _selected[3] = newValue),
              title: Text("Hearing below normal"),
            ),
            RadioListTile(
              value: 2,
              groupValue: _selected[3],
              onChanged: (newValue) => setState(() => _selected[3] = newValue),
              title: Text("Results inconclusive or not definitive"),
            ),
          ],
        ),
        Spacer(),
        SubmitButton(
          text: "VALIDATE",
          onPressed: () {
            if (_selected[3] == -1) Fluttertoast.showToast(msg: "No response selected");
            else print(_selected);
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
          child: Container(
            child: RadioListTile(
              value: 1,
              groupValue: _selected[index],
              onChanged: (newValue) => setState(() => _selected[index] = newValue),
              title: Text("Yes"),
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Container(
            child: RadioListTile(
              value: 0,
              groupValue: _selected[index],
              onChanged: (newValue) => setState(() => _selected[index] = newValue),
              title: Text("No"),
            ),
          ),
        ),
        Spacer(),
      ],
    );
  }
}