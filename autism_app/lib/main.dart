
import 'package:flutter/material.dart';
import 'package:autismtest/uploadPage.dart';
import 'package:email_validator/email_validator.dart';

void main() {
  runApp(MaterialApp(
    title: 'Application',
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Home'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              EmailWidget(),
              RaisedButton(
                child: Text('Want to upload pictures ?'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UploadPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EmailWidget extends StatelessWidget {

  final myController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Size screenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }double screenHeight(BuildContext context, {double coeff = 1}) {
    return screenSize(context).height * coeff;
  }double screenWidth(BuildContext context, {double coeff = 1}) {
    return screenSize(context).width * coeff;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth(context, coeff: 1),
      child: Form(
        key: formKey,
        child:TextFormField(
          controller: myController,
          keyboardType: TextInputType.emailAddress,
          maxLength: 50,
          enableInteractiveSelection: true,
          decoration: InputDecoration(
            labelText: "Email",
            //icon: Icon(Icons.mail),
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (!EmailValidator.validate(value)) {
              return 'Not a valid email';
            }
            return null;
          },
        ),
      ),
    );
  }
}

class ScreenArguments {
  final String title;
  final String message;

  ScreenArguments(this.title, this.message);
}



