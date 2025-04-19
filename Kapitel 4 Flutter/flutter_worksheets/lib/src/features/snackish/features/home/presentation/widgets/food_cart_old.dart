import 'dart:ui';

import 'package:flutter/material.dart';
TextStyle header = TextStyle(color: Colors.white, fontSize: 39, fontFamily: 'SF Pro Text', fontWeight: FontWeight.w700, height: 1.54, letterSpacing: -1.50);

class FoodCart extends StatelessWidget {
  const FoodCart({super.key});

  @override
  Widget build(BuildContext context) {
    return 
      Container(width: 396, height: 300, decoration: BoxDecoration(border: Border.all(color: Color(0x1fffffff), width: 1.3), ),  child: 
      Stack(fit: StackFit.expand, children: [
        ClipRRect(borderRadius: BorderRadius.all(Radius.circular(30)), child: 
          BackdropFilter(filter: ImageFilter.blur(sigmaX: 16.0, sigmaY: 16.0), child: 
          Container(width: 360, height: 200, color: Colors.white.withAlpha(0x07))))
      ]));
  }
}