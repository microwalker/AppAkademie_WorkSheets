import 'package:flutter/material.dart';
import 'package:flutter_worksheets/src/data/jp_app_data.dart';
import 'package:flutter_worksheets/src/features/snackish/features/home/presentation/widgets/food_card_button.dart';
import 'package:flutter_worksheets/src/features/snackish/features/splash/presentation/widgets/glass_rect.dart';
import 'package:flutter_worksheets/src/themes/styles.dart';

class FoodCard extends StatelessWidget {
  final Food food;
  
  const FoodCard({
    super.key, required this.food,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: 392 /*392 */, height: 270, child: 
      Stack(children: [
        Transform(transform: Matrix4(1,0,0,0, 0,1,0,0, 0,0,1,0, 0,0,0,1)..scale(1.3,1,1)..setEntry(3, 0, 0.0008), child: GlassRect(width: 392, height: 270)),
        Padding(padding: const EdgeInsets.all(20.0),child: 
          Column(crossAxisAlignment: CrossAxisAlignment.start, spacing: 6, children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(food.name, style: gHeader), 
              Row(spacing: 4, children: [Image.asset("assets/jp_app/grafiken/star.png", width: 16, height: 16, fit: BoxFit.fill,), Text(food.reviewAVG.toStringAsFixed(1), style: gSubText,) ])]),
            SizedBox(width: 138, child: Text(food.description, style: gSubText, maxLines: 3, overflow: TextOverflow.ellipsis,)),
            SizedBox(height: 4),
            Row(spacing: 4, children: [Image.asset("assets/jp_app/details/currency_a.png", width: 16, height: 16), Text(food.prices[0].toStringAsFixed(2), style: gHeader)]),
            SizedBox(height: 46),
            
        ],),
      ),
      Positioned(top: 30, left: 136, child: Image.asset(food.imageUrl, width: 260, fit: BoxFit.cover,)),
      Positioned(left: 20, bottom: 62, child: FoodCardButton())
    ],));
  }
}
