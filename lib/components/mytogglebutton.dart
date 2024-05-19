import 'package:flutter/material.dart';

class MyTogglebutton extends StatelessWidget {
  final List<Widget> children;
  final Function(int index) event;
  final List<bool> list;
  const MyTogglebutton(
      {super.key,
      required this.children,
      required this.event,
      required this.list});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(40)),
      child: ToggleButtons(
        fillColor: Colors.blue,
        focusColor: Colors.yellow,
        color: Colors.black,
        borderColor: Colors.black,
        borderWidth: 2,
        borderRadius: BorderRadius.circular(40),
        selectedColor: Colors.white,
        selectedBorderColor: Colors.black,
        splashColor: Colors.pink,
        highlightColor: Colors.purple,
        onPressed: (v) => event(v),
        isSelected: list,
        children: children,
      ),
    );
  }
}
