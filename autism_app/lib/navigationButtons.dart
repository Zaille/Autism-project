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
    return Container(
      height: 175,
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

class SubmitButton extends StatelessWidget {
  SubmitButton({
    Key key,
    this.text = "SUBMIT",
    this.padding = const EdgeInsets.all(50.0),
    this.onPressed,
    this.color = Colors.blueGrey,})
      : super(key: key);

  final text;
  final padding;
  final onPressed;
  final color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 300,
      padding: this.padding,
      child: RaisedButton(
        child: Text(this.text),
        color: this.color,
        textColor: Colors.white,
        shape: RoundedRectangleBorder (
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 10,
        onPressed: this.onPressed,
      ),
    );
  }

}