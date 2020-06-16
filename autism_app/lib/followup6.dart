import 'package:autismtest/roundedContainer.dart';
import 'package:autismtest/submitButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Followup6 extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return Followup6State();
  }
}

class Followup6State extends State<Followup6> {

  List<bool> _selected = new List<bool>.filled(5, null, growable: true);
  final myTextController = TextEditingController();
  final String title = "FollowUp 6";
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
                "If there is something your child wants that is out of reach, such as a snack or toy that is out of reach, how does he/she get it?",
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
        SubmitButton(
          text: "VALIDATE",
          onPressed: () {
            setState(() {
              if (myTextController.text == "") Fluttertoast.showToast(msg: "Complete the field");
              else print(myTextController.text);
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
                "If you point at something, what does your child typically do?",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              )
            ]
        ),
        RoundedContainer(
          displayTitle: false,
          children: <Widget>[
            Text("Reach for the object with his/her whole hand?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            _yesOrNoRadio(0),
          ],
        ),
        RoundedContainer(
          displayTitle: false,
          children: <Widget>[
            Text("Lead you to the object?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            _yesOrNoRadio(1),
          ],
        ),
        RoundedContainer(
          displayTitle: false,
          children: <Widget>[
            Text("Try to get the object for him/herself?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            _yesOrNoRadio(2),
          ],
        ),
        RoundedContainer(
          displayTitle: false,
          children: <Widget>[
            Text("Ask for it using words or sounds?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            _yesOrNoRadio(3),
          ],
        ),
        SubmitButton(
          text: "VALIDATE",
          padding: EdgeInsets.symmetric(vertical: 120, horizontal: 50),
          onPressed: () {
            setState(() {
              //Need responses
              if (_selected.indexOf(null) != 4) Fluttertoast.showToast(msg: "Need all responses");
              //Respond "Yes" to a any example
              else if (_selected.contains(true)) setState(() {
                state ++;
              });
              //FAILED
              else print("FAILED");
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
              Text(
                "If you said “Show me,” would he/she point at it?",
                style: TextStyle(fontSize: 20,),
                textAlign: TextAlign.center,
              ),
              _yesOrNoRadio(4),
            ],
          ),
          Spacer(),
          SubmitButton(
            text: "VALIDATE",
            padding: EdgeInsets.symmetric(vertical: 120, horizontal: 50),
            onPressed: () {
              setState(() {
                if (_selected[4] == null) Fluttertoast.showToast(msg: "Complete the field");
                else print(_selected[4]);
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