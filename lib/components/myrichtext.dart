import 'package:flutter/material.dart';

class MyRichText extends StatelessWidget {
  final List<InlineSpan>? children;
  final Color bgColor;
  final double size;
  final Widget? child;
  const MyRichText(
      {super.key,
      this.children,
      this.bgColor = Colors.lightGreenAccent,
      this.size = 20.0,
      this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 3), color: bgColor),
        child: Center(
            child: RichText(
                text: TextSpan(
                    style: TextStyle(
                        fontSize: size,
                        backgroundColor: bgColor,
                        color: Colors.black),
                    children: children))));
  }
}
