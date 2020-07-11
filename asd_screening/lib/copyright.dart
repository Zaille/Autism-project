import 'dart:io';

import 'package:flutter/material.dart';

class Copyright extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: (Platform.isIOS)
          ?const EdgeInsets.only(top: 5, bottom: 20)
          :const EdgeInsets.all(5.0),
      child: Text("© 2009 Diana Robins, Deborah Fein, & Marianne Barton.",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 12,
            color: Color(0xffaaaaaa)
        ),
      ),
    );
  }
}