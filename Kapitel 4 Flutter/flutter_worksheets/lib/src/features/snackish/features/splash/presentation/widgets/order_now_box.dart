import 'dart:ui';
import 'package:flutter/material.dart';

Decoration startBoxDecoration = ShapeDecoration(color: Colors.white.withValues(alpha: 0x3f), shape: RoundedRectangleBorder(side: BorderSide(width: 1, color: Colors.white.withValues(alpha: 77)), borderRadius: BorderRadius.circular(30)));
Shadow fontShadow = Shadow(offset: Offset(0, 10), blurRadius: 60, color: Color(0xFF000000).withAlpha(0x7f));
Shadow fontShadowButton = Shadow(offset: Offset(0, 10), blurRadius: 20, color: Color(0xFF000000).withAlpha(0x3f));
ShapeDecoration pinkButtonDecoration = ShapeDecoration(gradient: LinearGradient(begin: Alignment(0.50, -0.23), end: Alignment(0.50, 1.00), colors: [const Color(0xFFFDC7F0), const Color(0x00ED92D7)]), shape: RoundedRectangleBorder(side: BorderSide(width: 1), borderRadius: BorderRadius.circular(10)), shadows: [BoxShadow(color: Color(0x7FEA71C5), blurRadius: 30, offset: Offset(0, 10), spreadRadius: 0)]);

class OrderNowBox extends StatelessWidget {
  const OrderNowBox({super.key});

  @override
  Widget build(BuildContext context) {
    
    return 
      Stack(fit: StackFit.expand, children: [
        ClipRRect(borderRadius: BorderRadius.all(Radius.circular(30)), child: 
          BackdropFilter(filter: ImageFilter.blur(sigmaX: 16.0, sigmaY: 16.0), child: 
          Container(width: 360, height: 200, color: Colors.white.withAlpha(0x07)))),
        Container(width: 360, height: 200, padding: EdgeInsets.all(30), child: 
          Column(children: [
            Text('Feeling Snackish Today?', style: TextStyle(color: Colors.white, fontSize: 22, fontFamily: 'Inter', fontWeight: FontWeight.w900, height: 1.27, letterSpacing: 0.35, shadows: [fontShadow])),
            Text('Explore Angi’s most popular snack selection and get instantly happy.', style: TextStyle(color: const Color(0x99EBEBF5), fontFamily: "SF Pro", fontSize: 13, fontWeight: FontWeight.w400, height: 1.38, letterSpacing: -0.08, shadows: [fontShadow])),
            Container(width: 202, height: 48, padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 14), 
              decoration: pinkButtonDecoration, child: 
                Row(spacing: 10, children: [SizedBox(width: 121, child: 
                  Text('Order Now', style: TextStyle(color: Colors.white, fontSize: 17, fontFamily: 'Inter', fontWeight: FontWeight.w600, height: 1.35, shadows: [fontShadowButton]))
                )]))]))]);
  }
}