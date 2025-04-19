import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_worksheets/src/themes/styles.dart';

class CategoryButton extends StatelessWidget {
  final String label;
  final bool selected;

  const CategoryButton({super.key, required this.label, required this.selected});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      ClipRRect(borderRadius: BorderRadius.all(Radius.circular(30)), child: 
        BackdropFilter(filter: ImageFilter.blur(sigmaX: 16.0, sigmaY: 16.0), child: 
          Container(width: 96, height: 46, decoration: ShapeDecoration(color: Colors.white.withAlpha(0x03), 
            shape: RoundedRectangleBorder(side: BorderSide(width: 1, style: BorderStyle.solid, 
            color: Colors.white.withAlpha(0x1f)), borderRadius: BorderRadius.circular(30)),)))), 
    Container(width: 96, height: 46, padding: const EdgeInsets.only(top: 10, left: 22, right: 22, bottom: 12),
      decoration: ShapeDecoration(color: Colors.white.withAlpha(selected ? 152 : 51), shape: RoundedRectangleBorder(side: BorderSide(width: 1, color: Colors.white.withAlpha(selected ? 192 : 128)), borderRadius: BorderRadius.circular(30))),
      child: Center(child: Row(mainAxisAlignment: MainAxisAlignment.center, spacing: 4,
        children: [Text(label, style: gSubText.copyWith(color: selected ? Color(0xff302c23) : Color(0x99EBEBF5), fontSize: 12, fontFamily: 'SF Pro Display', fontWeight: FontWeight.w700, height: 1.92, letterSpacing: -0.1 ))]
    )))]);
  }
}
