import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: Ws443b()));
}

class Ws443b extends StatefulWidget {

  const Ws443b({super.key});

  @override
  State<Ws443b> createState() => _MainAppState();
}

class _MainAppState extends State<Ws443b> {
  List<int> sizes = [1,1,1];
  List<Color> colors = [Colors.red, Colors.green, Colors.blue];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Expanded Flex")),
      body: 
      Column(children: [
        Slider(value: sizes[1].toDouble(), min: 1, max: 5, divisions: 4, onChanged: (value) => setState(() => sizes[1] = value.toInt() )),
          Expanded(child: 
            Padding(padding: EdgeInsets.all(32), child: 
              Column(spacing: 8, children: [for(int i=0; i<sizes.length; i++) ExpandedBox(flexSize: sizes[i], color: colors[i])])
          ))
      ])
    ); 
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


