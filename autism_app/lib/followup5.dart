import 'package:autismtest/copyright.dart';
import 'package:autismtest/navigationButtons.dart';
import 'package:autismtest/roundedContainer.dart';
import 'package:flutter/material.dart';

class Followup5 extends StatefulWidget{
  Followup5({Key key, this.nextPage}) : super(key: key);

  final nextPage;

  @override
  State<StatefulWidget> createState() {
    return Followup5State();
  }
}

class Followup5State extends State<Followup5> {

  List<bool> selected = new List<bool>.filled(8, null, growable: true);
  String example;
  String description;
  final exampleController = TextEditingController();
  final describeController = TextEditingController();
  final String title = "FollowUp 5";
  int state = 0;

  @override
  Widget build(BuildContext context) {
    if (state == 0) return firstElement();
    if (state == 1) return secondElement();
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
              Text("Does he/she … ", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold), textAlign: TextAlign.center,)
            ]
        ),
        RoundedContainer(
          context: context,
          outerTitle: false,
          children: <Widget>[
            Text("Look at hands?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            _yesOrNoRadio(0),
          ],
        ),
        RoundedContainer(
          context: context,
          outerTitle: false,
          children: <Widget>[
            Text("Move fingers when playing peek-a-boo?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            _yesOrNoRadio(1),
          ],
        ),
        RoundedContainer(
          context: context,
          outerTitle: false,
          children: <Widget>[
            Text("Wiggle his/her fingers near his/her eyes?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            _yesOrNoRadio(2),
          ],
        ),
        RoundedContainer(
          context: context,
          outerTitle: false,
          children: <Widget>[
            Text("Hold his/her hands up close to his/her eyes?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            _yesOrNoRadio(3),
          ],
        ),
        RoundedContainer(
          context: context,
          outerTitle: false,
          children: <Widget>[
            Text("Hold his/her hands off to the side of his/her eyes?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            _yesOrNoRadio(4),
          ],
        ),
        RoundedContainer(
          context: context,
          outerTitle: false,
          children: <Widget>[
            Text("Flap his/her hands near his/her face?", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            _yesOrNoRadio(5),
          ],
        ),
        RoundedContainer(
          context: context,
          outerTitle: false,
          children: <Widget>[
            Text("Other", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            _yesOrNoRadio(6),
          ],
        ),
        (selected[6] == true)
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
          previousFunction: () {},
          nextFunction: () {
            //Need responses
            if ((selected.indexOf(null) != 7) | (selected[6] & (describeController.text == "")))
              Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Need all responses"),
                    behavior: SnackBarBehavior.floating,
                  )
              );
            //Respond "Yes" to a "fail" example => Next question
            else if (selected.sublist(2, 7).contains(true)) setState(() {
              state ++;
            });
            //No to all "fail" responses => PASS
            else {
              if (selected[6]) description = describeController.text;
              widget.nextPage(5, selected, null, example, description, true);
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
              "Does this happen more than twice a week?",
              style: TextStyle(fontSize: 20,),
              textAlign: TextAlign.center,
            ),
            _yesOrNoRadio(7),
          ],
        ),
        Spacer(),
        NavigationButtons(
          prevCondition: state > 0,
          previousFunction: () {
            setState(() => state --);
          },
          nextFunction: () {
            if (selected[7] == null)
              Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Complete all fields"),
                    behavior: SnackBarBehavior.floating,
                  )
              );
            else
              widget.nextPage(5, selected, null, example, description, !selected[7]);
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