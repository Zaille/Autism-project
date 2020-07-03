import 'package:autismtest/copyright.dart';
import 'package:autismtest/navigationButtons.dart';
import 'package:autismtest/roundedContainer.dart';
import 'package:flutter/material.dart';

class Followup10 extends StatefulWidget{

  Followup10({Key key, this.nextPage}) : super(key: key);

  final nextPage;

  @override
  State<StatefulWidget> createState() {
    return Followup10State();
  }
}

class Followup10State extends State<Followup10> {

  List<bool> selected = new List<bool>.filled(7, null, growable: true);
  int thirdChoice = -1;
  String example;
  final exampleController = TextEditingController();
  final String title = "FollowUp 10";
  int state = 0;

  @override
  Widget build(BuildContext context) {
    if (state == 0) return firstElement();
    if (state == 1) return secondElement();
    if (state == 2) return thirdElement();
    if (state == 3) return fourthElement();
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
                "Please give an example of how he/she responds when you call his/her name",
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
                  state  = 2;
                });
              },
            ),
          ],
        ),
        Spacer(),
        NavigationButtons(
          context: context,
          prevCondition: state > 1,
          previousFunction: () {},
          nextFunction: () {
            if (exampleController.text == "") Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text("Complete the field"),
                  behavior: SnackBarBehavior.floating,
                )
            );
            else {
              example = exampleController.text;
              setState(() {
                state = 2;
              });
            }
          },
        ),
        Copyright(),
      ],
    );
  }

  Widget secondElement() {
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
                "If he/she is not involved in something fun or interesting, what does he/she do when you call his/her name?",
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
                  state = 2;
                });
              },
            ),
          ],
        ),
        Spacer(),
        NavigationButtons(
          context: context,
          prevCondition: state > 1,
          previousFunction: () {},
          nextFunction: () {
            if (exampleController.text == "") Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text("Complete the field"),
                  behavior: SnackBarBehavior.floating,
                )
            );
            else {
              example = exampleController.text;
              setState(() {
                state = 2;
              });
            }
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
            Text("Look up?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            yesNoRadio(0),
          ],
        ),
        RoundedContainer(
          context: context,
          outerTitle: false,
          children: <Widget>[
            Text("Talk or babble?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            yesNoRadio(1),
          ],
        ),
        RoundedContainer(
          context: context,
          outerTitle: false,
          children: <Widget>[
            Text("Stop what he/she is doing?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            yesNoRadio(2),
          ],
        ),
        RoundedContainer(
          context: context,
          outerTitle: false,
          children: <Widget>[
            Text("Make no response?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            yesNoRadio(3),
          ],
        ),
        RoundedContainer(
          context: context,
          outerTitle: false,
          children: <Widget>[
            Text("Seem to hear but ignores parent?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            yesNoRadio(4),
          ],
        ),
        RoundedContainer(
          context: context,
          outerTitle: false,
          children: <Widget>[
            Text(
              "Respond only if parent is right in front of the child’s face?",
              style: TextStyle(fontSize: 18), textAlign: TextAlign.center,
            ),
            yesNoRadio(5),
          ],
        ),
        RoundedContainer(
          context: context,
          outerTitle: false,
          children: <Widget>[
            Text("Respond only if touched?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            yesNoRadio(6),
          ],
        ),
        NavigationButtons(
          context: context,
          prevCondition: state > 0,
          previousFunction: () {
            setState(() => state = 0);
          },
          nextFunction: () {
            //Need responses
            if (selected.contains(null)) Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text("Need all responses"),
                  behavior: SnackBarBehavior.floating,
                )
            );
            //"Yes" in "Pass"
            else if (selected.sublist(0,4).contains(true)) {
              //Both "Pass" and "Fail" contain "Yes
              if (selected.sublist(4,7).contains(true)) setState(() {
                state = 3;
              });
              //Only "Pass" contains "Yes" => PASS
              else widget.nextPage(10, selected, null, example, null, true);
            }
            //"Yes" only in "Fail" => FAIL
            else widget.nextPage(10, selected, null, example, null, false);
          },
        ),
        Copyright(),
      ],
    );
  }

  Widget fourthElement() {
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
              title: Text("Look up?"),
            ) : Container(),
            selected[1]?
            RadioListTile(
              value: 1,
              groupValue: thirdChoice,
              onChanged: (newValue) => setState(() => thirdChoice = newValue),
              title: Text("Talk or babble?"),
            ) : Container(),
            selected[2]?
            RadioListTile(
              value: 2,
              groupValue: thirdChoice,
              onChanged: (newValue) => setState(() => thirdChoice = newValue),
              title: Text("Stop what he/she is doing?"),
            ) : Container(),
            selected[3]?
            RadioListTile(
              value: 3,
              groupValue: thirdChoice,
              onChanged: (newValue) => setState(() => thirdChoice = newValue),
              title: Text("Make no response?"),
            ) : Container(),
            selected[4]?
            RadioListTile(
              value: 4,
              groupValue: thirdChoice,
              onChanged: (newValue) => setState(() => thirdChoice = newValue),
              title: Text("Seem to hear but ignores parent?"),
            ) : Container(),
            selected[5]?
            RadioListTile(
              value: 5,
              groupValue: thirdChoice,
              onChanged: (newValue) => setState(() => thirdChoice = newValue),
              title: Text("Respond only if parent is right in front of the child’s face?"),
            ) : Container(),
            selected[6]?
            RadioListTile(
              value: 6,
              groupValue: thirdChoice,
              onChanged: (newValue) => setState(() => thirdChoice = newValue),
              title: Text("Respond only if touched?"),
            ) : Container(),
          ],
        ),
        NavigationButtons(
          context: context,
          prevCondition: state > 0,
          previousFunction: () {
            setState(() => state --);
          },
          nextFunction: () {
            if (thirdChoice == -1) Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text("Complete the field"),
                  behavior: SnackBarBehavior.floating,
                )
            );
            else widget.nextPage(10, selected, thirdChoice, example, null, thirdChoice < 3);
          },
        ),
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