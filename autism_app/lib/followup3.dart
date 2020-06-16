import 'package:autismtest/roundedContainer.dart';
import 'package:autismtest/submitButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Followup3 extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return Followup3State();
  }
}

class Followup3State extends State<Followup3> {

  List<bool> _selected = new List<bool>.filled(11, null, growable: true);
  final myTextController = TextEditingController();
  final String title = "FollowUp 3";
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
                "Please give an example of his/her pretend play:",
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
              Text("Does he/she usually…", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold), textAlign: TextAlign.center,)
            ]
        ),
        RoundedContainer(
          displayTitle: false,
          children: <Widget>[
            Text("Pretend to drink from a toy cup?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            _yesOrNoRadio(0),
          ],
        ),
        RoundedContainer(
          displayTitle: false,
          children: <Widget>[
            Text("Pretend to eat from a toy spoon or fork?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            _yesOrNoRadio(1),
          ],
        ),
        RoundedContainer(
          displayTitle: false,
          children: <Widget>[
            Text("Pretend to talk on the telephone?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            _yesOrNoRadio(2),
          ],
        ),
        RoundedContainer(
          displayTitle: false,
          children: <Widget>[
            Text("Pretend to feed a doll or stuffed animal with real or imaginary food?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            _yesOrNoRadio(3),
          ],
        ),
        RoundedContainer(
          displayTitle: false,
          children: <Widget>[
            Text("Push a car as if it is going along a pretend road?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            _yesOrNoRadio(4),
          ],
        ),
        RoundedContainer(
          displayTitle: false,
          children: <Widget>[
            Text("Pretend to be a robot, an airplane, a ballerina, or any other favorite character?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            _yesOrNoRadio(5),
          ],
        ),
        RoundedContainer(
          displayTitle: false,
          children: <Widget>[
            Text("Put a toy pot on a pretend stove?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            _yesOrNoRadio(6),
          ],
        ),
        RoundedContainer(
          displayTitle: false,
          children: <Widget>[
            Text("Stir imaginary food?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            _yesOrNoRadio(7),
          ],
        ),
        RoundedContainer(
          displayTitle: false,
          children: <Widget>[
            Text("Put an action figure or doll into a car or truck as if it is the driver or passenger?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            _yesOrNoRadio(8),
          ],
        ),
        RoundedContainer(
          displayTitle: false,
          children: <Widget>[
            Text("Pretend to vacuum the rug, sweep the floor, or the mow lawn?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            _yesOrNoRadio(9),
          ],
        ),
        RoundedContainer(
          displayTitle: false,
          children: <Widget>[
            Text("Other (describe)", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            _yesOrNoRadio(10),
          ],
        ),
        SubmitButton(
          text: "VALIDATE",
          padding: EdgeInsets.symmetric(vertical: 100, horizontal: 50),
          onPressed: () {
            setState(() {
              if (_selected.contains(null)) Fluttertoast.showToast(msg: "No response selected");
              else print(_selected);
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