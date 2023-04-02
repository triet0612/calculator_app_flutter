import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CalculatorWidget extends StatefulWidget {
  const CalculatorWidget({super.key});

  @override
  State<CalculatorWidget> createState() => _CalculatorWidgetState();
}

class _CalculatorWidgetState extends State<CalculatorWidget> {
  String _mathExpression = '';

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
              color: Colors.black, borderRadius: BorderRadius.circular(30)),
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
            reverse: true,
            scrollDirection: Axis.horizontal,
            child: Container(
              height: 150,
              padding: const EdgeInsets.all(0),
              child: Text(
                _mathExpression,
                style: GoogleFonts.ubuntu(color: Colors.white, fontSize: 60),
                softWrap: true,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
