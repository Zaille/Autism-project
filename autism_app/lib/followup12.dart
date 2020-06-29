import 'package:autismtest/copyright.dart';
import 'package:autismtest/navigationButtons.dart';
import 'package:autismtest/roundedContainer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Followup12 extends StatefulWidget{
  Followup12({Key key, this.nextPage}) : super(key: key);

  final nextPage;

  @override
  State<StatefulWidget> createState() {
    return Followup12State();
  }
}

class Followup12State extends State<Followup12> {

  List<bool> selected = new List<bool>.filled(15, null, growable: true);
  String example;
  String description;
  int thirdChoice = -1;
  final exampleController = TextEditingController();
  final describeController = TextEditingController();
  final String title = "FollowUp 12";
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
    if(description != null) describeController.text = description;
    return ListView(
      children: <Widget>[
        RoundedContainer(
          context: context,
            title: title,
            color: Colors.lightBlue.withOpacity(0.2),
            children: [
              Text(
                "Does your child have a negative reaction to the sound of…",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              )
            ]
        ),
        RoundedContainer(
          context: context,
          outerTitle: false,
          children: <Widget>[
            Text("A washing machine?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            yesNoRadio(0),
          ],
        ),
        RoundedContainer(
          context: context,
          outerTitle: false,
          children: <Widget>[
            Text("Babies crying?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            yesNoRadio(1),
          ],
        ),
        RoundedContainer(
          context: context,
          outerTitle: false,
          children: <Widget>[
            Text("Vacuum cleaner?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            yesNoRadio(2),
          ],
        ),
        RoundedContainer(
          context: context,
          outerTitle: false,
          children: <Widget>[
            Text("Hairdryer?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            yesNoRadio(3),
          ],
        ),
        RoundedContainer(
          context: context,
          outerTitle: false,
          children: <Widget>[
            Text("Traffic?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            yesNoRadio(4),
          ],
        ),
        RoundedContainer(
          context: context,
          outerTitle: false,
          children: <Widget>[
            Text("Babies squealing or screeching?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            yesNoRadio(5),
          ],
        ),
        RoundedContainer(
          context: context,
          outerTitle: false,
          children: <Widget>[
            Text("Loud music?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            yesNoRadio(6),
          ],
        ),
        RoundedContainer(
          context: context,
          outerTitle: false,
          children: <Widget>[
            Text("Telephone/ doorbell ringing?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            yesNoRadio(7),
          ],
        ),
        RoundedContainer(
          context: context,
          outerTitle: false,
          children: <Widget>[
            Text("Noisy places such as a supermarket or restaurant?",
              style: TextStyle(fontSize: 18), textAlign: TextAlign.center,
            ),
            yesNoRadio(8),
          ],
        ),
        RoundedContainer(
          context: context,
          outerTitle: false,
          children: <Widget>[
            Text("Other (describe):", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            yesNoRadio(9),
          ],
        ),
        (selected[9] == true)
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
          previousFunction: () {},
          nextFunction: () {
            int nbYes = 0;
            //Need responses
            if (selected.sublist(0,10).contains(null) | (selected[9] & (describeController.text == "")))
              Fluttertoast.showToast(msg: "Need all responses");
            else {
              if (selected[9]) description = describeController.text;
              selected.sublist(0,10).forEach((element) {if(element) nbYes++;});
              //Too much "Yes" => Next question
              if (nbYes > 1) setState(() {
                state ++;
              });
              //PASS
              else widget.nextPage(12, selected, null, example, description, true);
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
                "How does your child react to those noises?",
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
            setState(() => state --);
          },
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

  Widget thirdElement() {
    return ListView(
      children: <Widget>[
        RoundedContainer(
          context: context,
            title: title,
            color: Colors.lightBlue.withOpacity(0.2),
            children: [
              Text(
                "Does your child…",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              )
            ]
        ),
        RoundedContainer(
          context: context,
          outerTitle: false,
          children: <Widget>[
            Text("Calmly cover his/her ears?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            yesNoRadio(10),
          ],
        ),
        RoundedContainer(
          context: context,
          outerTitle: false,
          children: <Widget>[
            Text("Tell you that he/she does not like the noise?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            yesNoRadio(11),
          ],
        ),
        RoundedContainer(
          context: context,
          outerTitle: false,
          children: <Widget>[
            Text("Scream?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            yesNoRadio(12),
          ],
        ),
        RoundedContainer(
          context: context,
          outerTitle: false,
          children: <Widget>[
            Text("Cry?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            yesNoRadio(13),
          ],
        ),
        RoundedContainer(
          context: context,
          outerTitle: false,
          children: <Widget>[
            Text("Cover his/her ears while upset?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            yesNoRadio(14),
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
            //"Yes" in "Pass"
            else if (selected.sublist(10,12).contains(true)) {
              //Both "Pass" and "Fail" contain "Yes
              if (selected.sublist(12,15).contains(true)) setState(() {
                state ++;
              });
              //Only "Pass" contains "Yes" => PASS
              else widget.nextPage(12, selected, null, example, description, true);
            }
            //"Yes" only in "Fail" => FAIL
            else  widget.nextPage(12, selected, null, example, description, false);
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
            selected[10]?
            RadioListTile(
              value: 10,
              groupValue: thirdChoice,
              onChanged: (newValue) => setState(() => thirdChoice = newValue),
              title: Text("Calmly cover his/her ears?"),
            ) : Container(),
            selected[11]?
            RadioListTile(
              value: 11,
              groupValue: thirdChoice,
              onChanged: (newValue) => setState(() => thirdChoice = newValue),
              title: Text("Tell you that he/she does not like the noise?"),
            ) : Container(),
            selected[12]?
            RadioListTile(
              value: 12,
              groupValue: thirdChoice,
              onChanged: (newValue) => setState(() => thirdChoice = newValue),
              title: Text("Scream?"),
            ) : Container(),
            selected[13]?
            RadioListTile(
              value: 13,
              groupValue: thirdChoice,
              onChanged: (newValue) => setState(() => thirdChoice = newValue),
              title: Text("Cry?"),
            ) : Container(),
            selected[14]?
            RadioListTile(
              value: 14,
              groupValue: thirdChoice,
              onChanged: (newValue) => setState(() => thirdChoice = newValue),
              title: Text("Cover his/her ears while upset?"),
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
            if (thirdChoice == -1) Fluttertoast.showToast(msg: "Complete the field");
            else  widget.nextPage(12, selected, null, example, description, thirdChoice < 2);
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