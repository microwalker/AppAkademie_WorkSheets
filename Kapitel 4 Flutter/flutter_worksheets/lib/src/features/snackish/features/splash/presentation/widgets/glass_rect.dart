import 'dart:ui';
import 'package:flutter/material.dart';

class GlassRect extends StatelessWidget {
  final double width;
  final double height;

  const GlassRect({
    super.key, required this.width, required this.height, 
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(borderRadius: BorderRadius.all(Radius.circular(30)), child: 
      BackdropFilter(filter: ImageFilter.blur(sigmaX: 16.0, sigmaY: 16.0), child: 
        Container(width: width, height: height, decoration: ShapeDecoration(color: Colors.white.withAlpha(0x03), shape: RoundedRectangleBorder(side: BorderSide(width: 1, style: BorderStyle.solid, color: Colors.white.withAlpha(0x1f)), borderRadius: BorderRadius.circular(30)),))));
  }
}