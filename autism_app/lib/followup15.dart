import 'package:autismtest/copyright.dart';
import 'package:autismtest/navigationButtons.dart';
import 'package:autismtest/roundedContainer.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Followup15 extends StatefulWidget{
  Followup15({Key key, this.nextPage}) : super(key: key);

  final nextPage;

  @override
  State<StatefulWidget> createState() {
    return Followup15State();
  }
}

class Followup15State extends State<Followup15> {

  List<bool> selected = new List<bool>.filled(8, null, growable: true);
  String example;
  String description;
  final exampleController = TextEditingController();
  final describeController = TextEditingController();
  final String title = "FollowUp 15";
  int state = 0;

  @override
  Widget build(BuildContext context) {
    if (state == 0) return firstElement();
    if (state == 1) return secondElement();
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
                "Please give an example of something he/she would try to copy:",
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
    if(description != null) describeController.text = description;
    return ListView(
      children: <Widget>[
        RoundedContainer(
          context: context,
            title: title,
            color: Colors.lightBlue.withOpacity(0.2),
            children: [
              Text(
                "Does your child try to copy you if you…",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              )
            ]
        ),
        RoundedContainer(
          context: context,
          outerTitle: false,
          children: <Widget>[
            Text("Stick out your tongue? ", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            _yesOrNoRadio(0),
          ],
        ),
        RoundedContainer(
          context: context,
          outerTitle: false,
          children: <Widget>[
            Text("Make a funny sound?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            _yesOrNoRadio(1),
          ],
        ),
        RoundedContainer(
          context: context,
          outerTitle: false,
          children: <Widget>[
            Text("Wave good bye?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            _yesOrNoRadio(2),
          ],
        ),
        RoundedContainer(
          context: context,
          outerTitle: false,
          children: <Widget>[
            Text("Clap your hands?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            _yesOrNoRadio(3),
          ],
        ),
        RoundedContainer(
          context: context,
          outerTitle: false,
          children: <Widget>[
            Text("Put your fingers to your lips to signal “Shhh”?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            _yesOrNoRadio(4),
          ],
        ),
        RoundedContainer(
          context: context,
          outerTitle: false,
          children: <Widget>[
            Text("Blow a kiss?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            _yesOrNoRadio(5),
          ],
        ),
        RoundedContainer(
          context: context,
          outerTitle: false,
          children: <Widget>[
            Text("Other (describe):", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            _yesOrNoRadio(6),
          ],
        ),
        (selected[6] == true)
            ? RoundedContainer(
          context: context,
          outerTitle: false,
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
        NavigationButtons(
          prevCondition: state > 0,
          previousFunction: () {
            setState(() => state --);
          },
          nextFunction: () {
            int nbYes = 0;
            selected.forEach((element) { if (element == true) nbYes++;});
            //Need responses
            if (selected.contains(null) | (selected[6] & (describeController.text == "")))
              Fluttertoast.showToast(msg: "Need all responses");
            //Send data
            else {
              if (selected[6]) description = describeController.text;
              widget.nextPage(15, selected, null, example, description, nbYes > 1);
            }
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
          context: context,
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
        NavigationButtons(
          prevCondition: state > 0,
          previousFunction: () {
            setState(() => state --);
          },
          nextFunction: () {
            //Need a response
            if (selected[6] == null) Fluttertoast.showToast(msg: "Complete the field");
            //NExt question
            else if (selected[6] == true)
              setState(() {
                state ++;
              });
            //FAIL
            else widget.nextPage(15, selected, null, example, description, false);
          },
        ),
        Copyright(),
      ],
    );
  }

  Widget forthElement() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        RoundedContainer(
          context: context,
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
        NavigationButtons(
          prevCondition: state > 0,
          previousFunction: () {
            setState(() => state --);
          },
          nextFunction: () {
            if (selected[6] == null) Fluttertoast.showToast(msg: "Complete the field");
            else widget.nextPage(15, selected, null, example, description, selected[6]);
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