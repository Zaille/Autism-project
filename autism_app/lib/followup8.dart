import 'package:autismtest/copyright.dart';
import 'package:autismtest/navigationButtons.dart';
import 'package:autismtest/roundedContainer.dart';
import 'package:flutter/material.dart';

class Followup8 extends StatefulWidget{
  Followup8({Key key, this.nextPage}) : super(key: key);

  final nextPage;

  @override
  State<StatefulWidget> createState() {
    return Followup8State();
  }
}

class Followup8State extends State<Followup8> {

  List<bool> selected = new List<bool>.filled(10, null, growable: true);
  String example;
  final exampleController = TextEditingController();
  final String title = "FollowUp 8";
  int state = 0;

  @override
  Widget build(BuildContext context) {
    if (state == 0) return firstElement();
    if (state == 1) return secondElement();
    if (state == 2) return thirdElement();
    if (state == 3) return fourthElement();
    if (state == 4) return fifthElement();
    return Spacer();
  }

  Widget firstElement() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        RoundedContainer(
          context: context,
          title: title,
          children: [
            Text(
              "Is he/she interested in children who are not his/her brother or sister?",
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
          previousFunction: () {},
          nextFunction: () {
              if (selected[0] == null) Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Complete the field"),
                    behavior: SnackBarBehavior.floating,
                  )
              );
              else if (selected[0]) widget.nextPage(8, selected, null, example, null, true);
              else setState(() {
                state ++;
              });
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
              "When you are at the playground or supermarket, "
              "does your child usually respond to other children?",
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
            //Need response
            if (selected[1] == null) Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text("Complete the field"),
                  behavior: SnackBarBehavior.floating,
                )
            );
            //FAIL
            else if (!selected[1]) widget.nextPage(8, selected, null, example, null, false);
            //Next question
            else setState(() {
                state ++;
              });
          },
        ),
        Copyright(),
      ],
    );
  }

  Widget thirdElement() {
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
                "How does your child respond?",
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

  Widget fourthElement() {
    return ListView(
      children: <Widget>[
        RoundedContainer(
          context: context,
            title: title,
            color: Theme.of(context).cardColor,
            children: [
              Text(
                "Does your child…",
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
              "Play with another child?",
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
              "Talk to another child?",
              style: TextStyle(fontSize: 18), textAlign: TextAlign.center,
            ),
            yesNoRadio(3),
          ],
        ),
        RoundedContainer(
          context: context,
          outerTitle: false,
          children: <Widget>[
            Text(
              "Babble or make vocal noises?",
              style: TextStyle(fontSize: 18), textAlign: TextAlign.center,
            ),
            yesNoRadio(4),
          ],
        ),
        RoundedContainer(
          context: context,
          outerTitle: false,
          children: <Widget>[
            Text(
              "Watch another child?",
              style: TextStyle(fontSize: 18), textAlign: TextAlign.center,
            ),
            yesNoRadio(5),
          ],
        ),
        RoundedContainer(
          context: context,
          outerTitle: false,
          children: <Widget>[
            Text("Smile at another child?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            yesNoRadio(6),
          ],
        ),
        RoundedContainer(
          context: context,
          outerTitle: false,
          children: <Widget>[
            Text(
              "Act shy at first but then smile?",
              style: TextStyle(fontSize: 18), textAlign: TextAlign.center,
            ),
            yesNoRadio(7),
          ],
        ),
        RoundedContainer(
          context: context,
          outerTitle: false,
          children: <Widget>[
            Text(
              "Get excited about another child?",
              style: TextStyle(fontSize: 18), textAlign: TextAlign.center,
            ),
            yesNoRadio(8),
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
            if (selected.sublist(2,9).contains(null)) Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text("Need all responses"),
                  behavior: SnackBarBehavior.floating,
                )
            );
            //Next question
            else if (selected.sublist(2,9).contains(true))
              setState(() {
                state ++;
              });
            //FAIL
            else widget.nextPage(8, selected, null, example, null, false);
          },
        ),
        Copyright(),
      ],
    );
  }

  Widget fifthElement() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          RoundedContainer(
          context: context,
            title: title,
            children: [
              Text(
                "Does he/she respond to other children "
                "more than half of the time?",
                style: TextStyle(fontSize: 20,),
                textAlign: TextAlign.center,
              ),
              yesNoRadio(9),
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
              if (selected[9] == null) Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Complete the field"),
                    behavior: SnackBarBehavior.floating,
                  )
              );
              //PASS
              else if (selected[9]) widget.nextPage(8, selected, null, example, null, true);
              //FAIL
              else widget.nextPage(8, selected, null, example, null, false);
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