/*
import 'package:flutter/material.dart';

class MyFormField extends TextFormField {
  MyFormField({
    Key key,
    onSaved, // Method called when when the form is saved FormFieldValidator
    validator, // Method called for validation
    this.onChanged, // Method called whenever the value changes
  })  : assert(initialValue != null),
        super(
        key: key,
        onSaved: onSaved,
        validator: validator,
      );
  final ValueChanged onChanged;
  @override
  _MyFormFieldState createState() => _MyFormFieldState();
}

class _MyFormFieldState extends FormFieldState<MyFormField> {
  @override
  MyFormField get widget => super.widget;
  @override
  void didChange(bool value) {
    super.didChange(value);
    if (widget.onChanged != null) {
      widget.onChanged(value);
    }
  }
}*/
