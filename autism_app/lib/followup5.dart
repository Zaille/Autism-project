import 'package:autismtest/roundedContainer.dart';
import 'package:autismtest/submitButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Followup5 extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return Followup5State();
  }
}

class Followup5State extends State<Followup5> {

  List<bool> _selected = new List<bool>.filled(8, null, growable: true);
  final describeController = TextEditingController();
  final String title = "FollowUp 5";
  int state = 0;

  @override
  Widget build(BuildContext context) {
    if (state == 0) return firstElement();
    if (state == 1) return secondElement();
    return Spacer();
  }

  Widget firstElement() {
    return ListView(
      children: <Widget>[
        RoundedContainer(
            title: title,
            color: Colors.lightBlue.withOpacity(0.2),
            children: [
              Text("Does he/she … ", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold), textAlign: TextAlign.center,)
            ]
        ),
        RoundedContainer(
          displayTitle: false,
          children: <Widget>[
            Text("Look at hands?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            _yesOrNoRadio(0),
          ],
        ),
        RoundedContainer(
          displayTitle: false,
          children: <Widget>[
            Text("Move fingers when playing peek-a-boo?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            _yesOrNoRadio(1),
          ],
        ),
        RoundedContainer(
          displayTitle: false,
          children: <Widget>[
            Text("Wiggle his/her fingers near his/her eyes?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            _yesOrNoRadio(2),
          ],
        ),
        RoundedContainer(
          displayTitle: false,
          children: <Widget>[
            Text("Hold his/her hands up close to his/her eyes?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            _yesOrNoRadio(3),
          ],
        ),
        RoundedContainer(
          displayTitle: false,
          children: <Widget>[
            Text("Hold his/her hands off to the side of his/her eyes?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            _yesOrNoRadio(4),
          ],
        ),
        RoundedContainer(
          displayTitle: false,
          children: <Widget>[
            Text("Flap his/her hands near his/her face?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            _yesOrNoRadio(5),
          ],
        ),
        RoundedContainer(
          displayTitle: false,
          children: <Widget>[
            Text("Other", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            _yesOrNoRadio(6),
          ],
        ),
        (_selected[6] == true)
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
            setState(() {
              //Need responses
              if (_selected.indexOf(null) != 7) Fluttertoast.showToast(msg: "Need all responses");
              //Respond "Yes" to a "fail" example
              else if (_selected.sublist(2, 7).contains(true)) setState(() {
                state ++;
              });
              //No to all "fail" responses
              else print(_selected);
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
            Text(
              "Does this happen more than twice a week?",
              style: TextStyle(fontSize: 20,),
              textAlign: TextAlign.center,
            ),
            _yesOrNoRadio(7),
          ],
        ),
        Spacer(),
        SubmitButton(
          text: "VALIDATE",
          padding: EdgeInsets.symmetric(vertical: 120, horizontal: 50),
          onPressed: () {
            setState(() {
              if (describeController.text == "") Fluttertoast.showToast(msg: "Complete the field");
              else print(describeController.text);
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