import "package:flutter/material.dart";

class RoundedContainer extends StatelessWidget {
  RoundedContainer({
    Key key,
    this.children,
    this.title = "",
    this.titleSize = 24.0,
    this.color = Colors.white,
    this.height = null})
      : super(key: key);

  final children;
  final title;
  final titleSize;
  final color;
  final height;

  Size screenSize(BuildContext context) {return MediaQuery.of(context).size;}
  double screenHeight(BuildContext context, {double coeff = 1}) {return screenSize(context).height * coeff;}
  double screenWidth(BuildContext context, {double coeff = 1}) {return screenSize(context).width * coeff;}

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(top: 40, bottom: 15, left: 40),
            child: Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: this.titleSize,
                  color: Colors.blueGrey),
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Center(
            child: Container(
              height: this.height,
              width: screenWidth(context, coeff: 0.9),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
                child: Column(
                  children: this.children,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}