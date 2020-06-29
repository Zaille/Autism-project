import 'package:autismtest/copyright.dart';
import 'package:autismtest/navigationButtons.dart';
import 'package:autismtest/roundedContainer.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Followup13 extends StatefulWidget{
  Followup13({Key key, this.nextPage}) : super(key: key);

  final nextPage;

  @override
  State<StatefulWidget> createState() {
    return Followup13State();
  }
}

class Followup13State extends State<Followup13> {

  bool selected;
  final String title = "FollowUp 13";

  @override
  Widget build(BuildContext context) {
    return firstElement();
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
              "Does he/she walk without holding on to anything?",
              style: TextStyle(fontSize: 20,),
              textAlign: TextAlign.center,
            ),
            yesNoRadio(),
          ],
        ),
        Spacer(),
        NavigationButtons(
          context: context,
          previousFunction: () {},
          nextFunction: () {
            //Need a response
            if (selected == null) Fluttertoast.showToast(msg: "Complete the field");
            //Send data
            else  widget.nextPage(13, [selected], null, null, null, selected);
          },
        ),
        Copyright(),
      ],
    );
  }

  Widget yesNoRadio() {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: RadioListTile(
              value: true,
              groupValue: selected,
              onChanged: (newValue) => setState(() => selected = newValue),
              activeColor: Theme.of(context).accentColor,
              title: Text("Yes"),
            ),
          ),
          Expanded(
            child: RadioListTile(
              value: false,
              groupValue: selected,
              onChanged: (newValue) => setState(() => selected = newValue),
              activeColor: Theme.of(context).accentColor,
              title: Text("No"),
            ),
          ),
        ],
      ),
    );
  }
}