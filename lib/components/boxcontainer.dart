import 'package:flutter/material.dart';

class MyContainer extends StatelessWidget {
  final Widget? child;
  final double height;
  const MyContainer({super.key, this.child, this.height = 65.0});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 3,
          )
        ]),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: child);
  }
}
