import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  SubmitButton({
    Key key,
    this.text = "SUBMIT",
    this.padding = const EdgeInsets.all(50.0),
    this.onPressed,
    this.color = Colors.blue,})
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
        onPressed: this.onPressed,
      ),
    );
  }

}