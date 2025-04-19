import 'dart:ui';

import 'package:flutter/material.dart';

class CategoryMenuButton extends StatelessWidget {
  const CategoryMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      ClipRRect(borderRadius: BorderRadius.all(Radius.circular(30)), child: 
        BackdropFilter(filter: ImageFilter.blur(sigmaX: 16.0, sigmaY: 16.0), child: 
          Container(width: 160, height: 46, decoration: ShapeDecoration(color: Colors.white.withAlpha(0x03), 
            shape: RoundedRectangleBorder(side: BorderSide(width: 1, style: BorderStyle.solid, 
            color: Colors.white.withAlpha(0x1f)), borderRadius: BorderRadius.circular(30)),)))), 
      Container(height: 46, padding: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 12),
        decoration: ShapeDecoration(color: Colors.white.withAlpha(51), shape: RoundedRectangleBorder(side: BorderSide(width: 1, color: Colors.white.withAlpha(128)), borderRadius: BorderRadius.circular(30))),
        child: Row(spacing: 4,
          children: [Image.asset("assets/jp_app/details/snack_symbol.png", alignment: Alignment.centerLeft), Text("All categories", style: TextStyle(color: const Color(0x99EBEBF5), fontSize: 12, fontFamily: 'SF Pro Display', fontWeight: FontWeight.w700, height: 1.92, letterSpacing: -0.1)), Image.asset("assets/jp_app/details/cheffron_down.png", width: 13, height: 11, alignment: Alignment.bottomLeft)]
      )),
    ]);
  }
}