import 'package:flutter/material.dart';

class ExpireScreen extends StatelessWidget {
  const ExpireScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.yellow,
        child: const Center(
            child: Text(
          style: TextStyle(color: Colors.black),
          "Your service is not working correctly",
          textAlign: TextAlign.center,
        )));
  }
}
