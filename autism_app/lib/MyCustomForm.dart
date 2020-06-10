import 'dart:io';

import 'package:autismtest/uploadFormWidget.dart';
import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {

  final _formKey = GlobalKey<FormState>();
  //GlobalKey<UploadFormWidgetState> _keyPictures = GlobalKey();

  bool loading = false;
  List<File> files = [null, null];
  Color errorMessageColor = Colors.black;
  List<String> textButton = ["Add a video", "Add a video"];
  final picker = ImagePicker();

  final childLastNameController = TextEditingController();
  final childFirstNameController = TextEditingController();
  final childAgeController = TextEditingController();
  final parentLastNameController = TextEditingController();
  final parentFirstNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final password1Controller = TextEditingController();
  final password2Controller = TextEditingController();

  final RegExp regExp = new RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          MyContainer(
            title: "Child information",
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
                maxLength: 50,
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
          MyContainer(
            title: "Parent information:",
            width: 100.0,
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
                  if (!regExp.hasMatch(value)) {
                    return 'Not a valid phone number';
                  }
                  return null;
                },
              ),
            ],
          ),
          MyContainer(
            title: "Authentication:",
            width: 100.0,
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
          MyContainer(
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 50),
            child:
            loading
                ? CircularProgressIndicator()
                : RaisedButton(
              color: Colors.blue,
              textColor: Colors.white,
              onPressed: () {
                if (_formKey.currentState.validate() & (files[0] != null) & (files[1] != null)) {
                  sendData();
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('Processing Data')));
                }
                else {
                  setState(() {
                    errorMessageColor = Colors.red;
                    Scaffold.of(context).showSnackBar(new SnackBar(
                        content: new Text("Complete all fields")));
                  });
                }
              },
              child: Text('SEND'),
            ),
          ),
        ],
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

  Future sendData() async {
    Response response;
    String uploadURL = 'http://192.168.1.45:8080/api/upload';
    Dio dio = new Dio();
    FormData formData = FormData.fromMap({
      "childFirtName": childFirstNameController,
      "childLastName": childLastNameController,
      "childAge": childAgeController,
      "parentFirstName": parentFirstNameController,
      "parentLastName": parentLastNameController,
      "phoneNumber": phoneNumberController,
      "email": emailController,
      "password": password1Controller,
      "files": [
        await MultipartFile.fromFile(files[0].path, filename: files[0].path.split('/').last),
        await MultipartFile.fromFile(files[1].path, filename: files[1].path.split('/').last),
      ]
    });
    setState(() {
      loading = !loading;
    });
    Scaffold.of(context).showSnackBar(new SnackBar(
      content: new Text("Submission..."), duration: const Duration(seconds: 1),));
    try {
      response = await dio.post(uploadURL, data: formData).timeout(const Duration(seconds: 10));
    }
    catch(e) {
      Scaffold.of(context).showSnackBar(new SnackBar(
          content: new Text("Upload error")));
    }
    if (response != null && response.statusCode == 201) {
      Scaffold.of(context).showSnackBar(new SnackBar(
          content: new Text("Upload done")));
    }
    setState(() {
      loading = !loading;
    });
  }
}

class MyContainer extends StatelessWidget {
  MyContainer({Key key, this.children, this.width, this.title}) : super(key: key);

  final children;
  final width;
  final title;

  Size screenSize(BuildContext context) {return MediaQuery.of(context).size;}
  double screenHeight(BuildContext context, {double coeff = 1}) {return screenSize(context).height * coeff;}
  double screenWidth(BuildContext context, {double coeff = 1}) {return screenSize(context).width * coeff;}

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 40, bottom: 15),
          child: Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Center(
            child: Container(
              width: screenWidth(context, coeff: 0.9),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
                child: Column(
                  children: this.children,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }



}