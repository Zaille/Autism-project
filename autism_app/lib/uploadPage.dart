
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:autismtest/uploadFormWidget.dart';

class UploadPage extends StatefulWidget {
  UploadPage({Key key}) : super(key: key);

  @override
  UploadPageState createState() => UploadPageState();
}

class UploadPageState extends State<UploadPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Files Upload'),
      ),
      body: UploadFormWidget(),
    );
  }
}