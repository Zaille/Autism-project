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
  bool error = false;
  final List<TextEditingController> myControllers = [
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
  ];
  final RegExp phoneRegExp = new RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');

  final picker = ImagePicker();
  List<File> files = [null];
  List<String> textButton = ["Add a video"];

  Widget nextPage;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      floatingActionButton: Builder(
          builder: (BuildContext context) {
            return Container(
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
                  );
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Form(
        key: formKey,
        child: ListView(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).highlightColor,
                    spreadRadius: 7,
                    blurRadius: 7,
                    offset: Offset(0, 5), // changes position of shadow
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
                textAlign: TextAlign.justify,
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
            RoundedContainer(
                context: context,
                title: "Child information:",
                children: <Widget>[
                  formTextField(
                    index: 0,
                    label: "First Name*",
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter his/her first name';
                      }
                      return null;
                    },
                  ),
                  formTextField(
                    index: 1,
                    label: "Name*",
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter his/her name';
                      }
                      return null;
                    },
                  ),
                  formTextField(
                    index: 2,
                    keyboardType: TextInputType.number,
                    maxLength: 3,
                    label: "Age (months)*",
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
                formTextField(
                  index: 3,
                  label: "First Name*",
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter your first name';
                    }
                    return null;
                  },
                ),
                formTextField(
                  index: 4,
                  label: "Name*",
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter your name';
                    }
                    return null;
                  },
                ),
                formTextField(
                  index: 5,
                  keyboardType: TextInputType.emailAddress,
                  label: "Email*",
                  validator: (value) {
                    if (!EmailValidator.validate(value)) {
                      return 'Not a valid email';
                    }
                    return null;
                  },
                ),
                formTextField(
                  index: 6,
                  keyboardType: TextInputType.phone,
                  maxLength: 12,
                  label: "Phone number*",
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
                formTextField(
                  index: 7,
                  obscureText: true,
                  maxLength: 30,
                  label: "Password*",
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Choose a password';
                    }
                    return null;
                  },
                ),
                formTextField(
                  index: 8,
                  obscureText: true,
                  maxLength: 30,
                  label: "Confirm password*",
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Confirm your password';
                    }
                    else if (value != myControllers[7].text)
                      return "Enter the same password";
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
                            ? Text('No file selected.',
                                style: error?TextStyle(color: Colors.red)
                                        :Theme.of(context).textTheme.bodyText2,
                              )
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
                          shape: RoundedRectangleBorder (
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Text(textButton[0]),
                          onPressed: () {
                            getFile(0);
                          },
                          color: Theme.of(context).accentColor,
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
    if (formKey.currentState.validate() & (files[0] != null)
    /*& (files[1] != null)*/) {
      Response response;
      String uploadURL = 'http://192.168.1.45:8080/api/uploadFiles';
      Dio dio = new Dio();
      FormData formData = FormData.fromMap({
        "childFirstName": myControllers[0].text,
        "childLastName": myControllers[1].text,
        "childAge": myControllers[2].text,
        "parentFirstName": myControllers[3].text,
        "parentLastName": myControllers[4].text,
        "email": myControllers[5].text,
        "phoneNumber": myControllers[6].text,
        "password": myControllers[7].text,
        "file": await MultipartFile.fromFile(files[0].path, filename: files[0].path
              .split('/')
              .last),
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
                      "The server is unavailable, try again later.\n("
                          + e.toString()),
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
      setState(() => error = true);
      Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text("Complete all fields"),
            behavior: SnackBarBehavior.floating,
          )
      );
    }
  }

  Widget formTextField({
    index,
    keyboardType = TextInputType.text,
    maxLength = 50,
    obscureText = false,
    label,
    validator}) {
      return Container(
        padding: EdgeInsets.only(bottom: 15),
        child: TextFormField(
          controller: myControllers[index],
          keyboardType: keyboardType,
          maxLength: maxLength,
          obscureText: obscureText,
          decoration: InputDecoration(
            labelText: label,
            border: OutlineInputBorder(),
          ),
          onChanged: (value) {
            if (error) formKey.currentState.validate();
          },
          validator: validator,
        ),
      );
  }

}
