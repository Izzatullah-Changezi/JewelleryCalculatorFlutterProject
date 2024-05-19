import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

import '../components/mykeyboard.dart';
import '../components/mytextfield.dart';

class OurKeyboardTest extends StatefulWidget {
  const OurKeyboardTest({Key? key}) : super(key: key);

  @override
  State<OurKeyboardTest> createState() => _OurKeyboardTestState();
}

class _OurKeyboardTestState extends State<OurKeyboardTest> {
  FocusNode focus1 = FocusNode(),
      focus2 = FocusNode(),
      focus3 = FocusNode(),
      focus4 = FocusNode(),
      focus5 = FocusNode();
  final cf1 = ValueNotifier<String>("0");
  final cf2 = ValueNotifier<String>("0");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Keyboard Test"),
        ),
        body: KeyboardActions(
          config: KeyboardActionsConfig(
              keyboardBarColor: const Color.fromARGB(255, 255, 225, 0),
              keyboardSeparatorColor: Colors.black,
              actions: [
                KeyboardActionsItem(focusNode: focus1),
                KeyboardActionsItem(focusNode: focus2),
                KeyboardActionsItem(focusNode: focus3),
                KeyboardActionsItem(
                    focusNode: focus4,
                    footerBuilder: (_) => CalculatorKeyboards(notifier: cf1)),
              ]),
          child: Column(
            children: [
              MyTextField(
                event: () {},
                focus: focus1,
              ),
              const SizedBox(height: 30),
              MyTextField(event: () {}, focus: focus2),
              const SizedBox(height: 30),
              MyTextField(event: () {}, focus: focus3),
              const SizedBox(height: 30),
              KeyboardCustomInput<String>(
                  focusNode: focus4,
                  builder: (context, val, hasFocus) {
                    return Container(
                        alignment: Alignment.center,
                        color: hasFocus! ? Colors.pink : Colors.brown,
                        child: Text(val, style: const TextStyle(fontSize: 30)));
                  },
                  notifier: cf1)
            ],
          ),
        ));
  }
}
