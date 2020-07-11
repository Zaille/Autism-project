import 'package:asdscreening/copyright.dart';
import 'package:asdscreening/instructions.dart';
import 'package:asdscreening/questions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        padding: EdgeInsets.symmetric(vertical: 30),
        width: 300,
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => QuestionsPage()),
            );
          },
          label: Text("START"),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0)),),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Column(
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
          Expanded(
            flex: 3,
            child: Container(
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
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.only(top: 20.0, left: 35),
                        child: Text("What is M-CHAT-R/F™ ?",
                          style: Theme.of(context).textTheme.headline2,
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          "          The Modified Checklist for Autism in Toddlers, "
                          "Revised (M-CHAT-R) is a screener that will ask a "
                          "series of 20 questions about your child’s behavior. "
                          "It's intended for toddlers between 16 and 30 months "
                          "of age. The results will let you know if a further "
                          "evaluation may be needed. You can use the results of "
                          "the screener to discuss any concerns that you may "
                          "have with your child’s healthcare provider.\n\n"
                          "          Please answer questions to reflect your "
                          "child's usual behaviors. If the behavior is rare "
                          "(e.g., you've seen it only once or twice), "
                          "answer as if the child has not acquired the behavior.",
                          textAlign: TextAlign.justify,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ),
                    ],
                  ),
                )
            ),
          ),
//          Spacer(),
          Expanded(child: Container(height: 100,)),
          Copyright(),
        ],
      ),
    );
  }
}
