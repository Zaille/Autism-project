import 'package:autismtest/copyright.dart';
import 'package:autismtest/instructions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        padding: EdgeInsets.symmetric(vertical: 80),
        width: 300,
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => InstructionsPage()),
            );
          },
          label: Text("START"),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0)),),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: <Widget>[
              Image.asset(
                'images/home_pic.jpg',
              ),
              Center(
                child: Container(
                  padding: const EdgeInsets.only(top: 70.0),
                  child: Text('M-CHAT-R/F™', style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)
                  ),
                ),
              ),
            ],
          ),
          Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor.withOpacity(0.0),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).cardColor,
                    spreadRadius: 10,
                    blurRadius: 5,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              height: 350.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(top: 20.0, left: 35),
                    child: Text("What is M-CHAT-R/F™ ?",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Color(0xffb6c6ca)
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    child: Text("          Lorem ipsum dolor sit amet, consectetur adipiscing "
                        "elit. Sed non risus. Suspendisse lectus tortor, "
                        "dignissim sit amet, adipiscing nec, ultricies sed, "
                        "dolor. Cras elementum ultrices diam. Maecenas ligula "
                        "massa, varius a, semper congue, euismod non, mi.\n\n"
                        "          Lorem ipsum dolor sit amet, consectetur adipiscing "
                        "elit. Sed non risus. Suspendisse lectus tortor, "
                        "dignissim sit amet, adipiscing nec, ultricies sed, "
                        "dolor. Cras elementum ultrices diam. Maecenas ligula "
                        "massa, varius a, semper congue, euismod non, mi.",
                      textAlign: TextAlign.justify,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                ],
              )
          ),
          Spacer(),
          Copyright(),
        ],
      ),
    );
  }
}
