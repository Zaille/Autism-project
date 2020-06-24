import 'package:autismtest/submitButton.dart';
import 'package:flutter/material.dart';

class NavigationButtons extends StatelessWidget {
  NavigationButtons({
    Key key,
    this.prevCondition = true,
    this.previousFunction,
    this.nextFunction,
  }) : super(key: key);

  final bool prevCondition;
  final nextFunction;
  final previousFunction;


  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child:
            this.prevCondition
                ? SubmitButton(
              text: "PREVIOUS",
              padding: const EdgeInsets.only(top: 50, left: 30, right: 30, bottom: 80),
              onPressed: this.previousFunction,
            )
                : Container(),
          ),
          Expanded(
            child: SubmitButton(
              text: "     NEXT     ",
              padding: const EdgeInsets.only(top: 50, left: 30, right: 30, bottom: 80),
              onPressed: this.nextFunction,
            ),
          ),
        ],
      ),
    );
  }

}
