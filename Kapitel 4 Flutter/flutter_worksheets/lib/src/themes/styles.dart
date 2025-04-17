import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Gradient goldGradient = LinearGradient(begin: Alignment(-0.00, -0.80), end: Alignment(0.20, 1.20), colors: [Color(0xFFEDECC5), Color(0xFFECEA78), Color(0xFF8C8A32)], stops: [0.0, 0.36, 1.0]);
const Gradient lightGreenGradient = LinearGradient(begin: Alignment(0.00, 0.00), end: Alignment(1.00, 1.00), colors: [Color(0xFFD4EDD5), Color(0xFFA7D0A0), Color(0xFFE3F8E0)]);
const Gradient darkGreenGradient = LinearGradient(begin: Alignment(0.50, 0.00), end: Alignment(0.50, 1.00), colors: [Color(0xFF4D674A), Colors.black], stops: [0.00, 0.41]);
const Color greenStroke = Color(0xFF75996E);
const Color veryLightGreen = Color.fromRGBO(234, 238, 226, 1);
TextStyle carterBlue11 = GoogleFonts.carterOne(fontSize: 11, color: Color(0xff4040a0));
TextStyle carterBlue14 = GoogleFonts.carterOne(fontSize: 14, color: Color(0xff4040a0)); //, shadows: [Shadow(color: Color(0x7fffffff), offset: Offset(4, 4))]);
TextStyle carterBlue18 = GoogleFonts.carterOne(fontSize: 18, color: Color(0xff4040a0)); //, shadows: [Shadow(color: Color(0x7fffffff), offset: Offset(4, 4))]);
TextStyle carterBlue24 = GoogleFonts.carterOne(fontSize: 24, color: Color(0xff4040a0)); //  shadows: [Shadow(color: Color(0x7fffffff), offset: Offset(4, 4))]);

const Gradient buttonPinkLight = LinearGradient(colors: [Color(0xfffec8f1),Color(0x00ed92d7)], stops: [0.0, 0.4], begin: Alignment(0.5, -0.2), end: Alignment.bottomCenter);
const Gradient buttonPink2Blue = RadialGradient(colors: [Color(0xfff69ea3), Color(0xffe970c4)],stops: [0.0, 1.0], center: Alignment(0.95, 0.8), radius: 2.85);
const Gradient buttonStroke = LinearGradient(colors: [Color(0x7f000000), Color(0x7fffffff)], stops: [0.0, 1.0], begin: Alignment(0.4, 0.8), end: Alignment(0.75, -0.2));

Shadow fontShadow = Shadow(offset: Offset(0, 10), blurRadius: 60, color: Color(0xFF000000).withAlpha(0x7f));
Shadow fontShadowButton = Shadow(offset: Offset(0, 10), blurRadius: 20, color: Color(0xFF000000).withAlpha(0x3f));
ShapeDecoration pinkButtonDecoration = ShapeDecoration(gradient: buttonPink2Blue /*LinearGradient(begin: Alignment(0.50, -0.23), end: Alignment(0.50, 1.00), colors: [const Color(0xFFFDC7F0), const Color(0x00ED92D7)]) */, 
  shape: RoundedRectangleBorder(side: BorderSide(width: 1, color: Colors.purple, style: BorderStyle.solid), borderRadius: BorderRadius.circular(10)), shadows: [BoxShadow(color: Color(0x7FEA71C5), blurRadius: 30, offset: Offset(0, 10), spreadRadius: 0)]);

ThemeData glassTheme = ThemeData().copyWith(
  
);