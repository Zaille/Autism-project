import 'package:flutter/material.dart';

class NavigationButtons extends StatelessWidget {
  NavigationButtons({
    Key key,
    this.context,
    this.prevCondition = true,
    this.previousFunction,
    this.nextFunction,
  }) : super(key: key);

  final context;
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
              color: Theme.of(context).accentColor,
              padding: const EdgeInsets.only(top: 50, left: 30, right: 30, bottom: 80),
              onPressed: this.previousFunction,
            )
                : Container(),
          ),
          Expanded(
            child: SubmitButton(
              text: "     NEXT     ",
              color: Theme.of(context).accentColor,
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
    this.color,
    this.padding = const EdgeInsets.all(50.0),
    this.onPressed,})
      : super(key: key);

  final text;
  final color;
  final padding;
  final onPressed;

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
          borderRadius: BorderRadius.circular(8.0),
        ),
        elevation: 10,
        onPressed: this.onPressed,
      ),
    );
  }

}