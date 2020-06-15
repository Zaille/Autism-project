import 'package:autismtest/questions.dart';
import 'package:autismtest/submitButton.dart';
import 'package:flutter/material.dart';
import 'RoundedContainer.dart';

class Instructions extends StatefulWidget {
  @override
  InstructionsState createState() {
    return InstructionsState();
  }
}

class InstructionsState extends State<Instructions> {

  final _formKey = GlobalKey<FormState>();
  bool checkedValue = false;

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[

          RoundedContainer(
              title: "Instructions",
              titleSize: 30.0,
              color: Colors.lightBlue.withOpacity(0.2),
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
          SubmitButton(
            text:"ACCEPT",
            onPressed: () {
              if (checkedValue) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuestionsPage()),
                );
              }
              else {
                Scaffold.of(context).showSnackBar(new SnackBar(
                  content: new Text("Please accept ToS and PP"),
                  duration: const Duration(seconds: 2),
                ));
              }
            },
          ),
        ],
      ),
    );
  }

}

class InstructionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Instructions(),
    );
  }
}
