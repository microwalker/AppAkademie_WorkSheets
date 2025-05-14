import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(title: "Hello World", home: Sbb()));
}

class Sbb extends StatefulWidget {
  const Sbb({super.key});

  @override
  State<Sbb> createState() => _SbbState();
}

class _SbbState extends State<Sbb> {
  bool sliderVisible = false;
  double sliderValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Steckbrief Berlin"), backgroundColor: Colors.orangeAccent),
      body: Padding(
        padding: const EdgeInsets.all(12.0), child: 
          Column(mainAxisAlignment: MainAxisAlignment.center, spacing: 12, children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("Name"), Text("Berlin")]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("Einwohner"), Text("viel zu viele")]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("Sehenswürdigkeiten"), Text("App Akademie, Berghain")]),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              ElevatedButton(onPressed: () => setState(() => sliderVisible = true), style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Color.fromARGB(255, 44, 103, 199))), child: Text("Stadt bewerten", style: TextStyle(color: Colors.white),))]),
            if(sliderVisible) Slider(value: sliderValue, onChanged: (value) => setState(() => sliderValue = value ))         
          ]),
        ));
  }
}
