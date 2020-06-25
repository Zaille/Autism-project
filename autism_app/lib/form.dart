import 'dart:io';

import 'package:autismtest/followup.dart';
import 'package:autismtest/main.dart';
import 'package:autismtest/thank.dart';
import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import "package:autismtest/roundedContainer.dart";

class FormPage extends StatefulWidget {
  FormPage({Key key, this.responses}) : super(key: key);

  final List<bool> responses;

  @override
  FormPageState createState() {
    return FormPageState();
  }
}

class FormPageState extends State<FormPage> {

  final formKey = GlobalKey<FormState>();

  List<File> files = [null, null];
  Color errorMessageColor = Colors.black;
  List<String> textButton = ["Add a video", "Add a video"];
  final picker = ImagePicker();
  Widget nextPage;

  final childLastNameController = TextEditingController();
  final childFirstNameController = TextEditingController();
  final childAgeController = TextEditingController();
  final parentLastNameController = TextEditingController();
  final parentFirstNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final password1Controller = TextEditingController();
  final password2Controller = TextEditingController();

  final RegExp phoneRegExp = new RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');


  @override
  Widget build(BuildContext context) {
    final bool showFab = MediaQuery.of(context).viewInsets.bottom==0.0;
    return Scaffold(
      floatingActionButtonLocation: showFab?FloatingActionButtonLocation.centerFloat:FloatingActionButtonLocation.endFloat,
      floatingActionButton: Builder(
          builder: (BuildContext context) {
            return showFab
                ? Container(
                  padding: EdgeInsets.only(bottom: 10),
                  width: 300,
                  child:  FloatingActionButton.extended(
                    onPressed: () {
                      sendData(context);
                    },
                    label: Text("SEND"),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),),
                  )
                )
                : FloatingActionButton(
                    onPressed: () {
                      sendData(context);
                      FocusScope.of(context).unfocus();
                    },
                    child: Icon(Icons.send),
                  );
          }),
      body: Form(
        key: formKey,
        child: ListView(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: Offset(0, 4), // changes position of shadow
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
              child: Text("          Lorem ipsum dolor sit amet, consectetur adipiscing "
                  "elit. Sed non risus. Suspendisse lectus tortor, "
                  "dignissim sit amet, adipiscing nec, ultricies sed, "
                  "dolor. Cras elementum ultrices diam. Maecenas ligula "
                  "massa, varius a, semper congue, euismod non, mi. "
                  "Cras elementum ultrices diam. Maecenas ligula "
                  "massa, varius a, semper congue, euismod non, mi.",
                  textAlign: TextAlign.justify
              ),
            ),
            RoundedContainer(
                context: context,
                title: "Child information:",
                children: <Widget>[
                  TextFormField(
                    key: Key('parentFirstName'),
                    controller: childFirstNameController,
                    maxLength: 50,
                    enableInteractiveSelection: true,
                    decoration: InputDecoration(
                      labelText: "First Name*",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter his/her first name';
                      }
                      return null;
                    },
                  ),
                  Container(padding: EdgeInsets.all(5),),
                  TextFormField(
                    controller: childLastNameController,
                    maxLength: 50,
                    enableInteractiveSelection: true,
                    decoration: InputDecoration(
                      labelText: "Name*",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter his/her name';
                      }
                      return null;
                    },
                  ),
                  Container(padding: EdgeInsets.all(5),),
                  TextFormField(
                    controller: childAgeController,
                    keyboardType: TextInputType.number,
                    maxLength: 3,
                    enableInteractiveSelection: true,
                    decoration: InputDecoration(
                      labelText: "Age (months)*",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter his/her age';
                      }
                      return null;
                    },
                  ),
                ]
            ),
            RoundedContainer(
              context: context,
              title: "Parent information:",
              children: <Widget>[
                TextFormField(
                  controller: parentFirstNameController,
                  maxLength: 50,
                  enableInteractiveSelection: true,
                  decoration: InputDecoration(
                    labelText: "First Name*",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter your first name';
                    }
                    return null;
                  },
                ),
                Container(padding: EdgeInsets.all(5),),
                TextFormField(
                  controller: parentLastNameController,
                  maxLength: 50,
                  enableInteractiveSelection: true,
                  decoration: InputDecoration(
                    labelText: "Name*",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter your name';
                    }
                    return null;
                  },
                ),
                Container(padding: EdgeInsets.all(5),),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  maxLength: 50,
                  enableInteractiveSelection: true,
                  decoration: InputDecoration(
                    labelText: "Email*",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (!EmailValidator.validate(value)) {
                      return 'Not a valid email';
                    }
                    return null;
                  },
                ),
                Container(padding: EdgeInsets.all(5),),
                TextFormField(
                  controller: phoneNumberController,
                  keyboardType: TextInputType.phone,
                  maxLength: 12,
                  enableInteractiveSelection: true,
                  decoration: InputDecoration(
                    labelText: "Phone number*",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (!phoneRegExp.hasMatch(value)) {
                      return 'Not a valid phone number';
                    }
                    return null;
                  },
                ),
              ],
            ),
            RoundedContainer(
              context: context,
              title: "Authentication:",
              children: <Widget>[
                TextFormField(
                  controller: password1Controller,
                  obscureText: true,
                  maxLength: 30,
                  enableInteractiveSelection: true,
                  decoration: InputDecoration(
                    labelText: "Password*",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Choose a password';
                    }
                    return null;
                  },
                ),
                Container(padding: EdgeInsets.all(5),),
                TextFormField(
                  controller: password2Controller,
                  obscureText: true,
                  maxLength: 30,
                  enableInteractiveSelection: true,
                  decoration: InputDecoration(
                    labelText: "Confirm password*",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Choose a password';
                    }
                    return null;
                  },
                ),
              ],
            ),
            RoundedContainer(
              context: context,
              title: "Videos:",
              children: <Widget> [
                IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: files[0] == null
                            ? Text('No file selected.')
                            : Row(
                          children: <Widget>[
                            Icon(Icons.check, color: Colors.green,),
                            Text('  Selected.', style: new TextStyle(color: Colors.green),)
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: RaisedButton(
                          child: Text(textButton[0]),
                          onPressed: () {
                            getFile(0);
                          },
                          color: Theme.of(context).buttonColor,
                          textColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: files[1] == null
                            ? Text('No file selected.')
                            : Row(
                          children: <Widget>[
                            Icon(Icons.check, color: Colors.green,),
                            Text('  Selected.', style: new TextStyle(color: Colors.green),)
                          ],
                        ),
                      ),
                      Expanded(
                        flex:3,
                        child: RaisedButton(
                          child: Text(textButton[1]),
                          onPressed: () {
                            getFile(1);
                          },
                          color: Theme.of(context).buttonColor,
                          textColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 70,),
            ),
          ],
        ),
      ),
    );
  }

  void getFile(index) async {
    final pickedFile = await ImagePicker.pickVideo(source: ImageSource.gallery);
    if (pickedFile == null) return;
    setState(() {
      files[index] = pickedFile;
    });
    if(files[index] != null)
      textButton[index] = "Change video";
    else
      textButton[index] = "Add a video";
  }

  Future sendData(context) async {
    if (formKey.currentState.validate() & (files[0] != null) & (files[1] !=
        null)) {
      Response response;
      String uploadURL = 'http://192.168.1.45:8080/api/uploadFiles';
      Dio dio = new Dio();
      FormData formData = FormData.fromMap({
        "childFirstName": childFirstNameController.text,
        "childLastName": childLastNameController.text,
        "childAge": childAgeController.text,
        "parentFirstName": parentFirstNameController.text,
        "parentLastName": parentLastNameController.text,
        "phoneNumber": phoneNumberController.text,
        "email": emailController.text,
        "password": password1Controller.text,
        "files": [
          await MultipartFile.fromFile(files[0].path, filename: files[0].path
              .split('/')
              .last),
          await MultipartFile.fromFile(files[1].path, filename: files[1].path
              .split('/')
              .last),
        ]
      });
      Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text("Processing data..."),
            behavior: SnackBarBehavior.floating,
          )
      );
      try {
        response = await dio.post(uploadURL, data: formData).timeout(
            const Duration(seconds: 10));
      }
      catch (e) {
        print(e);
        if (e.response != null && e.response.data["errno"] == 1062)
          Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text("Email adress already taken."),
                behavior: SnackBarBehavior.floating,
              )
          );
        else
          await showDialog(
            context: context,
            builder: (_) =>
                AlertDialog(
                  title: Text("Server error"),
                  content: Text(
                      "The server is unavailable, try again later.\n(" +
                          e.toString().split(",")[1].toString() + ")"),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("Go back to the main page"),
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).pop(
                            'dialog');
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
      if (response != null && response.statusCode == 201) {
        if (widget.responses == null)
          nextPage = ThanksPage();
        else
          nextPage = FollowupPage(responses: widget.responses,
              patientId: response.data["patientId"]);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => nextPage),
        );
      }
    }
    else {
      setState(() => errorMessageColor = Colors.red);
      Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text("Complete all fields"),
            behavior: SnackBarBehavior.floating,
          )
      );
    }
  }

}