import 'package:flutter/material.dart';
import 'package:flutter_worksheets/src/data/jp_app_data.dart';
import 'package:flutter_worksheets/src/features/snackish/features/splash/presentation/widgets/glass_rect.dart';
import 'package:flutter_worksheets/src/themes/styles.dart';

class FoodOverlay extends StatelessWidget {
  final Food food;

  const FoodOverlay({super.key, required this.food});

  @override
  Widget build(BuildContext context) {
    return Material(type: MaterialType.transparency, child:
      Stack(fit: StackFit.expand, children: [
        Column(children: [
          Expanded(child: SizedBox(width: double.infinity)),
          Container(width: double.infinity, height: 749, margin: EdgeInsets.only(top:90),
            decoration: BoxDecoration(gradient: LinearGradient(colors: [Color(0xff437f97), Color(0xff2f2b22)],
            end: Alignment(0, 0.3), begin: Alignment(0, 3.3), stops: [0, 1]),  
            borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24))), 
            child: Column(children: [Row(mainAxisAlignment: MainAxisAlignment.end, children: [CloseButton( onPressed: () => Navigator.pop(context))],)],))]),
        Positioned(top: -20, child: Image(image: AssetImage(food.imageUrl), width: 450)),
        Positioned(top: 330, left: 30, child: GlassRect(width: 370, height: 320)),
        Positioned(top: 330, left: 30, child: Container(width: 360, padding: EdgeInsets.all(20), child: 
          Column(crossAxisAlignment: CrossAxisAlignment.center, spacing: 4,  children: [
            Row(mainAxisAlignment: MainAxisAlignment.end,spacing: 3, children: [
              Icon(Icons.favorite_border_outlined, size: 18, color: gFineText.color), 
              Text(food.reviewCount.toString(), style: gFineText.copyWith(fontSize: 16))]),
            Text(food.name, style: gHeader.copyWith(fontSize: 22)), 
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(food.description, style: gFineText.copyWith(fontSize: 14), maxLines: 4, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center,),
            )
          ]),  
        )),
        CloseButton( onPressed: () => Navigator.pop(context))
      ]
    ));
  }
}