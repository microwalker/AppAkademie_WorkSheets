import 'package:flutter/material.dart';
import 'package:flutter_worksheets/src/features/snackish/features/home/presentation/jp_home.dart';
import 'package:flutter_worksheets/src/features/snackish/features/splash/presentation/widgets/glass_rect.dart';
import 'package:flutter_worksheets/src/themes/styles.dart';

class StartGlassCard extends StatelessWidget {
  const StartGlassCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
        GlassRect(key: super.key, width: 376, height: 230)]),
      SizedBox(width: double.infinity, child: 
        Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: [
          Container(width: 360, height: 230, padding: EdgeInsets.all(28), child: 
            Column(spacing: 4, children: [
              Text('Feeling Snackish Today?', style: TextStyle(color: Colors.white, fontSize: 23, fontFamily: 'Inter', fontWeight: FontWeight.w900, height: 1.25, letterSpacing: 0.1, shadows: [fontShadow])),
              Padding(padding: EdgeInsets.all(4), child: Text('Explore Angi’s most popular snack selection and get instantly happy.', textAlign: TextAlign.center, style: TextStyle(color: const Color(0x99EBEBF5), fontFamily: "SF Pro Display", fontSize: 14, fontWeight: FontWeight.w500, height: 1.38, letterSpacing: -0.08, shadows: [fontShadow]))),
              SizedBox(height: 26),
              GestureDetector(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => JPHomePage())), 
                child: 
                  Container(width: 220, height: 56, decoration: pinkButtonDecoration, child: 
                    Center(child: Text('Order Now', style: TextStyle(color: Colors.white, fontSize: 19, fontFamily: 'Inter', 
                      fontWeight: FontWeight.w700, height: 1.35, letterSpacing: -0.1, shadows: [fontShadowButton]))))
                  //
                  // // Experimentierbereich für Borders/Gradients/Shadows:
                  // 
                  // Container(width: 220, height: 56, decoration: BoxDecoration(
                  //   border: Border.all(width: 2, color: Colors.yellow, /*strokeAlign: 0*/), 
                  //   backgroundBlendMode: BlendMode.lighten, 
                  //   borderRadius: BorderRadius.circular(12), 
                  //   boxShadow: [BoxShadow(color: Colors.blue.withAlpha(0xcf), 
                  //     blurStyle: BlurStyle.outer, blurRadius: 16, spreadRadius: 0, offset: Offset(0, 0))],
                  //   shape: BoxShape.rectangle, gradient: goldGradient,
                  //   color: Colors.black, /* gradient: buttonBlueViolet */
                  //   //  child: Center(child: Text("Hallo", style: gHeader.copyWith(fontSize: 30))
                  //   )
                  // )
                  //
              )
            ]))
          ]))
    ]);
  }
} 
