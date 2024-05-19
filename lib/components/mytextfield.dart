import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keyboard_actions/keyboard_custom.dart';

class MyTextField extends StatelessWidget {
  final String hint;
  final Function event;
  final FocusNode? focus;
  final bool isInt;
  final double size;
  final Color color, bgColor;
  final TextEditingController? controller;
  const MyTextField(
      {super.key,
      this.hint = "",
      this.size = 12.0,
      required this.event,
      this.color = Colors.black,
      this.bgColor = Colors.white,
      this.controller,
      this.focus,
      this.isInt = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        border: Border.all(color: Colors.black, width: 3),
      ),
      child: TextField(
          controller: controller,
          onChanged: event(),
          textAlign: TextAlign.right,
          //textInputAction: TextInputAction.next,
          focusNode: focus,
          keyboardType: const TextInputType.numberWithOptions(
              decimal: true, signed: true),
          inputFormatters: <TextInputFormatter>[
            //FilteringTextInputFormatter.digitsOnly,
            !isInt
                ? FilteringTextInputFormatter.allow(RegExp(r'(^\-?\d*\.?\d*)'))
                : FilteringTextInputFormatter.digitsOnly,
          ],
          style: TextStyle(fontSize: size, color: color),
          decoration: InputDecoration(
            labelText: hint,
          )),
    );
  }
}

class CTextField extends StatelessWidget {
  final ValueNotifier<String> notifier;
  final String hint;
  final VoidCallback event;
  final FocusNode focus;
  final double size;
  final Color color, bgColor;
  const CTextField(
      {super.key,
      this.hint = "",
      required this.notifier,
      this.size = 12.0,
      required this.event,
      this.color = Colors.black,
      this.bgColor = Colors.white,
      required this.focus});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: bgColor, border: Border.all(color: Colors.black, width: 3)),
      child: KeyboardCustomInput<String>(
          focusNode: focus,
          builder: (context, val, hasFocus) {
            return Text(val,
                textAlign: TextAlign.right,
                style: TextStyle(
                    fontSize: size,
                    color: hasFocus! ? Colors.red : color,
                    fontWeight:
                        hasFocus ? FontWeight.w900 : FontWeight.normal));
          },
          notifier: notifier),
    );
  }
}
