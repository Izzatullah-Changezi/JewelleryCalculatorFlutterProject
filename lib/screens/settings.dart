import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gold_calculator/components/mytextfield.dart';
import 'package:gold_calculator/components/mytogglebutton.dart';
import 'package:gold_calculator/db/gold_database.dart';
import 'package:gold_calculator/db/shared_data_preferences.dart';
import 'package:gold_calculator/models/setting.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

import '../components/boxcontainer.dart';
import '../components/mykeyboard.dart';

class MySettingPage extends StatefulWidget {
  const MySettingPage({Key? key}) : super(key: key);

  @override
  State<MySettingPage> createState() => _MySettingPageState();
}

class _MySettingPageState extends State<MySettingPage> {
  var wastages = ["Without Stone", "With Stone"];
  var pwastages = ["Ratti Per Tola", "Weight Percentage", "Per Price"];
  var pmakes = ["Per Tola", "Per Gram", "Per Price"];
  var sprices = ["Per Carat", "Per Gram", "Per Price"];
  String wast = "Without Stone",
      pwast = "Ratti Per Tola",
      pmake = "Per Tola",
      owast = "Ratti Per Tola",
      sprice = "Per Carat",
      oexp = "Per Tola";
  var fpw = FocusNode(),
      fpm = FocusNode(),
      fssw = FocusNode(),
      fow = FocusNode(),
      fsp = FocusNode(),
      fssm = FocusNode(),
      foe = FocusNode(),
      cpw = ValueNotifier<String>("0"),
      cpm = ValueNotifier<String>("0"),
      cssw = ValueNotifier<String>("0"),
      cow = ValueNotifier<String>("0"),
      csp = ValueNotifier<String>("0"),
      cssm = ValueNotifier<String>("0"),
      coe = ValueNotifier<String>("0");
  List<bool> pages = [true, false, false];
  List<String> pnames = ["reset", "setting1", "setting2"];
  String pname = "reset";
  bool ppw = false, pow = false;

  FToast? fToast;

  void getSettingData() async {
    List<Map> data = await GoldDatabase.instance.retrieveSetting(pname);
    //print(data);
    if (data.isNotEmpty) {
      wast = data[0]['types'];
      pwast = data[1]['types'];
      pmake = data[2]['types'];
      owast = data[4]['types'];
      sprice = data[5]['types'];
      oexp = data[7]['types'];

      cpw.value = data[1]['val'].toString();
      cpm.value = data[2]['val'].toString();
      cssw.value = data[3]['val'].toString();
      cow.value = data[4]['val'].toString();
      csp.value = data[5]['val'].toString();
      cssm.value = data[6]['val'].toString();
      coe.value = data[7]['val'].toString();

      ppw = int.parse(data[1]['isPure'].toString()) == 1;
      pow = int.parse(data[4]['isPure'].toString()) == 1;
      setState(() {});
    }
  }

  getDataFromLocal() async {
    MyLocalData l = MyLocalData();
    pname = await l.getData("setting") == null
        ? "reset"
        : await l.getData("setting") ?? "reset";
    for (int i = 0; i < pnames.length; i++) {
      pages[i] = pnames[i] == pname;
    }
  }

  @override
  void initState() {
    super.initState();
    getDataFromLocal();
    getSettingData();
    fToast = FToast();
    fToast!.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Setting"),
        ),
        body: KeyboardActions(
          autoScroll: true,
          disableScroll: false,
          config: KeyboardActionsConfig(
              keyboardBarColor: const Color.fromARGB(255, 255, 225, 0),
              keyboardSeparatorColor: Colors.black,
              actions: [
                KeyboardActionsItem(
                    focusNode: fpw,
                    footerBuilder: (_) => CalculatorKeyboards(notifier: cpw)),
                KeyboardActionsItem(
                    focusNode: fpm,
                    footerBuilder: (_) => CalculatorKeyboards(notifier: cpm)),
                KeyboardActionsItem(
                    focusNode: fssw,
                    footerBuilder: (_) => CalculatorKeyboards(notifier: cssw)),
                KeyboardActionsItem(
                    focusNode: fow,
                    footerBuilder: (_) => CalculatorKeyboards(notifier: cow)),
                KeyboardActionsItem(
                    focusNode: fsp,
                    footerBuilder: (_) => CalculatorKeyboards(notifier: csp)),
                KeyboardActionsItem(
                    focusNode: fssm,
                    footerBuilder: (_) => CalculatorKeyboards(notifier: cssm)),
                KeyboardActionsItem(
                    focusNode: foe,
                    footerBuilder: (_) => CalculatorKeyboards(notifier: coe)),
              ]),
          child: Column(
            children: <Widget>[
              MyTogglebutton(
                list: pages,
                event: (index) {
                  setState(() {
                    for (int i = 0; i < pages.length; i++) {
                      pages[i] = i == index;
                      if (i == index) {
                        pname = pnames[i];
                      }
                    }
                  });
                  getSettingData();
                },
                children: [
                  Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 20),
                      child: const Text("Reset",
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ))),
                  Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 20),
                      child: const Text("Setting 1",
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ))),
                  Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 20),
                      child: const Text("Setting 2",
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ))),
                ],
              ),
              const SizedBox(height: 20),
              MyContainer(
                height: 70,
                child: Row(
                  children: <Widget>[
                    const Expanded(
                      child: Text("Wastage",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20)),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black, width: 3)),
                        child: DropdownButton(
                          value: wast,
                          isExpanded: true,
                          items: wastages.map((String item) {
                            return DropdownMenuItem(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(fontSize: 16),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              wast = value!;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              MyContainer(
                height: 70,
                child: Row(
                  children: <Widget>[
                    const Expanded(
                      child: Text("Polish Wastage",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20)),
                    ),
                    Checkbox(
                      value: ppw,
                      onChanged: (bool? a) {
                        setState(() {
                          ppw = a!;
                        });
                      },
                      splashRadius: 30,
                    ),
                    const Text("Pure", style: TextStyle(fontSize: 25)),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black, width: 3)),
                        child: DropdownButton(
                          value: pwast,
                          isExpanded: true,
                          items: pwastages.map((String item) {
                            return DropdownMenuItem(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(fontSize: 16),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              pwast = value!;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: CTextField(
                        event: () {},
                        size: 20.0,
                        focus: fpw,
                        notifier: cpw,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              MyContainer(
                height: 70,
                child: Row(
                  children: <Widget>[
                    const Expanded(
                      child: Text("Polish Making",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20)),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black, width: 3)),
                        child: DropdownButton(
                          value: pmake,
                          isExpanded: true,
                          items: pmakes.map((String item) {
                            return DropdownMenuItem(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(fontSize: 16),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              pmake = value!;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: CTextField(
                        event: () {},
                        size: 20.0,
                        focus: fpm,
                        notifier: cpm,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              MyContainer(
                height: 70,
                child: Row(
                  children: <Widget>[
                    const Expanded(
                      child: Text("Stone Setting Wastage",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20)),
                    ),
                    Expanded(
                      child: CTextField(
                        event: () {},
                        size: 20.0,
                        focus: fssw,
                        notifier: cssw,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              MyContainer(
                height: 70,
                child: Row(
                  children: <Widget>[
                    const Expanded(
                      child: Text("Other Wastage",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16)),
                    ),
                    Checkbox(
                      value: pow,
                      onChanged: (bool? a) {
                        setState(() {
                          pow = a!;
                        });
                      },
                      splashRadius: 30,
                    ),
                    const Text("Pure", style: TextStyle(fontSize: 25)),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black, width: 3)),
                        child: DropdownButton(
                          value: owast,
                          isExpanded: true,
                          items: pwastages.map((String item) {
                            return DropdownMenuItem(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(fontSize: 16),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              owast = value!;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: CTextField(
                        event: () {},
                        size: 16.0,
                        focus: fow,
                        notifier: cow,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              MyContainer(
                height: 70,
                child: Row(
                  children: <Widget>[
                    const Expanded(
                      child: Text("Stone Price",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20)),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black, width: 3)),
                        child: DropdownButton(
                          value: sprice,
                          isExpanded: true,
                          items: sprices.map((String item) {
                            return DropdownMenuItem(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(fontSize: 16),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              sprice = value!;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: CTextField(
                        event: () {},
                        size: 16.0,
                        focus: fsp,
                        notifier: csp,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              MyContainer(
                height: 70,
                child: Row(
                  children: <Widget>[
                    const Expanded(
                      child: Text("Stone Setting Making",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16)),
                    ),
                    Expanded(
                      child: CTextField(
                        event: () {},
                        size: 16.0,
                        focus: fssm,
                        notifier: cssm,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              MyContainer(
                height: 70,
                child: Row(
                  children: <Widget>[
                    const Expanded(
                      child: Text("Other Expense",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16)),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black, width: 3)),
                        child: DropdownButton(
                          value: oexp,
                          isExpanded: true,
                          items: pmakes.map((String item) {
                            return DropdownMenuItem(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(fontSize: 16),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              oexp = value!;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: CTextField(
                        event: () {},
                        size: 16.0,
                        focus: foe,
                        notifier: coe,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style: TextButton.styleFrom(
                          foregroundColor: Colors.green,
                          textStyle: const TextStyle(fontSize: 16),
                          padding: const EdgeInsets.all(20)),
                      onPressed: () {
                        insertData(pname);
                        _showToast();
                      },
                      child: const Text("Save and Update")),
                ],
              )
            ],
          ),
        ));
  }

  void insertData(String sname) {
    MyLocalData l = MyLocalData();
    l.saveData("setting", sname);
    GoldDatabase.instance
        .insert(Setting(sname: sname, name: "wast", types: wast, val: 0));
    GoldDatabase.instance.insert(Setting(
        sname: sname,
        name: "pwast",
        types: pwast,
        isPure: ppw ? 1 : 0,
        val: double.parse(cpw.value)));
    GoldDatabase.instance.insert(Setting(
        sname: sname,
        name: "pmake",
        types: pmake,
        val: double.parse(cpm.value)));
    GoldDatabase.instance.insert(Setting(
        sname: sname,
        name: "sswast",
        types: 'non',
        val: double.parse(cssw.value)));
    GoldDatabase.instance.insert(Setting(
        sname: sname,
        name: "owast",
        types: owast,
        isPure: ppw ? 1 : 0,
        val: double.parse(cow.value)));
    GoldDatabase.instance.insert(Setting(
        sname: sname,
        name: "sprice",
        types: sprice,
        val: double.parse(csp.value)));
    GoldDatabase.instance.insert(Setting(
        sname: sname,
        name: "ssmake",
        types: 'non',
        val: double.parse(cssm.value)));
    GoldDatabase.instance.insert(Setting(
        sname: sname, name: "oexp", types: oexp, val: double.parse(coe.value)));
  }

  _showToast() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: const Color.fromARGB(255, 237, 214, 1),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check),
          SizedBox(
            width: 12.0,
          ),
          Text("Your setting has been updated successfully"),
        ],
      ),
    );

    fToast!.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(seconds: 2),
    );
  }
}
