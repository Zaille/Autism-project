import 'dart:io';

import 'package:asdscreening/followup.dart';
import 'package:asdscreening/main.dart';
import 'package:asdscreening/thank.dart';
import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import "package:asdscreening/roundedContainer.dart";

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class FormPage extends StatefulWidget {
  FormPage({Key key, this.responses, this.score}) : super(key: key);

  final List<bool> responses;
  final int score;

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
  File file;
  String textButton = "Add a video";

  Widget nextPage;
  Widget fabContent = Text("SEND");

  FirebaseApp app;
  FirebaseStorage storage;
  final smtpServer = gmail("asdscreening.portsmouthuniv@gmail.com", "7XWJXXByubj6h27");


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
                    firebaseUpload(context);
                  },
                  label: fabContent,
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
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
              child: Text(
                "          Complete the information requested "
                    "to facilitate the contact between you and our specialists "
                    "and allow them to procede to further analysis.\n\n"
                    "You will be asked to send a video of your child behaviour "
                    "that last at least 1 minute to identify a possible indicator"
                    " of ASD behaviour.",
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
                        child: file == null
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
                          child: Text(textButton),
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
    File pickedFile = await ImagePicker.pickVideo(source: ImageSource.gallery);
    setState(() => file = pickedFile);
    if(file != null)
      setState(() => textButton = "Change video");
    else
      setState(() => textButton = "Add a video");
  }

  Future authentication() async {
    try {
      dynamic authResult = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: "asdscreening.portsmouthuniv@gmail.com",
        password: "NiE936Dh7TidCoxS",
      );
      print(authResult.user);
      return true;
    }
    catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> sendEmail(link) async {
    String text =
        "Score: " + widget.score.toString() +
            ",\nChild First Name: " + myControllers[0].text +
            ",\nChild Last Name: " + myControllers[1].text +
            ",\nChild Age: " + myControllers[2].text + " months" +
            ",\nParent First Name: " + myControllers[3].text +
            ",\nParent Last Name: " + myControllers[4].text +
            ",\nEmail: " + myControllers[5].text +
            ",\nPhoneNumber: " + myControllers[6].text +
            ",\nVideo link: " + link +
            ",\nResponses (";
    widget.responses.asMap().forEach((index, element) {
      if (element)
        text += (index + 1).toString() + ": Pass, ";
      else
        text += (index + 1).toString() + ": Fail, ";
    });
    text += ").";

    final message = Message()
      ..from = Address("asdscreening.portsmouthuniv@gmail.com")
      ..recipients.add("asdscreening.portsmouthuniv@gmail.com")
      ..subject = "New Request for "
          + myControllers[0].text + " "
          + myControllers[1].text
      ..text = text;

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
      return true;
    }
    on MailerException catch (e) {
      print('Message not sent. \n'+ e.toString());
      return false;
    }
  }

  void firebaseUpload(context) async {
    if (formKey.currentState.validate() & (file != null)) {
      bool auth = false;
      bool emailSent = false;
      StorageUploadTask uploadTask;

      setState(() =>
      fabContent = CircularProgressIndicator(
        backgroundColor: Theme
            .of(context)
            .primaryColor,
      ));

      auth = await authentication();
      if (auth) try {
        final StorageReference firebaseStorageRef = FirebaseStorage.instance
            .ref()
            .child(
            myControllers[0].text + myControllers[1].text + "." + file.path
                .split(".")
                .last);
        uploadTask = firebaseStorageRef.putFile(file);
        StorageTaskSnapshot storageSnapshot = await uploadTask.onComplete;
        String downloadUrl = await storageSnapshot.ref.getDownloadURL();
        emailSent = await sendEmail(downloadUrl);
      }
      catch (e) {
        uploadTask.cancel();
      }

      showDialog(
        context: context,
        builder: (_) =>
        (auth & uploadTask.isComplete & emailSent)
            ?
        AlertDialog(
          title: Text("Upload done !", style: Theme
              .of(context)
              .textTheme
              .headline1,),
          content: Icon(Icons.check_box, size: 100, color: Colors.green,),
          backgroundColor: Theme
              .of(context)
              .backgroundColor,
          actions: <Widget>[
            FlatButton(
              child: Text("Next", style: TextStyle(
                color: Theme
                    .of(context)
                    .accentColor,
                fontSize: 18,
              ),),
              onPressed: () {
                if (widget.responses == null)
                  nextPage = ThanksPage();
                else
                  nextPage = FollowupPage(responses: widget.responses,
                      patientId: 0);
                Navigator.of(context, rootNavigator: true).pop('dialog');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => nextPage),
                );
              },
            ),
          ],
        )
            :
        AlertDialog(
          title: Text("Upload failed...", style: Theme
              .of(context)
              .textTheme
              .headline1,),
          content: Icon(Icons.error, size: 100, color: Colors.red,),
          backgroundColor: Theme
              .of(context)
              .backgroundColor,
          actions: <Widget>[
            FlatButton(
              child: Text("Retry", style: TextStyle(
                color: Theme
                    .of(context)
                    .accentColor,
                fontSize: 18,
              ),),
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop(
                    'dialog');
              },
            ),
          ],
        ),
        barrierDismissible: false,
      );

      setState(() => fabContent = Text("SEND"));
      return null;
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

  Future serverUpload(context) async {
    if (formKey.currentState.validate() & (file != null)) {
      Response response;
      String uploadURL = 'http://localhost:8080/api/uploadFiles';
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
        "file": await MultipartFile.fromFile(file.path, filename: file.path
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

  nextWithoutUpload(context) {
    if (formKey.currentState.validate() & (file != null)) {
      if (widget.responses == null)
        nextPage = ThanksPage();
      else
        nextPage = FollowupPage(responses: widget.responses,
            patientId: 0);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => nextPage),
      );
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
