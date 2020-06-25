import 'package:autismtest/copyright.dart';
import 'package:autismtest/navigationButtons.dart';
import 'package:autismtest/roundedContainer.dart';
import 'package:flutter/material.dart';

class Followup6 extends StatefulWidget{
  Followup6({Key key, this.nextPage}) : super(key: key);

  final nextPage;

  @override
  State<StatefulWidget> createState() {
    return Followup6State();
  }
}

class Followup6State extends State<Followup6> {

  List<bool> selected = new List<bool>.filled(5, null, growable: true);
  String example;
  final exampleController = TextEditingController();
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
                "If there is something your child wants that is out of reach, such as a snack or toy that is out of reach, how does he/she get it?",
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
          context: context,
          outerTitle: false,
          children: <Widget>[
            Text("Reach for the object with his/her whole hand?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            _yesOrNoRadio(0),
          ],
        ),
        RoundedContainer(
          context: context,
          outerTitle: false,
          children: <Widget>[
            Text("Lead you to the object?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            _yesOrNoRadio(1),
          ],
        ),
        RoundedContainer(
          context: context,
          outerTitle: false,
          children: <Widget>[
            Text("Try to get the object for him/herself?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            _yesOrNoRadio(2),
          ],
        ),
        RoundedContainer(
          context: context,
          outerTitle: false,
          children: <Widget>[
            Text("Ask for it using words or sounds?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            _yesOrNoRadio(3),
          ],
        ),
        NavigationButtons(
          prevCondition: state > 0,
          previousFunction: () {
            setState(() => state --);
          },
          nextFunction: () {
            //Need responses
            if (selected.indexOf(null) != 4) Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text("Need all responses"),
                  behavior: SnackBarBehavior.floating,
                )
            );
            //Respond "Yes" to a any example
            else if (selected.contains(true)) setState(() {
              state ++;
            });
            //FAIL
            else widget.nextPage(6, selected, null, example, null, false);
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
              "If you said “Show me,” would he/she point at it?",
              style: TextStyle(fontSize: 20,),
              textAlign: TextAlign.center,
            ),
            _yesOrNoRadio(4),
          ],
        ),
        Spacer(),
        NavigationButtons(
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
              else widget.nextPage(6, selected, null, example, null, selected[4]);
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