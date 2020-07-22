import 'package:asdscreening/main.dart';
import 'package:asdscreening/thank.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:asdscreening/followup1.dart';
import 'package:asdscreening/followup2.dart';
import 'package:asdscreening/followup3.dart';
import 'package:asdscreening/followup4.dart';
import 'package:asdscreening/followup5.dart';
import 'package:asdscreening/followup6.dart';
import 'package:asdscreening/followup7.dart';
import 'package:asdscreening/followup8.dart';
import 'package:asdscreening/followup9.dart';
import 'package:asdscreening/followup10.dart';
import 'package:asdscreening/followup11.dart';
import 'package:asdscreening/followup12.dart';
import 'package:asdscreening/followup13.dart';
import 'package:asdscreening/followup14.dart';
import 'package:asdscreening/followup15.dart';
import 'package:asdscreening/followup16.dart';
import 'package:asdscreening/followup17.dart';
import 'package:asdscreening/followup18.dart';
import 'package:asdscreening/followup19.dart';
import 'package:asdscreening/followup20.dart';
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
        return Followup1(nextPage: nextWithoutUpload,);
      case 1:
        return Followup2(nextPage: nextWithoutUpload,);
      case 2:
        return Followup3(nextPage: nextWithoutUpload,);
      case 3:
        return Followup4(nextPage: nextWithoutUpload,);
      case 4:
        return Followup5(nextPage: nextWithoutUpload,);
      case 5:
        return Followup6(nextPage: nextWithoutUpload,);
      case 6:
        return Followup7(nextPage: nextWithoutUpload,);
      case 7:
        return Followup8(nextPage: nextWithoutUpload,);
      case 8:
        return Followup9(nextPage: nextWithoutUpload,);
      case 9:
        return Followup10(nextPage: nextWithoutUpload,);
      case 10:
        return Followup11(nextPage: nextWithoutUpload,);
      case 11:
        return Followup12(nextPage: nextWithoutUpload,);
      case 12:
        return Followup13(nextPage: nextWithoutUpload,);
      case 13:
        return Followup14(nextPage: nextWithoutUpload,);
      case 14:
        return Followup15(nextPage: nextWithoutUpload,);
      case 15:
        return Followup16(nextPage: nextWithoutUpload,);
      case 16:
        return Followup17(nextPage: nextWithoutUpload,);
      case 17:
        return Followup18(nextPage: nextWithoutUpload,);
      case 18:
        return Followup19(nextPage: nextWithoutUpload,);
      case 19:
        return Followup20(nextPage: nextWithoutUpload,);
      case 20:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ThanksPage()),
        );
        return null;
    }
    return Container();
  }

  sendData(int groupId, List<bool> responses, int index, String example, String description, bool success) async {
    bool uploadError = false;
    int oldIdx = this.questionIdx;
    Response response;
    Dio dio = new Dio();
    String uploadURL = 'http://192.168.1.45:8080/api/uploadResponses';
    Fluttertoast.showToast(msg:'Processing data...', toastLength: Toast.LENGTH_SHORT);
    try {
      response = await dio.post(uploadURL, data: {
        "patientId": widget.patientId,
        "groupId": groupId,
        "yesNoAnswers": responses,
        "answerChoice": index,
        "example": example,
        "description": description,
        "success": success,
      },
      ).timeout(const Duration(seconds: 10));
    }
    catch(e) {
      uploadError = true;
      await showDialog(
        context: context,
        builder:(_) => AlertDialog(
          title: Text("Server error"),
          content: Text("The server is unavailable, try again later."),
          actions: <Widget>[
            FlatButton(
              child: Text("Go back to the main page"),
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop('dialog');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyApp()),
                );
              },
            ),
          ],
        ),
        barrierDismissible: false,
      );
    }
    if (!uploadError && response != null && response.statusCode == 200) setState(() {
      this.questionIdx = widget.responses.sublist(this.questionIdx + 1).indexOf(false) + 1 + this.questionIdx;
    });
    if (!uploadError & (this.questionIdx == oldIdx))
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ThanksPage()),
      );
  }

  nextWithoutUpload(int groupId, List<bool> responses, int index, String example, String description, bool success) async {
    int oldIdx = this.questionIdx;
    setState(() => this.questionIdx = widget.responses.sublist(this.questionIdx + 1).indexOf(false) + 1 + this.questionIdx);
    if (this.questionIdx == oldIdx)
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ThanksPage()),
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
      body: FollowUpWidget(responses: this.responses, patientId: patientId,),
    );
  }
}