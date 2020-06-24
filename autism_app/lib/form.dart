import 'dart:io';

import 'package:autismtest/followup.dart';
import 'package:autismtest/main.dart';
import 'package:autismtest/submitButton.dart';
import 'package:autismtest/thank.dart';
import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import "package:autismtest/RoundedContainer.dart";

class FormPage extends StatefulWidget {
  FormPage({Key key, this.responses}) : super(key: key);

  final List<bool> responses;

  @override
  FormPageState createState() {
    return FormPageState();
  }
}

class FormPageState extends State<FormPage> {

  final _formKey = GlobalKey<FormState>();

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
      floatingActionButton: Container(
        padding: EdgeInsets.symmetric(vertical: 80),
        width: 300,
        child: showFab?FloatingActionButton.extended(
          onPressed: () {
            if (_formKey.currentState.validate() & (files[0] != null) & (files[1] != null)) {
              sendData();
            }
            else {
              setState(() {
                errorMessageColor = Colors.red;
                Fluttertoast.showToast(msg: "Complete all fields");
              });
            }
          },
          label: Text("SEND"),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0)),),
        ):Container(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFC9F1FD),
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
              title: "Child information:",
              children: <Widget>[
                TextFormField(
                  controller: childFirstNameController,
                  maxLength: 50,
                  enableInteractiveSelection: true,
                  decoration: InputDecoration(
                    labelText: "First Name",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter his/her first name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: childLastNameController,
                  maxLength: 50,
                  enableInteractiveSelection: true,
                  decoration: InputDecoration(
                    labelText: "Name",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter his/her name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: childAgeController,
                  keyboardType: TextInputType.number,
                  maxLength: 3,
                  enableInteractiveSelection: true,
                  decoration: InputDecoration(
                    labelText: "Age",
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
              title: "Parent information:",
              children: <Widget>[
                TextFormField(
                  controller: parentFirstNameController,
                  maxLength: 50,
                  enableInteractiveSelection: true,
                  decoration: InputDecoration(
                    labelText: "First Name",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter your first name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: parentLastNameController,
                  maxLength: 50,
                  enableInteractiveSelection: true,
                  decoration: InputDecoration(
                    labelText: "Name",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter your name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                maxLength: 50,
                enableInteractiveSelection: true,
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (!EmailValidator.validate(value)) {
                    return 'Not a valid email';
                  }
                  return null;
                },
              ),
                TextFormField(
                  controller: phoneNumberController,
                  keyboardType: TextInputType.phone,
                  maxLength: 12,
                  enableInteractiveSelection: true,
                  decoration: InputDecoration(
                    labelText: "Phone number",
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
              title: "Authentication:",
              children: <Widget>[
                TextFormField(
                  controller: password1Controller,
                  obscureText: true,
                  maxLength: 30,
                  enableInteractiveSelection: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Choose a password';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: password2Controller,
                  obscureText: true,
                  maxLength: 30,
                  enableInteractiveSelection: true,
                  decoration: InputDecoration(
                    labelText: "Confirm password",
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
              title: "Videos:",
              children: <Widget> [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Spacer(),
                    files[0] == null
                        ? Text('No file selected.', style: new TextStyle(color: errorMessageColor),)
                        : Row(
                      children: <Widget>[
                        Icon(Icons.check, color: Colors.green,),
                        Text('  Selected.', style: new TextStyle(color: Colors.green),)
                      ],
                    ),
                    Spacer(),
                    RaisedButton(
                      child: Text(textButton[0]),
                      onPressed: () {
                        getFile(0);
                      },
                      color: Colors.blue,
                      textColor: Colors.white,
                    ),
                    Spacer(),
                  ],
                ),
                Container(
                  width: screenWidth(context, coeff:1),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Spacer(),
                    files[1] == null
                        ? Text('No file selected.', style: new TextStyle(color: errorMessageColor),)
                        : Row(
                      children: <Widget>[
                        Icon(Icons.check, color: Colors.green,),
                        Text('  Selected.', style: new TextStyle(color: Colors.green),)
                      ],
                    ),
                    Spacer(),
                    RaisedButton(
                      child: Text(textButton[1]),
                      onPressed: () {
                        getFile(1);
                      },
                      color: Colors.blue,
                      textColor: Colors.white,
                    ),
                    Spacer(),
                  ],
                ),
              ],
            ),
            !showFab?SubmitButton(
              text: "SEND",
              onPressed: () {
                if (_formKey.currentState.validate() & (files[0] != null) & (files[1] != null)) {
                  sendData();
                }
                else {
                  setState(() {
                    errorMessageColor = Colors.red;
                    Fluttertoast.showToast(msg: "Complete all fields");
                  });
                }
              },
            ):Container(),
            Container(
              padding: EdgeInsets.symmetric(vertical: 100,),
            ),
          ],
        ),
      ),
    );
  }

  Size screenSize(BuildContext context) {return MediaQuery.of(context).size;}
  double screenHeight(BuildContext context, {double coeff = 1}) {return screenSize(context).height * coeff;}
  double screenWidth(BuildContext context, {double coeff = 1}) {return screenSize(context).width * coeff;}

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

  Future sendData() async {
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
        await MultipartFile.fromFile(files[0].path, filename: files[0].path.split('/').last),
        await MultipartFile.fromFile(files[1].path, filename: files[1].path.split('/').last),
      ]
    });
    Fluttertoast.showToast(msg: 'Processing data...', toastLength: Toast.LENGTH_SHORT);
    try {
      response = await dio.post(uploadURL, data: formData).timeout(const Duration(seconds: 10));
    }
    on DioError catch(e) {
      if (e.response.data["errno"] == 1062)
        Fluttertoast.showToast(msg: "Email adress already taken.");
    }
    catch(e) {
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
    if (response != null && response.statusCode == 201) {
      if(widget.responses == null) nextPage = ThanksPage();
      else nextPage = FollowupPage(responses: widget.responses, patientId: response.data["patientId"]);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => nextPage),
      );
    }
  }
}