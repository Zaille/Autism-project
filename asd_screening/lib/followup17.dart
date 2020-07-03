import 'package:asdscreening/copyright.dart';
import 'package:asdscreening/navigationButtons.dart';
import 'package:asdscreening/roundedContainer.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Followup17 extends StatefulWidget{
  Followup17({Key key, this.nextPage}) : super(key: key);

  final nextPage;

  @override
  State<StatefulWidget> createState() {
    return Followup17State();
  }
}

class Followup17State extends State<Followup17> {

  List<bool> selected = new List<bool>.filled(5, null, growable: true);
  String example;
  String description;
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
              color: Theme.of(context).backgroundColor,
              textColor: Theme.of(context).accentColor,
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
          context: context,
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
            color: Theme.of(context).cardColor,
            children: [
              Text(
                "Does he/she…",
                style: Theme.of(context).textTheme.headline2,
                textAlign: TextAlign.center,
              )
            ]
        ),
        RoundedContainer(
          context: context,
          outerTitle: false,
          children: <Widget>[
            Text("Say “Look!” or “Watch me!”?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            yesNoRadio(0),
          ],
        ),
        RoundedContainer(
          context: context,
          outerTitle: false,
          children: <Widget>[
            Text("Babble or make a noise to get you to watch what he/ she is doing?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            yesNoRadio(1),
          ],
        ),
        RoundedContainer(
          context: context,
          outerTitle: false,
          children: <Widget>[
            Text("Look at you to get praise or comment?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            yesNoRadio(2),
          ],
        ),
        RoundedContainer(
          context: context,
          outerTitle: false,
          children: <Widget>[
            Text("Keep looking to see if you are looking?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            yesNoRadio(3),
          ],
        ),
        RoundedContainer(
          context: context,
          outerTitle: false,
          children: <Widget>[
            Text("Other (describe):", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            yesNoRadio(4),
          ],
        ),
        (selected[4] == true)
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
          context: context,
          prevCondition: state > 0,
          previousFunction: () {
            setState(() => state --);
          },
          nextFunction: () {
            //Need responses
            if (selected.contains(null) | (selected[4] & (describeController.text == "")))
              Fluttertoast.showToast(msg: "Need all responses");
            //Send data
            else {
              if (selected[4]) description = describeController.text;
              widget.nextPage(17, selected, null, example, description, selected.contains(true));
            }
          },
        ),
        Copyright(),
      ],
    );
  }

  Widget yesNoRadio(index) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: RadioListTile(
              value: true,
              groupValue: selected[index],
              onChanged: (newValue) => setState(() => selected[index] = newValue),
              activeColor: Theme.of(context).accentColor,
              title: Text("Yes"),
            ),
          ),
          Expanded(
            child: RadioListTile(
              value: false,
              groupValue: selected[index],
              onChanged: (newValue) => setState(() => selected[index] = newValue),
              activeColor: Theme.of(context).accentColor,
              title: Text("No"),
            ),
          ),
        ],
      ),
    );
  }
}