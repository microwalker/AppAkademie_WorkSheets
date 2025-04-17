import 'dart:math' as math;
import 'package:flutter/material.dart';

class MyTransform extends StatefulWidget { 
  final Color labelColor;

  const MyTransform({super.key, this.labelColor = Colors.white}); // optionaler eigener Key

  @override
  State<StatefulWidget> createState() => MyTransformState();
}
class MyTransformState extends State<MyTransform> {
  int _angle = 0;
  
  int get angle => _angle;

  @override
  Widget build(BuildContext context) {
    return 
      Column(spacing: 8, children: [
      Transform(transform: Matrix4.rotationY((_angle * (math.pi/180))), origin: Offset(150, 24),
        child: Image.asset("assets/images/mycoins_medium.png", fit: BoxFit.contain, alignment: Alignment.topCenter, width: 300)),
      Slider(value: _angle.toDouble(), onChanged: (value) => changeRotation(value), divisions: 36, thumbColor: Colors.green, label: "Drehung in Grad: $_angle", min: 0, max: 360, padding: EdgeInsets.fromLTRB(48, 8, 48, 8)),  
      // Slider(value: _angle.toDouble(), onChanged: (value) => changeRotation(value), divisions: 180, thumbColor: Colors.green, label: "Drehung in Grad: $_angle", min: 0, max: 360, padding: EdgeInsets.fromLTRB(48, 8, 48, 8)),      
      Text("Drehung aktuell bei $_angle Grad", style: TextStyle(color: widget.labelColor))
      ]);
  }

  void changeRotation(double value) => setState(() {
    _angle = value.toInt();
  });
}
