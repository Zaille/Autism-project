import 'package:autismtest/questions.dart';
import 'package:autismtest/roundedContainer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class InstructionsPage extends StatefulWidget {
  @override
  State<InstructionsPage> createState() {
    return InstructionsState();
  }
}

class InstructionsState extends State<InstructionsPage> {

  final _formKey = GlobalKey<FormState>();
  bool checkedValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Builder(
          builder: (BuildContext context) {
            return Container(
              margin: EdgeInsets.only(bottom: 10),
              width: 300,
              child: FloatingActionButton.extended(
                onPressed: () {
                  if (checkedValue) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => QuestionsPage()),
                    );
                  }
                  else {
                    Scaffold.of(context)
                        .showSnackBar(
                        SnackBar(
                          content: Text("Please accept ToS and PP"),
                          behavior: SnackBarBehavior.floating,
                        )
                    );
                  }
                },
                label: Text("ACCEPT"),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0)),),
              ),
            );
          }
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            RoundedContainer(
                context: context,
                title: "Instructions",
                titleSize: 30.0,
                color: Theme.of(context).cardColor,
                children: <Widget>[
                  RichText(
                    text: TextSpan(

                      text: '''
         Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque eget mattis orci. Ut tincidunt leo aliquet turpis lacinia, vitae gravida metus aliquam.
                      
        Proin efficitur in sapien nec rutrum. Maecenas facilisis ipsum tincidunt, tristique nisi in, tempus elit. Vivamus auctor nulla et tellus hendrerit, a congue risus tincidunt. Nam sit amet condimentum enim. Quisque a massa sodales, placerat est sed, tincidunt nibh. Pellentesque blandit turpis augue, sed sagittis odio ullamcorper elementum. Nam eget justo vel ipsum semper dapibus. Donec consectetur venenatis velit, a accumsan orci hendrerit facilisis.

        Phasellus pharetra, erat a volutpat elementum, leo nibh mollis elit, quis bibendum dui tellus non lectus. Aliquam eros nisl, tristique ultricies est at, gravida sagittis felis. Pellentesque lobortis leo ut bibendum porttitor. Aenean aliquam diam tristique bibendum imperdiet. Nullam dui justo, faucibus nec venenatis ac, dapibus in lacus. Maecenas odio leo, placerat sit amet velit mattis, porttitor tincidunt leo.

                      '''
                          '''
         Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque eget mattis orci. Ut tincidunt leo aliquet turpis lacinia, vitae gravida metus aliquam.
                      
        Proin efficitur in sapien nec rutrum. Maecenas facilisis ipsum tincidunt, tristique nisi in, tempus elit. Vivamus auctor nulla et tellus hendrerit, a congue risus tincidunt. Nam sit amet condimentum enim. Quisque a massa sodales, placerat est sed, tincidunt nibh. Pellentesque blandit turpis augue, sed sagittis odio ullamcorper elementum. Nam eget justo vel ipsum semper dapibus. Donec consectetur venenatis velit, a accumsan orci hendrerit facilisis.

        Phasellus pharetra, erat a volutpat elementum, leo nibh mollis elit, quis bibendum dui tellus non lectus. Aliquam eros nisl, tristique ultricies est at, gravida sagittis felis. Pellentesque lobortis leo ut bibendum porttitor. Aenean aliquam diam tristique bibendum imperdiet. Nullam dui justo, faucibus nec venenatis ac, dapibus in lacus. Maecenas odio leo, placerat sit amet velit mattis, porttitor tincidunt leo.

                      ''',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ]
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
              height: 100,
              child: IntrinsicHeight(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Checkbox(
                        value: checkedValue,
                        activeColor: Colors.grey.withOpacity(.2),
                        checkColor: Colors.blue,
                        onChanged: (newValue) {
                          setState(() {
                            checkedValue = newValue;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(text: 'By clicking Accept, you agree to our '),
                            TextSpan(
                                text: 'Terms of Service',
                                style: TextStyle(color: Colors.blue),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    print('Terms of Service');
                                  }),
                            TextSpan(text: ' and that you have read our '),
                            TextSpan(
                                text: 'Privacy Policy',
                                style: TextStyle(color: Colors.blue),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    print('Privacy Policy');
                                  }),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ),
            Container(margin: EdgeInsets.only(bottom: 120),),
          ],
        ),
      ),
    );
  }

}

