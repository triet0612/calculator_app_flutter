import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'calculate_expression.dart';

class CalculatorWidget extends StatefulWidget {
  const CalculatorWidget({super.key});

  @override
  State<CalculatorWidget> createState() => _CalculatorWidgetState();
}

class _CalculatorWidgetState extends State<CalculatorWidget> {
  String _mathExpression = '';
  String _prevExpression = '';

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [expressionbox(), mathInput()],
    );
  }

  Widget expressionbox() {
    return DecoratedBox(
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(30)),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
        reverse: true,
        scrollDirection: Axis.horizontal,
        child: Container(
          alignment: Alignment.center,
          height: 150,
          padding: const EdgeInsets.all(0),
          child: Text(
            _mathExpression,
            style: GoogleFonts.ubuntu(color: Colors.amber, fontSize: 60),
            softWrap: true,
          ),
        ),
      ),
    );
  }

  Widget mathInputButton(String type, Color color) {
    double font = (type == "DEL" || type == "AC")
        ? 22
        : (type == "Prev")
            ? 19
            : 40;

    return Container(
      padding: const EdgeInsets.fromLTRB(2, 2, 2, 2),
      width: MediaQuery.of(context).size.width / 5,
      height: MediaQuery.of(context).size.height / 9.5,
      child: MaterialButton(
        onPressed: () {
          setState(() {
            switch (type) {
              case "DEL":
                if (_mathExpression.isNotEmpty) {
                  var listChar = _mathExpression.split('');
                  listChar.removeLast();
                  _mathExpression = listChar.join('');
                } else {
                  _mathExpression = "";
                }
                break;
              case "AC":
                _mathExpression = "";
                break;
              case "\u00F7" || "\u00D7" || "\u2212" || "+" || "^":
                _mathExpression += " $type ";
              case "=":
                _mathExpression = _mathExpression.trim();
                _prevExpression = _mathExpression;
                _mathExpression = calculateRPN(_mathExpression
                    .replaceAll('\u00F7', '/')
                    .replaceAll('\u00D7', '*')
                    .replaceAll('\u2212', '-'));
                break;
              case "Prev":
                _mathExpression = _prevExpression;
                break;
              default:
                _mathExpression += type;
                break;
            }
          });
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            side: const BorderSide(color: Colors.amber, width: 3)),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            type,
            style: GoogleFonts.ubuntu(
                color: color, fontSize: font, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget mathInput() {
    const color = Color.fromARGB(255, 7, 255, 243);
    return Column(children: [
      Container(
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            mathInputButton("Prev", Colors.amber),
            mathInputButton("DEL", Colors.amber)
          ],
        ),
      ),
      Container(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flex(
              direction: Axis.vertical,
              children: [
                mathInputButton("AC", Colors.deepOrangeAccent),
                mathInputButton("7", color),
                mathInputButton("4", color),
                mathInputButton("1", color),
                mathInputButton("^", color),
              ],
            ),
            Flex(
              direction: Axis.vertical,
              children: [
                mathInputButton("(", color),
                mathInputButton("8", color),
                mathInputButton("5", color),
                mathInputButton("2", color),
                mathInputButton("0", color),
              ],
            ),
            Flex(
              direction: Axis.vertical,
              children: [
                mathInputButton(")", color),
                mathInputButton("9", color),
                mathInputButton("6", color),
                mathInputButton("3", color),
                mathInputButton(".", color),
              ],
            ),
            Flex(
              direction: Axis.vertical,
              children: [
                mathInputButton("\u00F7", color), // /
                mathInputButton("\u00D7", color), // x
                mathInputButton("\u2212", color), // -
                mathInputButton("+", color),
                mathInputButton("=", color),
              ],
            ),
          ],
        ),
      ),
    ]);
  }
}
