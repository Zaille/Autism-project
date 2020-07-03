import 'package:autismtest/copyright.dart';
import 'package:autismtest/navigationButtons.dart';
import 'package:autismtest/roundedContainer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Followup7 extends StatefulWidget{
  Followup7({Key key, this.nextPage}) : super(key: key);

  final nextPage;

  @override
  State<StatefulWidget> createState() {
    return Followup7State();
  }
}

class Followup7State extends State<Followup7> {

  List<bool> selected = new List<bool>.filled(10, null, growable: true);
  String example;
  final exampleController = TextEditingController();
  final String title = "FollowUp 7";
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
                "Please give an example something "
                    "he/she might point at to show you:",
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
          context: context,
          prevCondition: state > 0,
          previousFunction: () {
            setState(() => state--);
          },
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
            color: Theme.of(context).cardColor,
            children: [
              Text(
                "Does your child sometimes want you to see "
                    "something interesting such as….",
                style: Theme.of(context).textTheme.headline2,
                textAlign: TextAlign.center,
              )
            ]
        ),
        RoundedContainer(
          context: context,
          outerTitle: false,
          children: <Widget>[
            Text(
              "An airplane in the sky?",
              style: TextStyle(fontSize: 18), textAlign: TextAlign.center,
            ),
            yesNoRadio(0),
          ],
        ),
        RoundedContainer(
          context: context,
          outerTitle: false,
          children: <Widget>[
            Text(
              "A truck on the road?",
              style: TextStyle(fontSize: 18), textAlign: TextAlign.center,
            ),
            yesNoRadio(1),
          ],
        ),
        RoundedContainer(
          context: context,
          outerTitle: false,
          children: <Widget>[
            Text(
              "A bug on the ground?",
              style: TextStyle(fontSize: 18), textAlign: TextAlign.center,
            ),
            yesNoRadio(2),
          ],
        ),
        RoundedContainer(
          context: context,
          outerTitle: false,
          children: <Widget>[
            Text(
              "An animal in the yard?",
              style: TextStyle(fontSize: 18), textAlign: TextAlign.center,
            ),
            yesNoRadio(3),
          ],
        ),
        NavigationButtons(
          context: context,
          prevCondition: state > 0,
          previousFunction: () {
            setState(() => state --);
          },
          nextFunction: () {
            //Need responses
            if (selected.sublist(0,4).contains(null)) Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text("Need all responses"),
                  behavior: SnackBarBehavior.floating,
                )
            );
            else if (selected.sublist(0,4).contains(true)) setState(() {
              state ++;
            });
            else widget.nextPage(7, selected, null, example, null, false);
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
              "How does your child draw your attention to it? Would he/she point with one finger?",
              style: TextStyle(fontSize: 20,),
              textAlign: TextAlign.center,
            ),
            yesNoRadio(4),
          ],
        ),
        Spacer(),
        NavigationButtons(
          context: context,
          prevCondition: state > 0,
          previousFunction: () {
            setState(() => state --);
          },
          nextFunction: () {
            if (selected[4] == null) Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text("Complete the field"),
                  behavior: SnackBarBehavior.floating,
                )
            );
            //FAIL
            else if (!selected[4])
              widget.nextPage(7, selected, null, example, null, false);
            //Next Question
            else setState(() {
                state ++;
              });
          },
        ),
        Copyright(),
      ],
    );
  }

  Widget fourthElement() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        RoundedContainer(
          context: context,
          title: title,
          children: [
            Text(
              "Is this to show their interest, not to get help?",
              style: TextStyle(fontSize: 20,),
              textAlign: TextAlign.center,
            ),
            yesNoRadio(5),
          ],
        ),
        Spacer(),
        NavigationButtons(
          context: context,
          prevCondition: state > 0,
          previousFunction: () {
            setState(() => state --);
          },
          nextFunction: () {
            if (selected[5] == null) Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text("Complete the field"),
                  behavior: SnackBarBehavior.floating,
                )
            );
            else if (!selected[5]) widget.nextPage(7, selected, null, example, null, false);
            else widget.nextPage(7, selected, null, example, null, true);
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