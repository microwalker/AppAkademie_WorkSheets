import 'package:flutter/material.dart';
import 'package:flutter_worksheets/src/features/snackish/features/splash/presentation/widgets/order_now_box.dart';
import 'package:flutter_worksheets/src/features/snackish/features/splash/presentation/widgets/start_glass_card.dart';

class JPSplashPage extends StatelessWidget {
  const JPSplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(fit: StackFit.expand, children: [
        DecoratedBox(decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/jp_app/hintergründe/bg_startscreen.png"), fit: BoxFit.cover))),
        // Image.asset("assets/jp_app/hintergründe/bg_startscreen.png", fit: BoxFit.fitHeight),
        Positioned(left: -30, top: 108, child: Image.asset("assets/jp_app/grafiken/cupcake_chick.png", width: 600, fit: BoxFit.fitHeight,)),
        Positioned.fill(top: 372, child: Image.asset("assets/jp_app/details/snack_snack.png", fit: BoxFit.fitWidth)),
        Positioned.fill(top: 612, child: 
          // OrderNowBox(),
          StartGlassCard()
        )
      ],),
    );
  }
}
