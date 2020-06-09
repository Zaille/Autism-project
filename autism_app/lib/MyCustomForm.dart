import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final firstNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
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
            title: "Parent information:",
            width: 100.0,
            children: <Widget>[
              TextFormField(
                controller: firstNameController,
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
                controller: nameController,
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
                controller: phoneController,
                keyboardType: TextInputType.phone,
                maxLength: 50,
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
                maxLength: 50,
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
                maxLength: 50,
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false
                // otherwise.
                if (_formKey.currentState.validate()) {
                  // If the form is valid, display a Snackbar.
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('Processing Data')));
                }
              },
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
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
          padding: const EdgeInsets.all(10.0),
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
                padding: const EdgeInsets.all(15.0),
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