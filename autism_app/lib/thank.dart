import 'package:autismtest/main.dart';
import 'package:autismtest/roundedContainer.dart';
import 'package:flutter/material.dart';


class ThanksPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        padding: EdgeInsets.symmetric(vertical: 50),
        width: 300,
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyApp()),
            );
          },
          label: Text("FINISH"),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0)),),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          RoundedContainer(
              context: context,
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
        ],
      ),
    );
  }
}
