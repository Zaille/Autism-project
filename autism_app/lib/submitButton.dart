import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  SubmitButton({
    Key key,
    this.text = "SUBMIT",
    this.onPressed,
    this.color = Colors.blue,})
      : super(key: key);

  final text;
  final onPressed;
  final color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50.0),
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