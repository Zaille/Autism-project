import 'package:autismtest/main.dart';
import 'package:autismtest/roundedContainer.dart';
import 'package:autismtest/submitButton.dart';
import 'package:flutter/material.dart';

class Thank extends StatefulWidget {
  @override
  ThankState createState() {
    return ThankState();
  }
}

class ThankState extends State<Thank> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        RoundedContainer(
          title: "Thank You",
          titleSize: 30.0,
          color: Colors.lightBlue.withOpacity(0.2),
          children: [
            Text("          Lorem ipsum dolor sit amet, consectetur adipiscing "
              "elit. Sed non risus. Suspendisse lectus tortor, "
              "dignissim sit amet, adipiscing nec, ultricies sed, "
              "dolor. Cras elementum ultrices diam. Maecenas ligula "
              "massa, varius a, semper congue, euismod non, mi. "
              "Cras elementum ultrices diam. Maecenas ligula "
              "massa, varius a, semper congue, euismod non, mi.\n\n\n\n"
              "          Lorem ipsum dolor sit amet, consectetur adipiscing "
              "elit. Sed non risus. Suspendisse lectus tortor, "
              "dignissim sit amet, adipiscing nec, ultricies sed, "
              "dolor. Cras elementum ultrices diam. Maecenas ligula "
              "massa, varius a, semper congue, euismod non, mi.",
            textAlign: TextAlign.justify
            ),
          ]
        ),
        Spacer(),
        SubmitButton(
          text: "FINISH",
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyApp()),
            );
          },
        ),
      ],
    );
  }
}

class ThanksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Thank()
    );
  }
}
