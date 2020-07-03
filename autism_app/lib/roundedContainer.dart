import "package:flutter/material.dart";

class RoundedContainer extends StatelessWidget {
  RoundedContainer({
    Key key,
    @required this.context,
    this.children,
    this.title = "",
    this.titleSize = 24.0,
    this.outerTitle = true,
    this.color,
    this.height})
      : super(key: key);

  final context;
  final List<Widget> children;
  final String title;
  final double titleSize;
  final bool outerTitle;
  final Color color;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        outerTitle ?
        Padding(
          padding: const EdgeInsets.only(top: 40, bottom: 15, left: 30),
          child: Text(
            title,
            style: Theme.of(context).textTheme.headline1,
          ),
        )
        : Container(padding: EdgeInsets.all(5),),
        Center(
          child: Container(
            height: this.height,
            margin: EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: getBackgroundColor(),
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).highlightColor,
                  spreadRadius: 5,
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15, bottom: 10, top: 15),
              child: Column(
                children: this.children,
              ),
            ),
          ),
        ),
      ],
    );
  }

  getBackgroundColor() {
    if (this.color == null) return Theme.of(context).backgroundColor;
    return color;
  }
}