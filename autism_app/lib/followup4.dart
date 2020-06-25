import 'package:autismtest/copyright.dart';
import 'package:autismtest/navigationButtons.dart';
import 'package:autismtest/roundedContainer.dart';
import 'package:flutter/material.dart';

class Followup4 extends StatefulWidget{
  Followup4({Key key, this.nextPage}) : super(key: key);

  final nextPage;

  @override
  State<StatefulWidget> createState() {
    return Followup4State();
  }
}

class Followup4State extends State<Followup4> {

  List<bool> selected = new List<bool>.filled(4, null, growable: true);
  String example;
  final exampleController = TextEditingController();
  final String title = "FollowUp 4";
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
                "Please give an example of something he/she enjoys climbing on:",
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
            color: Colors.lightBlue.withOpacity(0.2),
            children: [
              Text("Does he/she enjoy climbing on…", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold), textAlign: TextAlign.center,)
            ]
        ),
        RoundedContainer(
          context: context,
          outerTitle: false,
          children: <Widget>[
            Text("Stairs?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            _yesOrNoRadio(0),
          ],
        ),
        RoundedContainer(
          context: context,
          outerTitle: false,
          children: <Widget>[
            Text("Chairs?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            _yesOrNoRadio(1),
          ],
        ),
        RoundedContainer(
          context: context,
          outerTitle: false,
          children: <Widget>[
            Text("Furniture?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            _yesOrNoRadio(2),
          ],
        ),
        RoundedContainer(
          context: context,
          outerTitle: false,
          children: <Widget>[
            Text("Playground equipment?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            _yesOrNoRadio(3),
          ],
        ),
        NavigationButtons(
          prevCondition: state > 0,
          previousFunction: () {
            setState(() => state --);
          },
          nextFunction: () {
            if (selected.contains(null)) Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text("Need all responses"),
                  behavior: SnackBarBehavior.floating,
                )
            );
            else widget.nextPage(4, selected, null, example, null, selected.contains(true));
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