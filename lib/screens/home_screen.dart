import 'dart:math';
import 'package:flutter/material.dart';
import 'package:gold_calculator/components/boxcontainer.dart';
import 'package:gold_calculator/components/mytextfield.dart';
import 'package:gold_calculator/db/gold_database.dart';
import 'package:gold_calculator/screens/advance_screen.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import '../components/mykeyboard.dart';
import '../db/shared_data_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final cates = [
    "Rings",
    "Tops",
    "Bangles",
    "Locket Sets",
    "Lockets",
    "Sets",
    "Nose Pins",
    "Earrings",
    "Bracelets",
    "Chains"
  ];
  final kts = [
    "9 KT",
    "12 KT",
    "14 KT",
    "18 KT",
    "20 KT",
    "21 KT",
    "22 KT",
    "24 KT"
  ];
  String pcate = "Rings",
      pimage = "rings_1",
      kt24 = "24 KT",
      kt22 = "22 KT",
      kt18 = "18 KT",
      kt20 = "20 KT",
      tpw = "",
      tow = "";
  int grate = 0;
  double result = 0,
      rd = 0,
      karat = 0,
      e = 0,
      ssw = 0,
      ssm = 0,
      pw = 0,
      pm = 0,
      ow = 0,
      oe = 0;
  int ppw = 0, pow = 0;
  var rand = Random();
  FocusNode frate = FocusNode(),
      fkt = FocusNode(),
      fin = FocusNode(),
      fout = FocusNode(),
      fpt = FocusNode(),
      fqty = FocusNode(),
      frwt = FocusNode(),
      fswt = FocusNode(),
      fsqty = FocusNode();
  var crate = ValueNotifier<String>("0"),
      ckt = ValueNotifier<String>("0"),
      cin = ValueNotifier<String>("0"),
      cout = ValueNotifier<String>("0"),
      cpt = ValueNotifier<String>("0"),
      cqty = ValueNotifier<String>("1"),
      crwt = ValueNotifier<String>("0"),
      cswt = ValueNotifier<String>("0"),
      csqty = ValueNotifier<String>("1");
  @override
  void initState() {
    super.initState();
    calculation();
  }

  @override
  void dispose() {
    /*if (kt != null) kt.dispose();
    if (ratin != null) ratin.dispose();
    if (ratout != null) ratout.dispose();
    if (point != null) point.dispose();
    if (crwt != null) crwt.dispose();
    if (cswt != null) cswt.dispose();*/
    super.dispose();
  }

  void getRandomImage() {
    int i = rand.nextInt(2) + 1;
    String name = pcate.toLowerCase();
    pimage = "${name}_$i";
  }

  void getResult() async {
    MyLocalData l = MyLocalData();
    String name = await l.getData("setting") == null
        ? "reset"
        : await l.getData("setting") ?? "reset";
    List<Map> data = await GoldDatabase.instance.retrieveSetting(name);
    correctFields();
    double rwt = crwt.value == "" ? 0 : double.parse(crwt.value),
        swt = cswt.value == "" ? 0 : double.parse(cswt.value);
    if (data.isNotEmpty) {
      int qty = int.parse(cqty.value);
      int sqty = int.parse(csqty.value);
      ppw = int.parse(data[1]['isPure'].toString());
      pow = int.parse(data[4]['isPure'].toString());
      double ans1 = data[0]['types'] == 'Without Stone' ? rwt - swt : rwt;
      double ans2 = data[1]['types'] == 'Ratti Per Tola'
          ? ans1 / 96 * data[1]['val']
          : data[1]['types'] == 'Weight Percentage'
              ? (ans1 * data[1]['val']) / 100
              : data[1]['val'] * qty;
      double ans3 = data[2]['types'] == "Per Tola"
          ? ans1 / 11.664 * data[2]['val']
          : data[2]['types'] == 'Per Gram'
              ? ans1 * data[2]['val']
              : data[2]['val'] * qty;
      double ans4 = (data[3]['val'] * sqty) / 100;
      double ans5 = data[4]['types'] == 'Ratti Per Tola'
          ? ans1 / 96 * data[4]['val']
          : data[4]['types'] == 'Weight Percentage'
              ? ans1 / data[4]['val']
              : data[4]['val'] * qty;
      double ans6 = data[5]['types'] == 'Per Carat'
          ? swt * 5 * data[5]['val']
          : data[5]['types'] == 'Per Gram'
              ? swt * data[5]['val']
              : data[5]['val'] * sqty;
      double ans7 = data[6]['val'] / 100 * sqty;
      /*double ans8 = data[7]['types'] == "Per Tola"
          ? ans1 / 11.664 * data[7]['val']
          : data[7]['types'] == 'Per Gram'
              ? ans1 * data[7]['val']
              : data[7]['val'] * qty;*/
      double ans8 = data[7]['types'] == "Per Tola"
          ? rwt / 11.664 * data[7]['val']
          : data[7]['types'] == 'Per Gram'
              ? rwt * data[7]['val']
              : data[7]['val'] * qty;
      //double ans8 = 1803;

      double a1 = ans2 + ans4 + ans5;
      double a2 = ans3 + ans6 + ans7 + ans8;
      double a3 = a2 / grate * 11.664;
      double a4 = a1 + rwt - swt;
      /*print("ans1 " + ans1.toString());
      print("ans2 " + ans2.toString());
      print("ans3 " + ans3.toString());
      print("ans4 " + ans4.toString());
      print("ans5 " + ans5.toString());
      print("ans6 " + ans6.toString());
      print("ans7 " + ans7.toString());
      print("ans8 " + ans8.toString());

      print("a1 " + a1.toString());
      print("a2 " + a2.toString());
      print("a3 " + a3.toString());
      print("a4 " + a4.toString());*/
      pw = ans2;
      pm = ans3;
      ow = ans5;
      oe = ans8;
      ssw = ans4;
      e = ans6;
      ssm = ans7;
      tpw = data[1]['types'];
      tow = data[4]['types'];

      result = (a4 / 24 * karat) + a3;
      rd = (rwt - result) / rwt * 96;

      //print("ratti down: " + rd.toString());
      //print("pure weight: " + result.toString());
      setState(() {});
    }
  }

  var sfont = const TextStyle(fontSize: 16);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sawas Easy Gold Jewellry Cost"),
        actions: <Widget>[
          GestureDetector(
              onTap: () => getResult(),
              child: const Icon(
                Icons.calculate_rounded,
                size: 40,
              )),
          GestureDetector(
              onTap: () {
                getResult();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AdvanceScreen(
                        cate: pcate,
                        ppw: ppw,
                        pow: pow,
                        pw: pw,
                        ssm: ssm,
                        ssw: ssw,
                        rin: double.parse(cin.value),
                        qty: int.parse(cqty.value),
                        sqty: int.parse(csqty.value),
                        rate: grate,
                        rwt: double.parse(crwt.value),
                        swt: double.parse(cswt.value),
                        kt: karat,
                        rd: rd,
                        e: e,
                        pm: pm,
                        ow: ow,
                        oe: oe,
                        pwt: result)));
              },
              child: const Icon(
                Icons.list_alt,
                size: 40,
              )),
          GestureDetector(
              onTap: () => Navigator.pushNamed(context, "/setting"),
              child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(Icons.settings, size: 40))),
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration:
                const BoxDecoration(color: Color.fromARGB(255, 235, 233, 233)),
          ),
          KeyboardActions(
            autoScroll: true,
            disableScroll: false,
            config: KeyboardActionsConfig(
                keyboardBarColor: const Color.fromARGB(255, 255, 225, 0),
                keyboardSeparatorColor: Colors.black,
                actions: [
                  KeyboardActionsItem(
                      focusNode: frate,
                      footerBuilder: (_) =>
                          IntCalculatorKeyboards(notifier: crate)),
                  KeyboardActionsItem(
                      focusNode: fkt,
                      footerBuilder: (_) => CalculatorKeyboards(notifier: ckt)),
                  KeyboardActionsItem(
                      focusNode: fin,
                      footerBuilder: (_) => CalculatorKeyboards(notifier: cin)),
                  KeyboardActionsItem(
                      focusNode: fout,
                      footerBuilder: (_) =>
                          CalculatorKeyboards(notifier: cout)),
                  KeyboardActionsItem(
                      focusNode: fpt,
                      footerBuilder: (_) => CalculatorKeyboards(notifier: cpt)),
                  KeyboardActionsItem(
                      focusNode: fqty,
                      footerBuilder: (_) =>
                          IntCalculatorKeyboards(notifier: cqty)),
                  KeyboardActionsItem(
                      focusNode: frwt,
                      footerBuilder: (_) =>
                          CalculatorKeyboards(notifier: crwt)),
                  KeyboardActionsItem(
                      focusNode: fswt,
                      footerBuilder: (_) =>
                          CalculatorKeyboards(notifier: cswt)),
                  KeyboardActionsItem(
                      focusNode: fsqty,
                      footerBuilder: (_) =>
                          IntCalculatorKeyboards(notifier: csqty)),
                ]),
            child: Column(
              children: [
                const SizedBox(height: 10),
                Row(children: [
                  Expanded(
                      child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: Column(
                            children: [
                              MyContainer(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Icon(Icons.money_rounded, size: 30),
                                    Expanded(
                                        child: CTextField(
                                      hint: "100",
                                      event: () {},
                                      focus: frate,
                                      notifier: crate,
                                    )),
                                    Text("Per Tola ", style: sfont),
                                    const Text("24 ",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue)),
                                    Text((grate / 11.664).round().toString(),
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green)),
                                    const Text(" Per GM",
                                        style: TextStyle(fontSize: 10)),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              MyContainer(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                        child: CTextField(
                                      event: () {},
                                      focus: fkt,
                                      notifier: ckt,
                                    )),
                                    Text("KT ", style: sfont),
                                    Text(karat.toString(),
                                        style: const TextStyle(
                                            fontSize: 16, color: Colors.blue)),
                                    Text(" KT", style: sfont),
                                    Text(
                                        ((grate / 11.664) / 24 * karat)
                                            .round()
                                            .toString(),
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green)),
                                    const Text(" Per GM",
                                        style: TextStyle(fontSize: 10)),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              MyContainer(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                        child: CTextField(
                                      event: () {},
                                      focus: fin,
                                      notifier: cin,
                                    )),
                                    Text("Ratti", style: sfont),
                                    const Icon(
                                      Icons.arrow_upward_rounded,
                                      color: Colors.green,
                                    ),
                                    Expanded(
                                      child: DropdownButton(
                                          value: kt22,
                                          isExpanded: true,
                                          items: kts.map((String item) {
                                            return DropdownMenuItem(
                                              value: item,
                                              child: Text(
                                                item,
                                                style: sfont,
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (String? nValue) {
                                            setState(() {
                                              kt22 = nValue!;
                                            });
                                          }),
                                    ),
                                    Text(
                                        ((grate / 11.664) /
                                                24 *
                                                int.parse(kt22.split(" ")[0]))
                                            .round()
                                            .toString(),
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green)),
                                    const Text("Per GM",
                                        style: TextStyle(fontSize: 10)),
                                  ],
                                ),
                              ),
                            ],
                          )),
                          const SizedBox(width: 10),
                          SizedBox(
                              width: 200,
                              height: 220,
                              child: Image(
                                image:
                                    AssetImage("assets/category/$pimage.jpg"),
                                fit: BoxFit.cover,
                              )),
                        ],
                      ),
                    ],
                  ))
                ]),
                const SizedBox(height: 10),
                MyContainer(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                          child: CTextField(
                        event: () {},
                        focus: fout,
                        notifier: cout,
                      )),
                      Text("Ratti", style: sfont),
                      const Icon(
                        Icons.arrow_downward_rounded,
                        color: Colors.red,
                      ),
                      Expanded(
                        child: DropdownButton(
                            value: kt18,
                            isExpanded: true,
                            items: kts.map((String item) {
                              return DropdownMenuItem(
                                value: item,
                                child: Text(
                                  item,
                                  style: sfont,
                                ),
                              );
                            }).toList(),
                            onChanged: (String? nValue) {
                              setState(() {
                                kt18 = nValue!;
                              });
                            }),
                      ),
                      Text(
                          ((grate / 11.664) /
                                  24 *
                                  int.parse(kt18.split(" ")[0]))
                              .round()
                              .toString(),
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.green)),
                      const Text(" Per GM", style: TextStyle(fontSize: 10)),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                MyContainer(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                          child: CTextField(
                        event: () {},
                        focus: fpt,
                        notifier: cpt,
                      )),
                      Text("Point ", style: sfont),
                      Expanded(
                        child: DropdownButton(
                            value: kt20,
                            isExpanded: true,
                            items: kts.map((String item) {
                              return DropdownMenuItem(
                                value: item,
                                child: Text(
                                  item,
                                  style: sfont,
                                ),
                              );
                            }).toList(),
                            onChanged: (String? nValue) {
                              setState(() {
                                kt20 = nValue!;
                              });
                            }),
                      ),
                      Text(
                          ((grate / 11.664) /
                                  24 *
                                  int.parse(kt20.split(" ")[0]))
                              .round()
                              .toString(),
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.green)),
                      const Text(" Per GM", style: TextStyle(fontSize: 10)),
                    ],
                  ),
                ),
                Container(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Column(children: [
                      MyContainer(
                        child: Row(
                          children: [
                            const Expanded(
                              child: Text('Product Name',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Colors.black, width: 3)),
                                child: DropdownButton(
                                    value: pcate,
                                    isExpanded: true,
                                    items: cates.map((String item) {
                                      return DropdownMenuItem(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: sfont,
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (String? nValue) {
                                      setState(() {
                                        pcate = nValue!;
                                      });
                                    }),
                              ),
                            ),
                            const SizedBox(width: 30),
                            Expanded(
                                child: Text('$pcate Quantity',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold))),
                            const SizedBox(width: 10),
                            Expanded(
                              child: CTextField(
                                event: () {},
                                focus: fqty,
                                notifier: cqty,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      MyContainer(
                        child: Row(
                          children: [
                            const Expanded(
                              child: Text('Ready Weight',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                            ),
                            Expanded(
                              child: CTextField(
                                event: () {},
                                bgColor:
                                    const Color.fromARGB(255, 246, 210, 133),
                                focus: frwt,
                                notifier: crwt,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      MyContainer(
                        child: Row(
                          children: [
                            const Expanded(
                              child: Text('Stone Weight',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                            ),
                            Expanded(
                              child: CTextField(
                                event: () {},
                                bgColor:
                                    const Color.fromARGB(255, 246, 210, 133),
                                focus: fswt,
                                notifier: cswt,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      MyContainer(
                        child: Row(
                          children: [
                            const Expanded(
                              child: Text('Stone Quantity',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                            ),
                            Expanded(
                              child: CTextField(
                                event: () {},
                                bgColor:
                                    const Color.fromARGB(255, 246, 210, 133),
                                notifier: csqty,
                                focus: fsqty,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      MyContainer(
                        child: Row(
                          children: [
                            const Expanded(
                              child: Text('Ratti Down',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                            ),
                            Expanded(
                              child: Text(rd.toStringAsFixed(2),
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      MyContainer(
                        child: Row(
                          children: [
                            const Expanded(
                              child: Text('Pure Weight',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                            ),
                            Expanded(
                              child: Text(result.toStringAsFixed(3),
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ),
                    ])),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomAppBar(
        height: 50,
        child: Text("Developer: ChangeziTech"),
      ),
    );
  }

  void correctFields() {
    if (crwt.value != '') {
      crwt.value = crwt.value[0] == "." ? "0${crwt.value}" : crwt.value;
    }
    if (cswt.value != '') {
      cswt.value = cswt.value[0] == "." ? "0${cswt.value}" : cswt.value;
    }
  }

  void calculation() {
    frate.addListener(() {
      if (frate.hasFocus || crate.value == '') return;
      crate.value =
          crate.value[0] == "0" ? crate.value.substring(1) : crate.value;
      setState(() {
        grate = int.parse(crate.value);
      });
    });

    fkt.addListener(() {
      if (fkt.hasFocus || ckt.value == '') return;
      double a = double.parse(ckt.value);
      if (a >= 24) ckt.value = "24";
      if (a < 1) ckt.value = a.toString();
      ckt.value = ckt.value[0] == "0" ? ckt.value.substring(1) : ckt.value;
      String value = ckt.value;
      cin.value = (96 / 24 * (24 - double.parse(value)))
          .toStringAsFixed(2)
          .replaceAll(".00", "");
      cout.value = (96 / double.parse(value) * (24 - double.parse(value)))
          .toStringAsFixed(2)
          .replaceAll(".00", "");
      cpt.value = (1000 / 24 * double.parse(value))
          .toStringAsFixed(2)
          .replaceAll(".00", "");
      setState(() {
        value == "" ? karat = 0 : karat = double.parse(value);
      });
    });

    fin.addListener(() {
      if (fin.hasFocus || cin.value == '') return;
      double a = double.parse(cin.value);
      if (a >= 96) cin.value = "96";
      if (a < 1) cin.value = a.toString();
      cin.value = cin.value[0] == "0" ? cin.value.substring(1) : cin.value;
      String val = cin.value;
      cpt.value = (1000 / 96 * (96 - double.parse(val)))
          .toStringAsFixed(2)
          .replaceAll(".00", "");
      cout.value = (double.parse(val) / (96 - double.parse(val)) * 96)
          .toStringAsFixed(2)
          .replaceAll(".00", "");
      ckt.value = (24 / 96 * (96 - double.parse(val)))
          .toStringAsFixed(2)
          .replaceAll(".00", "");
      setState(() {
        ckt.value == "" ? karat = 0 : karat = double.parse(ckt.value);
      });
    });

    fout.addListener(() {
      if (fout.hasFocus || cout.value == '') return;
      double a = double.parse(cout.value);
      if (a >= 96) cout.value = "96";
      if (a < 1) cout.value = a.toString();
      cout.value = cout.value[0] == "0" ? cout.value.substring(1) : cout.value;
      String val = cout.value;
      cpt.value = (1000 / (96 + double.parse(val)) * 96)
          .toStringAsFixed(2)
          .replaceAll(".00", "");
      cin.value = (double.parse(val) / (96 + double.parse(val)) * 96)
          .toStringAsFixed(2)
          .replaceAll(".00", "");
      ckt.value = (24 / (96 + double.parse(val)) * 96)
          .toStringAsFixed(2)
          .replaceAll(".00", "");
      setState(() {
        ckt.value == "" ? karat = 0 : karat = double.parse(ckt.value);
      });
    });

    fpt.addListener(() {
      if (fpt.hasFocus || cpt.value == '') return;
      double a = double.parse(cpt.value);
      if (a >= 1000) cpt.value = "1000";
      if (a < 1) cpt.value = a.toString();
      cpt.value = cpt.value[0] == "0" ? cpt.value.substring(1) : cpt.value;
      String val = cpt.value;
      cout.value = (96 / double.parse(val) * (1000 - double.parse(val)))
          .toStringAsFixed(2)
          .replaceAll(".00", "");
      cin.value = (96 / 1000 * (1000 - double.parse(val)))
          .toStringAsFixed(2)
          .replaceAll(".00", "");
      ckt.value = (double.parse(val) / 1000 * 24)
          .toStringAsFixed(2)
          .replaceAll(".00", "");
      setState(() {
        ckt.value == "" ? karat = 0 : karat = double.parse(ckt.value);
      });
    });

    frwt.addListener(() {
      if (frwt.hasFocus || crwt.value == '') return;
      correctFields();
    });

    fswt.addListener(() {
      if (fswt.hasFocus || cswt.value == '') return;
      correctFields();
    });
  }
}
