import 'package:autismtest/copyright.dart';
import 'package:autismtest/navigationButtons.dart';
import 'package:autismtest/roundedContainer.dart';
import 'package:flutter/material.dart';

class Followup9 extends StatefulWidget{
  Followup9({Key key, this.nextPage}) : super(key: key);

  final nextPage;

  @override
  State<StatefulWidget> createState() {
    return Followup9State();
  }
}

class Followup9State extends State<Followup9> {

  List<bool> selected = new List<bool>.filled(7, null, growable: true);
  String example;
  String description;
  final exampleController = TextEditingController();
  final describeController = TextEditingController();
  final String title = "FollowUp 9";
  int state = 0;

  @override
  Widget build(BuildContext context) {
    if (state == 0) return firstElement();
    if (state == 1) return secondElement();
    if (state == 2) return thirdElement();
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
                "Please give an example of something he/she might bring to show you or hold up for you to see:",
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
              Text(
                "Does your child sometimes bring you…",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              )
            ]
        ),
        RoundedContainer(
          context: context,
          outerTitle: false,
          children: <Widget>[
            Text("A picture or toy just to show you?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            _yesOrNoRadio(0),
          ],
        ),
        RoundedContainer(
          context: context,
          outerTitle: false,
          children: <Widget>[
            Text("A drawing he/she has done?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            _yesOrNoRadio(1),
          ],
        ),
        RoundedContainer(
          context: context,
          outerTitle: false,
          children: <Widget>[
            Text("A flower he/she has picked?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            _yesOrNoRadio(2),
          ],
        ),
        RoundedContainer(
          context: context,
          outerTitle: false,
          children: <Widget>[
            Text("A bug he/she has found in the grass?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            _yesOrNoRadio(3),
          ],
        ),
        RoundedContainer(
          context: context,
          outerTitle: false,
          children: <Widget>[
            Text("A few blocks he/she has put together?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            _yesOrNoRadio(4),
          ],
        ),
        RoundedContainer(
          context: context,
          outerTitle: false,
          children: <Widget>[
            Text("Other (describe):", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            _yesOrNoRadio(5),
          ],
        ),
        (selected[5] == true)
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
            //Need responses
            if (selected.indexOf(null) != 6)
              Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Need all responses"),
                    behavior: SnackBarBehavior.floating,
                  )
              );
            //Respond "Yes" to a any example => Next question
            else if (selected.contains(true))
              setState(() {
                state ++;
              });
            //FAIL
            else widget.nextPage(9, selected, null, example, description, false);
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
              "Is this sometimes just to show you, not to get help?",
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
            if (selected[6] == null) Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text("Complete the field"),
                  behavior: SnackBarBehavior.floating,
                )
            );
            //PASS
            else if(selected[6]) widget.nextPage(9, selected, null, example, description, true);
            //FAIL
            else widget.nextPage(9, selected, null, example, description, false);
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