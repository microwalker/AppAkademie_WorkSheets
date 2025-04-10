import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {

  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  List<int> sizes = [1,1,1];
  List<Color> colors = [Colors.red, Colors.green, Colors.blue];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: "MainApp", home: Scaffold(body: 
      Column(children: [
        Slider(value: sizes[1].toDouble(), min: 1, max: 5, divisions: 5, onChanged: (value) => setState(() => sizes[1] = value.toInt() )),
          Expanded(child: 
            Padding(padding: EdgeInsets.all(32), child: 
              Column(spacing: 8, children: [for(int i=0; i<sizes.length; i++) ExpandedBox(flexSize: sizes[i], color: colors[i])])
          ))
      ])
    )); 
  }
}

class ExpandedBox extends StatelessWidget {
  const ExpandedBox({
    super.key,
    required this.flexSize,
    this.color = Colors.black
  });

  final int flexSize;
  final Color color;

  @override
  Widget build(BuildContext context) {
    TextStyle bigbold = TextStyle(color: Colors.yellow, fontSize: 48,fontWeight: FontWeight.bold);
    return Expanded(flex: flexSize, child: Container(width: 300, color: color, child: Center(child: Text("$flexSize", style: bigbold))));
  }
}


