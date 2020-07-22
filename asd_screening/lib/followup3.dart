import 'package:asdscreening/copyright.dart';
import 'package:asdscreening/navigationButtons.dart';
import 'package:asdscreening/roundedContainer.dart';
import 'package:flutter/material.dart';

class Followup3 extends StatefulWidget{
  Followup3({Key key, this.nextPage}) : super(key: key);

  final nextPage;

  @override
  State<StatefulWidget> createState() {
    return Followup3State();
  }
}

class Followup3State extends State<Followup3> {

  List<bool> selected = new List<bool>.filled(11, null, growable: true);
  String example;
  String description;
  final exampleController = TextEditingController();
  final describeController = TextEditingController();
  final String title = "FollowUp 3";
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
                "Please give an example of his/her pretend play:",
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
            //Need a response
            if (exampleController.text == "")
              Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Complete the field"),
                    behavior: SnackBarBehavior.floating,
                  )
              );
            //Next question
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
              Text("Does he/she usually…", style: Theme.of(context).textTheme.headline2, textAlign: TextAlign.center,)
            ]
        ),
        RoundedContainer(
          context: context, 
          outerTitle: false,
          children: <Widget>[
            Text("Pretend to drink from a toy cup?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            yesNoRadio(0),
          ],
        ),
        RoundedContainer(
          context: context, 
          outerTitle: false,
          children: <Widget>[
            Text("Pretend to eat from a toy spoon or fork?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            yesNoRadio(1),
          ],
        ),
        RoundedContainer(
          context: context, 
          outerTitle: false,
          children: <Widget>[
            Text("Pretend to talk on the telephone?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            yesNoRadio(2),
          ],
        ),
        RoundedContainer(
          context: context, 
          outerTitle: false,
          children: <Widget>[
            Text("Pretend to feed a doll or stuffed animal with real or imaginary food?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            yesNoRadio(3),
          ],
        ),
        RoundedContainer(
          context: context, 
          outerTitle: false,
          children: <Widget>[
            Text("Push a car as if it is going along a pretend road?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            yesNoRadio(4),
          ],
        ),
        RoundedContainer(context: context, 
          outerTitle: false,
          children: <Widget>[
            Text("Pretend to be a robot, an airplane, a ballerina, or any other favorite character?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            yesNoRadio(5),
          ],
        ),
        RoundedContainer(context: context, 
          outerTitle: false,
          children: <Widget>[
            Text("Put a toy pot on a pretend stove?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            yesNoRadio(6),
          ],
        ),
        RoundedContainer(context: context, 
          outerTitle: false,
          children: <Widget>[
            Text("Stir imaginary food?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            yesNoRadio(7),
          ],
        ),
        RoundedContainer(context: context, 
          outerTitle: false,
          children: <Widget>[
            Text("Put an action figure or doll into a car or truck as if it is the driver or passenger?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            yesNoRadio(8),
          ],
        ),
        RoundedContainer(context: context, 
          outerTitle: false,
          children: <Widget>[
            Text("Pretend to vacuum the rug, sweep the floor, or the mow lawn?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            yesNoRadio(9),
          ],
        ),
        RoundedContainer(context: context, 
          outerTitle: false,
          children: <Widget>[
            Text("Other (describe)", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            yesNoRadio(10),
          ],
        ),
        (selected[10] == true)
            ? RoundedContainer(context: context, 
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
            if (selected.contains(null) | (selected[10] & (describeController.text == "")))
              Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Complete all fields"),
                    behavior: SnackBarBehavior.floating,
                  )
              );
            else {
              if (selected[10]) description = describeController.text;
              widget.nextPage(3, selected, null, example, description, selected.contains(true));
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