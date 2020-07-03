import 'package:autismtest/copyright.dart';
import 'package:autismtest/navigationButtons.dart';
import 'package:autismtest/roundedContainer.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Followup18 extends StatefulWidget{
  Followup18({Key key, this.nextPage}) : super(key: key);

  final nextPage;

  @override
  State<StatefulWidget> createState() {
    return Followup18State();
  }
}

class Followup18State extends State<Followup18> {

  List<bool> selected = new List<bool>.filled(5, null, growable: true);
  String example;
  final exampleController = TextEditingController();
  final String title = "FollowUp 18";
  int state = 0;

  @override
  Widget build(BuildContext context) {
    if (state == 0) return firstElement();
    if (state == 1) return secondElement();
    if (state == 2) return thirdElement();
    if (state == 3) return forthElement();
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
                "Please give an example of how you know he/she understands you:",
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        RoundedContainer(
          context: context,
          title: title,
          children: [
            Text(
              "When the situation gives him/her a clue, can he/she follow a command?\nFor example "
                  "when you are dressed to go out and you tell him/her to get his/her shoes, does he/she understand?",
              style: TextStyle(fontSize: 20,),
              textAlign: TextAlign.center,
            ),
            yesNoRadio(0),
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
            if (selected[0] == null) Fluttertoast.showToast(msg: "Complete the field");
            else if (selected[0]) setState(() {
              state = 3;
            });
            else setState(() {
                state = 2;
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
          context: context,
          title: title,
          children: [
            Text(
              "If it is dinnertime and food is on the table, and "
                  "you tell the child to sit down, will he/she come sit at the table?",
              style: TextStyle(fontSize: 20,),
              textAlign: TextAlign.center,
            ),
            yesNoRadio(1),
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
            //Need a response
            if (selected[1] == null) Fluttertoast.showToast(msg: "Complete the field");
            //Next question
            else if (selected[1]) setState(() {
              state = 3;
            });
            //FAIL
            else widget.nextPage(18, selected, null, example, null, false);
          },
        ),
        Copyright(),
      ],
    );
  }

  Widget forthElement() {
    return ListView(
      children: <Widget>[
        RoundedContainer(
          context: context,
            title: title,
            color: Theme.of(context).cardColor,
            children: [
              Text(
                "When the situation does not give any clues, "
                    "can he/she follow a command? For example… ",
                style: Theme.of(context).textTheme.headline2,
                textAlign: TextAlign.center,
              )
            ]
        ),
        RoundedContainer(
          context: context,
          outerTitle: false,
          children: <Widget>[
            Text("If you say, “Show me your shoe” without "
                "pointing, making gestures, or giving hints "
                "(when you are not going out or getting "
                "dressed), does your child show you his/her shoe?",
              style: TextStyle(fontSize: 18), textAlign: TextAlign.center,
            ),
            yesNoRadio(2),
          ],
        ),
        RoundedContainer(
          context: context,
          outerTitle: false,
          children: <Widget>[
            Text("If you say, “Bring me the blanket” or ask "
                "for another object without pointing, making "
                "gestures, or giving hints, does your child bring "
                "it to you?",
              style: TextStyle(fontSize: 18), textAlign: TextAlign.center,
            ),
            yesNoRadio(3),
          ],
        ),
        RoundedContainer(
          context: context,
          outerTitle: false,
          children: <Widget>[
            Text("If you say, “Put the book on the chair "
                "without pointing, making gestures, or giving "
                "any other hints , does your child put the book "
                "on the chair?",
              style: TextStyle(fontSize: 18), textAlign: TextAlign.center,
            ),
            yesNoRadio(4),
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
            if (selected.contains(null)) Fluttertoast.showToast(msg: "Need all responses");
            //Send data
            else widget.nextPage(18, selected, null, example, null, selected.sublist(2,5).contains(true));
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