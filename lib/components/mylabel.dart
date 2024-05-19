import 'package:flutter/material.dart';

class MyLabel extends StatelessWidget {
  final String text;
  final Color bgColor;
  final double size;
  const MyLabel(
      {super.key,
      this.text = "",
      this.bgColor = Colors.lightGreenAccent,
      this.size = 20.0});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 3), color: bgColor),
        child: Center(
            child: Text(text,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: size))));
  }
}
