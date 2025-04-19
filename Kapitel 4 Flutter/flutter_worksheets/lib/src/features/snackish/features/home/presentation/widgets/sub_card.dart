import 'package:flutter/material.dart';
import 'package:flutter_worksheets/src/data/jp_app_data.dart';
import 'package:flutter_worksheets/src/features/snackish/features/home/presentation/widgets/food_overlay.dart';
import 'package:flutter_worksheets/src/themes/styles.dart';

class SubCard extends StatelessWidget {
  final Food food;

  const SubCard({super.key, required this.food});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: () => showDialog(context: context, builder: (context) => FoodOverlay(food: food)),
      child: Container(width: 200, decoration: subcardDecoration, padding: EdgeInsets.fromLTRB(16, 16, 16, 20), child: 
        Column(spacing: 8, children: [
          Image.asset(food.imageUrl, width: 170, height: 170),
          Expanded(child: 
            Column(spacing: 2, crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [Text(food.name, style: gHeader.copyWith(fontSize: 13.6) )]),
              Text(food.type, style: gFineText, maxLines: 1, overflow: TextOverflow.fade)])),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(spacing: 1, children: [
              Image.asset("assets/jp_app/details/currency_a_light.png", width: 14, height: 14), 
              Text(food.prices[0].toStringAsFixed(2), style: TextStyle(color: gHeader.color))]),
            Row(spacing: 1, children: [
              Icon(Icons.favorite_border_outlined, color: gFineText.color, size: 18), 
              Text(food.reviewCount.toString(), style: TextStyle(color: gFineText.color),)])
          ]),
        ])
      ),
    );
  }
}

