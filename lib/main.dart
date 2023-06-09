import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'calculator.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Calculator App Flutter",
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Flutter Calculator"),
          backgroundColor: Colors.black,
          titleTextStyle: GoogleFonts.ubuntu(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: const CalculatorWidget(),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 7, 45),
      ),
    );
  }
}
