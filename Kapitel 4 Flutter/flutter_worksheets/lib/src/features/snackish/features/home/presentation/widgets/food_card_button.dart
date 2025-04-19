import 'package:flutter/material.dart';
import 'package:flutter_worksheets/src/themes/styles.dart';

class FoodCardButton extends StatelessWidget {
  const FoodCardButton({super.key});

  @override
  Widget build(BuildContext context) {
    return // Container(width: 112, height: 48, decoration: violetButtonDecoration, child: 
      Container(width: 112, height: 46, decoration: ShapeDecoration(gradient: buttonBlueViolet, 
        shape: RoundedRectangleBorder(side: BorderSide(width: 2, color: Color(0x7fbb8de1)), borderRadius: BorderRadius.circular(12)) , 
        shadows: [BoxShadow(color: Color(0x7FEA71C5), blurRadius: 24, offset: Offset(0, 6), spreadRadius: 0), 
          BoxShadow(color: Color(0xfffface4), blurRadius: 8, blurStyle: BlurStyle.inner)]), 
        child: Center(child: Text('Add to order', style: gSubText.copyWith(color: Colors.white))) // )
    );
    
    // Container(width: 112, height: 48, padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 3), clipBehavior: Clip.antiAlias,
    //   decoration: ShapeDecoration(gradient: LinearGradient(begin: Alignment(0.50, -0.23), end: Alignment(0.50, 1.00), colors: [const Color(0xFFFDC7F0), const Color(0x00ED92D7)]),
    //   shape: RoundedRectangleBorder(side: BorderSide(width: 1), borderRadius: BorderRadius.circular(12)), 
    //   shadows: [BoxShadow(color: Color(0x7FEA71C5), blurRadius: 90, offset: Offset(0, 12), spreadRadius: 0)]),
    //   child: 
    //     Row(mainAxisAlignment: MainAxisAlignment.center, 
    //       children: [
    //         Center(child: Text('Add to order', style: gSubText.copyWith(color: Colors.white)))]),
    //   );
    }
}