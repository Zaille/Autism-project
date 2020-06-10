import 'dart:io';

import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FormWidget extends StatefulWidget {
  @override
  FormWidgetState createState() {
    return FormWidgetState();
  }
}

class FormWidgetState extends State<FormWidget> {

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

  final RegExp phoneRegExp = new RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
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
          FormContainer(
            title: "Child information:",
            width: screenWidth(context, coeff: 0.9),
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
          FormContainer(
            title: "Parent information:",
            width: screenWidth(context, coeff: 0.9),
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
          FormContainer(
            title: "Authentication:",
            width: screenWidth(context, coeff: 0.9),
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
          FormContainer(
            title: "Videos:",
            width: screenWidth(context, coeff: 0.9),
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
                padding: const EdgeInsets.all(50.0),
                child: RaisedButton(
            color: Colors.blue,
            textColor: Colors.white,
            shape: RoundedRectangleBorder (
                borderRadius: BorderRadius.circular(5.0),
            ),
            onPressed: () {
                if (_formKey.currentState.validate() & (files[0] != null) & (files[1] != null)) {
                  sendData();
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
    String uploadURL = 'http://192.168.1.45:8080/api/upload';
    Dio dio = new Dio();
    FormData formData = FormData.fromMap({
      "childFirtName": childFirstNameController.text,
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
    setState(() {
      loading = !loading;
    });
    Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text('Processing data...')));
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

class FormContainer extends StatelessWidget {
  FormContainer({Key key, this.children, this.width, this.title}) : super(key: key);

  final children;
  final width;
  final title;

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
              width: this.width,
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