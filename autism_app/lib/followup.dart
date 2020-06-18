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

  @override
  State<StatefulWidget> createState() {
    return FollowUpState();
  }
}

class FollowUpState extends State<FollowUp> {

  List<Widget> followupToDisplay;
  int questionIdx = -1;

  @override
  Widget build(BuildContext context) {
    questionIdx = widget.responses.indexOf(false);
    switch(this.questionIdx) {
      case  0:
        return Followup1(nextPage: () {nextPage();},);
      case  1:
        return Followup2(nextPage: () {nextPage();},);
      case  2:
        return Followup3(nextPage: () {nextPage();},);
      case  3:
        return Followup4(nextPage: () {nextPage();},);
      case  4:
        return Followup5(nextPage: () {nextPage();},);
      case  5:
        return Followup6(nextPage: () {nextPage();},);
      case  6:
        return Followup7(nextPage: () {nextPage();},);
      case  7:
        return Followup8(nextPage: () {nextPage();},);
      case  8:
        return Followup9(nextPage: () {nextPage();},);
      case  9:
        return Followup10(nextPage: () {nextPage();},);
      case  10:
        return Followup11(nextPage: () {nextPage();},);
      case  11:
        return Followup12(nextPage: () {nextPage();},);
      case  12:
        return Followup13(nextPage: () {nextPage();},);
      case  13:
        return Followup14(nextPage: () {nextPage();},);
      case  14:
        return Followup15(nextPage: () {nextPage();},);
      case  15:
        return Followup16(nextPage: () {nextPage();},);
      case  16:
        return Followup17(nextPage: () {nextPage();},);
      case  17:
        return Followup18(nextPage: () {nextPage();},);
      case  18:
        return Followup1(nextPage: () {nextPage();},);
      case  19:
        return Followup19(nextPage: () {nextPage();},);
    }
    return Container();
  }

  nextPage() {
    setState(() {
      this.questionIdx = widget.responses.sublist(this.questionIdx + 1).indexOf(false) + 1 + this.questionIdx;
    });
  }

  sendData(String example, List<bool> responses, int index, String description) {

  }

}
