import 'dart:async';
import 'package:flutter/material.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      var now = DateTime.now();
      var fdate = DateTime.parse("2024-08-15 10:09:00");
      if (now.isAfter(fdate)) {
        Navigator.pushReplacementNamed(context, "/expire");
      } else {
        Navigator.pushReplacementNamed(context, "/home");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/goldsplash.jpg"),
              fit: BoxFit.fill)),
    );
  }
}
