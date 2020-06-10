import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Instructions extends StatefulWidget {
  @override
  InstructionsState createState() {
    return InstructionsState();
  }
}

class InstructionsState extends State<Instructions> {

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

  bool checkedValue = false;


  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[

          MyContainer(
              title: "Instructions",

              children: <Widget>[
//
                      RichText(
                        text: TextSpan(

                          text: '''
       Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque eget mattis orci. Ut tincidunt leo aliquet turpis lacinia, vitae gravida metus aliquam.
                    
      Proin efficitur in sapien nec rutrum. Maecenas facilisis ipsum tincidunt, tristique nisi in, tempus elit. Vivamus auctor nulla et tellus hendrerit, a congue risus tincidunt. Nam sit amet condimentum enim. Quisque a massa sodales, placerat est sed, tincidunt nibh. Pellentesque blandit turpis augue, sed sagittis odio ullamcorper elementum. Nam eget justo vel ipsum semper dapibus. Donec consectetur venenatis velit, a accumsan orci hendrerit facilisis.

      Phasellus pharetra, erat a volutpat elementum, leo nibh mollis elit, quis bibendum dui tellus non lectus. Aliquam eros nisl, tristique ultricies est at, gravida sagittis felis. Pellentesque lobortis leo ut bibendum porttitor. Aenean aliquam diam tristique bibendum imperdiet. Nullam dui justo, faucibus nec venenatis ac, dapibus in lacus. Maecenas odio leo, placerat sit amet velit mattis, porttitor tincidunt leo.

                    ''',
                          style: DefaultTextStyle.of(context).style,
                        ),
                      ),
                    ]
                ),

//              ]
//          ),
          Row(
            children: [
              Checkbox(
                value: checkedValue,
                activeColor: Colors.grey.withOpacity(.2),
                checkColor: Colors.blue,
                  onChanged: (newValue) {
                  setState(() {
                    checkedValue = newValue;
                    print(checkedValue);
                  });
                  },
              ),

              RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(text: 'I agree to the '),
                    TextSpan(text: 'Terms of Service', style: TextStyle(color: Colors.blue)),
                    TextSpan(text: ' and '),
                    TextSpan(text: 'Privacy Policy', style: TextStyle(color: Colors.blue)),
                  ],
                ),
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
                if (checkedValue) {
                  acceptTerms();
                }
                else {
                  setState(() {
                    errorMessageColor = Colors.red;
                    Scaffold.of(context).showSnackBar(new SnackBar(
                        content: new Text("Please accept ToS and PP"),
                        duration: const Duration(seconds: 2),
                    ));
                  });
                }
              },
              child: Text('ACCEPT'),
            ),
          ),
        ],
      ),
    );
  }

  Future acceptTerms() async {
    setState(() {
      loading = !loading;
    });
      Scaffold.of(context).showSnackBar(new SnackBar(
          content: new Text("Go to the next page!"),
        duration: const Duration(seconds: 2),
      ));

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
    Align(
    alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(top: 40, bottom: 15, left: 60),
          child: Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Colors.grey),
          ),
        ),
    ),
        Align(
          alignment: Alignment.centerLeft,
          child: Center(
            child: Container(
              width: screenWidth(context, coeff: 0.9),
              decoration: BoxDecoration(
                color: Colors.lightBlue.withOpacity(0.2),
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