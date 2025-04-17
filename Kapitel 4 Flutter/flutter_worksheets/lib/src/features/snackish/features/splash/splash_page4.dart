import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_worksheets/src/themes/styles.dart';

class SplashPage4 extends StatelessWidget {
  const SplashPage4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(fit: StackFit.expand, children: [
        DecoratedBox(decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/jp_app/hintergründe/bg_startscreen.png"), fit: BoxFit.cover))),
        // Image.asset("assets/jp_app/hintergründe/bg_startscreen.png", fit: BoxFit.fitHeight),
        Positioned(left: -30, top: 108, child: Image.asset("assets/jp_app/grafiken/cupcake_chick.png", width: 600, fit: BoxFit.fitHeight,)),
        Positioned.fill(top: 372, child: Image.asset("assets/jp_app/details/snack_snack.png", fit: BoxFit.fitWidth)),
        Positioned.fill(top: 612, child: 
          StartGlassCard())
      ],),
    );
  }
}

class StartGlassCard extends StatelessWidget {
  const StartGlassCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
        _GlassRect(key: super.key, width: 376, height: 230)]),
      SizedBox(width: double.infinity, child: 
        Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: [
          Container(width: 360, height: 230, padding: EdgeInsets.all(28), child: 
            Column(spacing: 4, children: [
              Text('Feeling Snackish Today?', style: TextStyle(color: Colors.white, fontSize: 23, fontFamily: 'Inter', fontWeight: FontWeight.w900, height: 1.25, letterSpacing: 0.1, shadows: [fontShadow])),
              Padding(padding: EdgeInsets.all(4), child: Text('Explore Angi’s most popular snack selection and get instantly happy.', textAlign: TextAlign.center, style: TextStyle(color: const Color(0x99EBEBF5), fontFamily: "SF Pro", fontSize: 14, fontWeight: FontWeight.w500, height: 1.38, letterSpacing: -0.08, shadows: [fontShadow]))),
              SizedBox(height: 26),
              GestureDetector(onTap: () {}, 
                child: Container(width: 220, height: 56, decoration: pinkButtonDecoration, child: 
                  Center(child: Text('Order Now', style: TextStyle(color: Colors.white, fontSize: 19, fontFamily: 'Inter', fontWeight: FontWeight.w700, height: 1.35, letterSpacing: -0.1, shadows: [fontShadowButton])))))
              ]))
          ]))
    ]);
  }
}

class _GlassRect extends StatelessWidget {
  final double width;
  final double height;

  const _GlassRect({
    super.key, required this.width, required this.height, 
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(borderRadius: BorderRadius.all(Radius.circular(30)), child: 
      BackdropFilter(filter: ImageFilter.blur(sigmaX: 16.0, sigmaY: 16.0), child: 
        Container(width: width, height: height, decoration: ShapeDecoration(color: Colors.white.withAlpha(0x03), shape: RoundedRectangleBorder(side: BorderSide(width: 1, style: BorderStyle.solid, color: Colors.white.withAlpha(0x1f)), borderRadius: BorderRadius.circular(30)),))));
  }
}