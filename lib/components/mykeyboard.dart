import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_custom.dart';

class CalculatorKeyboards extends StatelessWidget
    with KeyboardCustomPanelMixin<String>
    implements PreferredSizeWidget {
  @override
  final ValueNotifier<String> notifier;
  const CalculatorKeyboards({Key? key, required this.notifier})
      : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(300);

  @override
  Widget build(BuildContext context) {
    var tstyle =
        const TextStyle(fontSize: 40, color: Color.fromRGBO(120, 50, 5, 1));
    var styles = BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border:
            Border.all(color: const Color.fromRGBO(165, 93, 7, 1), width: 1),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.16),
            offset: Offset(
              3,
              6.0,
            ),
            blurRadius: 5,
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Color.fromRGBO(110, 80, 20, 0.4),
            offset: Offset(
              3,
              6.0,
            ),
            blurRadius: 5,
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Color.fromRGBO(139, 66, 8, 1),
            offset: Offset(
              5,
              1,
            ),
            blurRadius: 5,
            spreadRadius: -20,
          ),
          BoxShadow(
            color: Color.fromRGBO(250, 227, 133, 1),
            offset: Offset(
              1,
              3,
            ),
            blurRadius: 5,
            spreadRadius: -10,
          ),
        ],
        gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromRGBO(165, 78, 7, 1),
              Color.fromRGBO(180, 126, 17, 1),
              Color.fromRGBO(254, 241, 162, 1),
              Color.fromRGBO(188, 136, 27, 1),
              Color.fromRGBO(165, 78, 7, 1),
            ]));
    return Container(
        padding: const EdgeInsets.all(10),
        color: Colors.grey,
        height: preferredSize.height,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Row(
                children: [
                  for (int i = 7; i <= 9; i++)
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          String v = notifier.value;
                          updateValue(v + i.toString());
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: styles,
                          child:
                              Center(child: Text(i.toString(), style: tstyle)),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Row(
                children: [
                  for (int i = 4; i <= 6; i++)
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          String v = notifier.value;
                          updateValue(v + i.toString());
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: styles,
                          child:
                              Center(child: Text(i.toString(), style: tstyle)),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Row(
                children: [
                  for (int i = 1; i <= 3; i++)
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          String v = notifier.value;
                          updateValue(v + i.toString());
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: styles,
                          child:
                              Center(child: Text(i.toString(), style: tstyle)),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        String v = notifier.value;
                        if (v.contains('.')) return;
                        updateValue("$v.");
                      },
                      child: Container(
                        decoration: styles,
                        child: Center(child: Text(".", style: tstyle)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        String v = notifier.value;
                        updateValue("${v}0");
                      },
                      child: Container(
                        decoration: styles,
                        child: Center(child: Text("0", style: tstyle)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        String v = notifier.value;
                        updateValue("${v}00");
                      },
                      child: Container(
                        decoration: styles,
                        child: Center(child: Text("00", style: tstyle)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        String v = notifier.value;
                        updateValue("${v}000");
                      },
                      child: Container(
                        decoration: styles,
                        child: Center(child: Text("000", style: tstyle)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        String str = notifier.value;
                        if (str.isNotEmpty) {
                          str = str.substring(0, str.length - 1);
                        }
                        updateValue(str);
                      },
                      child: Container(
                        decoration: styles,
                        child: const Center(
                            child: Icon(Icons.backspace,
                                size: 40,
                                color: Color.fromRGBO(120, 50, 5, 1))),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}

class IntCalculatorKeyboards extends StatelessWidget
    with KeyboardCustomPanelMixin<String>
    implements PreferredSizeWidget {
  @override
  final ValueNotifier<String> notifier;
  const IntCalculatorKeyboards({Key? key, required this.notifier})
      : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(300);

  @override
  Widget build(BuildContext context) {
    var tstyle =
        const TextStyle(fontSize: 40, color: Color.fromRGBO(120, 50, 5, 1));
    var styles = BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border:
            Border.all(color: const Color.fromRGBO(165, 93, 7, 1), width: 1),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.16),
            offset: Offset(
              3,
              6.0,
            ),
            blurRadius: 5,
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Color.fromRGBO(110, 80, 20, 0.4),
            offset: Offset(
              3,
              6.0,
            ),
            blurRadius: 5,
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Color.fromRGBO(139, 66, 8, 1),
            offset: Offset(
              5,
              1,
            ),
            blurRadius: 5,
            spreadRadius: -20,
          ),
          BoxShadow(
            color: Color.fromRGBO(250, 227, 133, 1),
            offset: Offset(
              1,
              3,
            ),
            blurRadius: 5,
            spreadRadius: -10,
          ),
        ],
        gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromRGBO(165, 78, 7, 1),
              Color.fromRGBO(180, 126, 17, 1),
              Color.fromRGBO(254, 241, 162, 1),
              Color.fromRGBO(188, 136, 27, 1),
              Color.fromRGBO(165, 78, 7, 1),
            ]));
    return Container(
        padding: const EdgeInsets.all(10),
        color: Colors.grey,
        height: preferredSize.height,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Row(
                children: [
                  for (int i = 7; i <= 9; i++)
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          String v = notifier.value;
                          updateValue(v + i.toString());
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: styles,
                          child:
                              Center(child: Text(i.toString(), style: tstyle)),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Row(
                children: [
                  for (int i = 4; i <= 6; i++)
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          String v = notifier.value;
                          updateValue(v + i.toString());
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: styles,
                          child:
                              Center(child: Text(i.toString(), style: tstyle)),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Row(
                children: [
                  for (int i = 1; i <= 3; i++)
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          String v = notifier.value;
                          updateValue(v + i.toString());
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: styles,
                          child:
                              Center(child: Text(i.toString(), style: tstyle)),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        String v = notifier.value;
                        updateValue("${v}0");
                      },
                      child: Container(
                        decoration: styles,
                        child: Center(child: Text("0", style: tstyle)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        String v = notifier.value;
                        updateValue("${v}00");
                      },
                      child: Container(
                        decoration: styles,
                        child: Center(child: Text("00", style: tstyle)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        String v = notifier.value;
                        updateValue("${v}000");
                      },
                      child: Container(
                        decoration: styles,
                        child: Center(child: Text("000", style: tstyle)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        String str = notifier.value;
                        if (str.isNotEmpty) {
                          str = str.substring(0, str.length - 1);
                        }
                        updateValue(str);
                      },
                      child: Container(
                        decoration: styles,
                        child: const Center(
                            child: Icon(Icons.backspace,
                                size: 40,
                                color: Color.fromRGBO(120, 50, 5, 1))),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
