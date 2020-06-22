import 'package:autismtest/form.dart';
import 'package:autismtest/thank.dart';
import 'package:dio/dio.dart';
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
import 'package:fluttertoast/fluttertoast.dart';

class FollowUpWidget extends StatefulWidget {
  FollowUpWidget({Key key, this.responses, this.patientId}) : super(key: key);

  final List<bool> responses;
  final int patientId;

  @override
  State<StatefulWidget> createState() {
    return FollowUpWidgetState(responses);
  }
}

class FollowUpWidgetState extends State<FollowUpWidget> {

  List<Widget> followupToDisplay;
  int questionIdx = 0;

  FollowUpWidgetState(List<bool> responses) {
    questionIdx = responses.indexOf(false);
  }

  @override
  Widget build(BuildContext context) {
    switch(this.questionIdx) {
      case 0:
        return Followup1(nextPage: sendData,);
      case 1:
        return Followup2(nextPage: sendData,);
      case 2:
        return Followup3(nextPage: sendData,);
      case 3:
        return Followup4(nextPage: sendData,);
      case 4:
        return Followup5(nextPage: sendData,);
      case 5:
        return Followup6(nextPage: sendData,);
      case 6:
        return Followup7(nextPage: sendData,);
      case 7:
        return Followup8(nextPage: sendData,);
      case 8:
        return Followup9(nextPage: sendData,);
      case 9:
        return Followup10(nextPage: sendData,);
      case 10:
        return Followup11(nextPage: sendData,);
      case 11:
        return Followup12(nextPage: sendData,);
      case 12:
        return Followup13(nextPage: sendData,);
      case 13:
        return Followup14(nextPage: sendData,);
      case 14:
        return Followup15(nextPage: sendData,);
      case 15:
        return Followup16(nextPage: sendData,);
      case 16:
        return Followup17(nextPage: sendData,);
      case 17:
        return Followup18(nextPage: sendData,);
      case 18:
        return Followup19(nextPage: sendData,);
      case 19:
        return Followup20(nextPage: sendData,);
      case 20:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ThanksPage()),
        );
        return null;
    }
    return Container();
  }

  sendData(List<bool> responses, int index, String example, String description, bool success) async {
    int oldIdx = this.questionIdx;
    Response response;
    Dio dio = new Dio();
    String uploadURL = 'http://192.168.1.45:8080/api/uploadResponses';
    Fluttertoast.showToast(msg:'Processing data...', toastLength: Toast.LENGTH_SHORT);
    try {
      response = await dio.post(uploadURL, data: {
        "patientId": widget.patientId,
        "yesNoAnswers": responses,
        "answerChoice": index,
        "example": example,
        "description": description,
        "success": success,
      },
      ).timeout(const Duration(seconds: 10));
    }
    catch(e) {
      print(e);
      Fluttertoast.showToast(msg: "Upload error");
    }
    if (response != null && response.statusCode == 201) {
      Fluttertoast.showToast(msg: "Upload done !");
      setState(() {
        this.questionIdx = widget.responses.sublist(this.questionIdx + 1).indexOf(false) + 1 + this.questionIdx;
      });
      print(questionIdx);
    }
    if (this.questionIdx == oldIdx)
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FormPage()),
      );
  }
}

class FollowupPage extends StatelessWidget {
  FollowupPage({Key key, this.responses, this.patientId}) : super(key: key);

  final List<bool> responses;
  final int patientId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FollowUpWidget(responses: this.responses,),
    );
  }
}
