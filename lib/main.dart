import 'package:flutter/material.dart';
import 'package:gold_calculator/screens/advance_screen.dart';
import 'package:gold_calculator/screens/expire_screen.dart';
import 'package:gold_calculator/screens/home_screen.dart';
import 'package:gold_calculator/screens/keyboardscreen.dart';
import 'package:gold_calculator/screens/settings.dart';
import 'package:gold_calculator/screens/splashscreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SAWAS Easy Gold',
      theme: ThemeData(
        colorSchemeSeed: Colors.yellow,
      ),
      routes: {
        "/": (context) => const MySplashScreen(),
        "/expire": (context) => const ExpireScreen(),
        "/home": (context) => const HomeScreen(),
        "/setting": (context) => const MySettingPage(),
        "/advance": (context) => const AdvanceScreen(),
        "/keyboards": (context) => const OurKeyboardTest(),
      },
      //home: const MySplashScreen(),
    );
  }
}
