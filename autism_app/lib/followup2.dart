import 'package:autismtest/roundedContainer.dart';
import 'package:autismtest/submitButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Followup2 extends StatefulWidget{
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
              child: Text("Does he/she…", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
          Text("often ignore sounds?", style: TextStyle(fontSize: 18),),
          _yesOrNoRadio(0),
          Text("often ignore people?", style: TextStyle(fontSize: 18),),
          _yesOrNoRadio(1),
        ],
      ),
        SubmitButton(
          text: "VALIDATE",
          onPressed: () {
            setState(() {
              state = 1;
            });
          },
        ),
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
        SubmitButton(
          text: "VALIDATE",
          onPressed: () {
            setState(() {
              state = 2;
            });
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
            Container(
                padding: EdgeInsets.all(20),
                child: Text(
                  "What were the results of the hearing test? (choose one):",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )
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
        SubmitButton(
          text: "VALIDATE",
          onPressed: () {
            print(_selected);
          },
        ),
      ],
    );
  }

  Widget _yesOrNoRadio(index) {
    return Row(
      children: <Widget>[
        Spacer(),
        Container(
          width: 150,
          child: RadioListTile(
            value: 1,
            groupValue: _selected[index],
            onChanged: (newValue) => setState(() => _selected[index] = newValue),
            title: Text("Yes"),
          ),
        ),
        Spacer(),
        Container(
          width: 150,
          child: RadioListTile(
            value: 0,
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