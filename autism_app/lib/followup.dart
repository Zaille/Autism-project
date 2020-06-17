/*
import 'package:flutter/material.dart';

import 'package:autismtest/followup1.dart';
import 'package:autismtest/followup2.dart';
import 'package:autismtest/followup3.dart';
import 'package:autismtest/followup4.dart';
import 'package:autismtest/followup5.dart';
import 'package:autismtest/followup6.dart';
import 'package:autismtest/followup7.dart';
import 'package:autismtest/followup8.dart';
import 'package:autismtest/followup9.dart';
import 'package:autismtest/followup10.dart';
import 'package:autismtest/followup11.dart';
import 'package:autismtest/followup12.dart';
import 'package:autismtest/followup13.dart';
import 'package:autismtest/followup14.dart';
import 'package:autismtest/followup15.dart';
import 'package:autismtest/followup16.dart';
import 'package:autismtest/followup17.dart';
import 'package:autismtest/followup18.dart';
import 'package:autismtest/followup19.dart';
import 'package:autismtest/followup20.dart';

class FollowUp extends StatefulWidget {
  FollowUp({Key key, this.responses,}) : super(key: key);

  final List<bool> responses;
  final widgetList = [
    Followup1(),
    Followup2(),
    Followup3(),
    Followup4(),
    Followup5(),
    Followup6(),
    Followup7(),
    Followup8(),
    Followup9(),
    Followup10(),
    Followup11(),
    Followup12(),
    Followup13(),
    Followup14(),
    Followup15(),
    Followup16(),
    Followup17(),
    Followup18(),
    Followup19(),
    Followup20(),
  ];

  @override
  State<StatefulWidget> createState() {
    return FollowUpState();
  }
}

class FollowUpState extends State<FollowUp> {

  List<Widget> followupToDisplay;

  @override
  Widget build(BuildContext context) {
    widget.responses.asMap().forEach((index, element) {
      if(!element) followupToDisplay.add(widget.widgetList[index]);
    });
    return followupToDisplay[0]();
  }

}
*/
