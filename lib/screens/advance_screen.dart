import 'package:flutter/material.dart';
import 'package:gold_calculator/models/advance.dart';

class AdvanceScreen extends StatelessWidget {
  final double kt, rwt, swt, rd, pwt, e, ssw, ssm, pw, pm, ow, oe, rin;
  final int qty, sqty, rate, ppw, pow;
  final String cate, tpw, tow;
  const AdvanceScreen(
      {super.key,
      this.cate = "",
      this.tpw = "",
      this.tow = "",
      this.e = 0,
      this.rin = 0,
      this.ppw = 0,
      this.pow = 0,
      this.pm = 0,
      this.ow = 0,
      this.oe = 0,
      this.pw = 0,
      this.ssw = 0,
      this.ssm = 0,
      this.rwt = 0,
      this.swt = 0,
      this.rd = 0,
      this.pwt = 0,
      this.qty = 0,
      this.sqty = 0,
      this.kt = 0,
      this.rate = 0});

  List<Advance> _calculation() {
    double r3 = rwt / 96 * (96 - 2);
    double r15 = ((pwt - ((rwt - swt) / 24 * kt)) / 24 * kt) / 11.664 * rate;
    double r16 = ((pwt - ((rwt - swt) / 24 * kt)) / 24 * kt);
    double r17 = r16 / (rwt / 100);
    double r18 = r15 / rwt;
    double r19 = r15 / qty;
    double r20 = pwt / qty / 11.664 * rate;
    double a3 = 0;
    double r25 = 0;
    if (ppw == 1) {
      if (tpw == "Ratti Per Tola") {
        double pss = rwt / 96 * (96 - rin + pw);
        double purew = rwt / 24 * kt;
        double aa = pss - purew;
        a3 = aa / kt * 24;
      } else {
        a3 = tpw == "Weight Percentage" ? pw / kt * 24 : pw / kt * 24;
      }
    } else {
      a3 = pw;
    }
    if (pow == 1) {
      if (r25 == "Ratti Per Tola") {
        double pss = rwt / 96 * (96 - rin + ow);
        double purew = rwt / 24 * kt;
        double aa = pss - purew;
        r25 = aa / kt * 24;
      } else if (tpw == "Weight Percentage") {
        r25 = ow / kt * 24;
      } else {
        r25 = ow / kt * 24;
      }
    } else {
      r25 = ow;
    }
    List<Advance> datas = [
      Advance(id: "1", name: "Rati Down", value: rd.toStringAsFixed(2)),
      Advance(id: "2", name: "Pure Weight", value: pwt.toStringAsFixed(3)),
      Advance(
          id: "3",
          name: "Polish Wastage ($kt KT)",
          value: a3.toStringAsFixed(2)),
      Advance(
          id: "4",
          name: "Polish Wastage Pure",
          value: (pw / 24 * kt).toStringAsFixed(2)),
      Advance(
          id: "5",
          name: "Stone Setting Wastage ($kt KT)",
          value: ssw.toStringAsFixed(2)),
      Advance(
          id: "6",
          name: "Stone Setting Wastage Pure",
          value: (ssw / 24 * kt).toStringAsFixed(3)),
      Advance(id: "7", name: "Stone RS", value: e.toStringAsFixed(2)),
      Advance(
          id: "8",
          name: "$cate Average Weight",
          value: (rwt / qty).toStringAsFixed(3)),
      Advance(
          id: "9",
          name: "$cate Average Pure",
          value: (r3 / qty).toStringAsFixed(3)),
      Advance(
          id: "10",
          name: "$cate Average Stone",
          value: (swt / qty).toStringAsFixed(3)),
      Advance(
          id: "11",
          name: "ُPer Stone Average Weight",
          value: (swt / sqty).toStringAsFixed(3)),
      Advance(
          id: "12",
          name: "ُPer Stone Average Rs",
          value: (e / sqty).toStringAsFixed(2)),
      Advance(
          id: "13",
          name: "ُPer $cate Stone Rs",
          value: (e / qty).round().toString()),
      Advance(
          id: "14",
          name: "ُPer $cate Stone Quantity Average",
          value: (sqty / qty).round().toString()),
      Advance(
          id: "15", name: "Total Making In Rs", value: r15.round().toString()),
      Advance(
          id: "16",
          name: "Total Making In Gold",
          value: r16.toStringAsFixed(3)),
      Advance(id: "17", name: "Total Making %", value: r17.toStringAsFixed(2)),
      Advance(id: "18", name: "Per Gram", value: r18.round().toString()),
      Advance(
          id: "19",
          name: "Per $cate Average Cost",
          value: r19.round().toString()),
      Advance(
          id: "20",
          name: "Per $cate Average Cost With Gold",
          value: r20.round().toString()),
      Advance(
          id: "21",
          name: "Per Stone Setting Wastage RS",
          value: ((ssw / 24 * kt) / 11.664 * rate / sqty).toStringAsFixed(2)),
      Advance(
          id: "22",
          name: "Stone Setting Making",
          value: ssm.round().toString()),
      Advance(
          id: "23",
          name: "Stone %",
          value: (swt / (rwt / 100)).toStringAsFixed(2)),
      Advance(id: "24", name: "Polish Making", value: pm.toStringAsFixed(2)),
      Advance(id: "25", name: "Other Wastage", value: ow.toStringAsFixed(2)),
      Advance(id: "26", name: "Other Expense", value: oe.toStringAsFixed(2)),
      const Advance(id: "", name: "Thanks for use SAWAS (EGJC)", value: ""),
    ];
    return datas;
  }

  @override
  Widget build(BuildContext context) {
    var datas = _calculation();
    return Scaffold(
        appBar: AppBar(
          title: const Text("Detail"),
        ),
        body: Stack(children: [
          Container(
            decoration:
                const BoxDecoration(color: Color.fromARGB(255, 235, 233, 233)),
          ),
          ListView(
            children: <Widget>[
              DataTable(
                  headingTextStyle: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  dataTextStyle:
                      const TextStyle(fontSize: 18, color: Colors.black),
                  headingRowColor: WidgetStateColor.resolveWith(
                    (states) {
                      return Colors.orangeAccent;
                    },
                  ),
                  dataRowColor: WidgetStateColor.resolveWith(
                    (states) {
                      return Colors.white;
                    },
                  ),
                  columns: const [
                    DataColumn(label: Text('Serial No')),
                    DataColumn(label: Text('Name')),
                    DataColumn(label: Text('Value'), numeric: true),
                  ],
                  rows: datas
                      .map((data) => DataRow(cells: [
                            DataCell(Text(data.id)),
                            DataCell(Text(data.name)),
                            DataCell(Text(data.value,
                                style: const TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w900))),
                          ]))
                      .toList()),
            ],
          ),
        ]));
  }
}
