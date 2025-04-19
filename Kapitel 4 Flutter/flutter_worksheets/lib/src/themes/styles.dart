import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// MyVCoin Styles
const Gradient goldGradient = LinearGradient(begin: Alignment(-0.00, -0.80), end: Alignment(0.20, 1.20), colors: [Color(0xFFEDECC5), Color(0xFFECEA78), Color(0xFF8C8A32)], stops: [0.0, 0.36, 1.0]);
const Gradient lightGreenGradient = LinearGradient(begin: Alignment(0.00, 0.00), end: Alignment(1.00, 1.00), colors: [Color(0xFFD4EDD5), Color(0xFFA7D0A0), Color(0xFFE3F8E0)]);
const Gradient darkGreenGradient = LinearGradient(begin: Alignment(0.50, 0.00), end: Alignment(0.50, 1.00), colors: [Color(0xFF4D674A), Colors.black], stops: [0.00, 0.41]);
const Color greenStroke = Color(0xFF75996E);
const Color veryLightGreen = Color.fromRGBO(234, 238, 226, 1);

// Gallery Styles
TextStyle carterBlue11 = GoogleFonts.carterOne(fontSize: 11, color: Color(0xff4040a0));
TextStyle carterBlue14 = GoogleFonts.carterOne(fontSize: 14, color: Color(0xff4040a0)); //, shadows: [Shadow(color: Color(0x7fffffff), offset: Offset(4, 4))]);
TextStyle carterBlue18 = GoogleFonts.carterOne(fontSize: 18, color: Color(0xff4040a0)); //, shadows: [Shadow(color: Color(0x7fffffff), offset: Offset(4, 4))]);
TextStyle carterBlue24 = GoogleFonts.carterOne(fontSize: 24, color: Color(0xff4040a0)); //  shadows: [Shadow(color: Color(0x7fffffff), offset: Offset(4, 4))]);

// JP App Styles
const Gradient buttonPinkLight = LinearGradient(colors: [Color(0xfffec8f1),Color(0x00ed92d7)], stops: [0.0, 0.4], begin: Alignment(0.5, -0.2), end: Alignment.bottomCenter);
const Gradient buttonPink2Blue = RadialGradient(colors: [Color(0xfff69ea3), Color(0xffe970c4)],stops: [0.0, 1.0], center: Alignment(0.95, 0.8), radius: 2.85);
const Gradient buttonStroke = LinearGradient(colors: [Color(0x7f000000), Color(0x7fffffff)], stops: [0.0, 1.0], begin: Alignment(0.4, 0.8), end: Alignment(0.75, -0.2));
const Gradient buttonBlueViolet = RadialGradient(colors: [Color(0xff908cf5), Color(0xffbb8de1)], stops: [0.0, 1.0], center: Alignment(1.0, 0.7), radius: 1.9 );

// JP App Fonts
TextStyle gHeader = GoogleFonts.inter(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w800, height: 1.27, letterSpacing: 0.35, shadows: [Shadow(offset: Offset(0, 10), blurRadius: 60, color: Color(0xFF000000).withAlpha(0x7f))]);
TextStyle header = TextStyle(color: Colors.white, fontSize: 15, fontFamily: 'Inter', fontWeight: FontWeight.w900, height: 1.27, letterSpacing: 0.35, shadows: [Shadow(offset: Offset(0, 10), blurRadius: 60, color: Color(0xFF000000).withAlpha(0x7f))]);
TextStyle gSubText = GoogleFonts.roboto(color: const Color(0xFFD9D9D9), fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: -0.2, shadows: [Shadow(offset: Offset(0, 30), blurRadius: 180, color: Color(0xFF000000).withAlpha(0x7f))]);
TextStyle gFineText = GoogleFonts.roboto(color: const Color(0xbfD9D9D9), fontSize: 13, fontWeight: FontWeight.w400, letterSpacing: -0.2);

Shadow fontShadow = Shadow(offset: Offset(0, 10), blurRadius: 60, color: Color(0xFF000000).withAlpha(0x7f));
Shadow fontShadowButton = Shadow(offset: Offset(0, 10), blurRadius: 20, color: Color(0xFF000000).withAlpha(0x3f));

List<Shadow> foodCardButtonShadows = [Shadow(color: Color(0xff9375b6), offset: Offset(0, -3), blurRadius: 24), ];

ShapeDecoration pinkButtonDecoration = ShapeDecoration(gradient: buttonPink2Blue /*LinearGradient(begin: Alignment(0.50, -0.23), end: Alignment(0.50, 1.00), colors: [const Color(0xFFFDC7F0), const Color(0x00ED92D7)]) */, 
  shape: RoundedRectangleBorder(side: BorderSide(width: 1, color: Colors.purple, style: BorderStyle.solid), borderRadius: BorderRadius.circular(10)), 
  shadows: [BoxShadow(color: Color(0x7FEA71C5), blurRadius: 30, offset: Offset(0, 10), spreadRadius: 0)]);
ShapeDecoration violetButtonDecoration = ShapeDecoration(gradient: buttonStroke, 
  shape: RoundedRectangleBorder(side: BorderSide(width: 1, color: Colors.white.withAlpha(0x7f), style: BorderStyle.solid), borderRadius: BorderRadius.circular(12)), 
  shadows: [BoxShadow(color: Color(0xfffface4), blurRadius: 4, blurStyle: BlurStyle.inner)]);
ShapeDecoration subcardDecoration = ShapeDecoration(
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30), side: BorderSide(width: 1, color: Color(0x7fffffff), style: BorderStyle.solid)), 
  gradient: LinearGradient(colors: [Color(0x00ffffff), Color(0xff908cf5), Color(0xff8c5bea)], stops: [0.07, 0.61, 1.0], begin: Alignment(0.8, -1.6), end: Alignment(0.7, 0.9)));

