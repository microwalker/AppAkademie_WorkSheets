import 'package:flutter/material.dart';
import 'package:flutter_worksheets/src/data/jp_app_data.dart';
import 'package:flutter_worksheets/src/features/snackish/features/home/presentation/widgets/ingredients_box.dart';
import 'package:flutter_worksheets/src/features/snackish/features/home/presentation/widgets/review_box.dart';
import 'package:flutter_worksheets/src/themes/jp_app_styles.dart';

class FoodDetails extends StatelessWidget {
  const FoodDetails({
    super.key,
    required this.food,
  });

  final Food food;

  @override
  Widget build(BuildContext context) {
    return Container(width: MediaQuery.sizeOf(context).width - 60, padding: EdgeInsets.all(20), child: 
      Column(crossAxisAlignment: CrossAxisAlignment.center, spacing: 4,  children: [
        Row(mainAxisAlignment: MainAxisAlignment.end,spacing: 3, children: [
          Icon(Icons.favorite_border_outlined, size: 18, color: gFineText.color), 
          Text(food.reviewCount.toString(), style: gFineText.copyWith(fontSize: 16))]),
        Text(food.name, style: gHeader.copyWith(fontSize: 22)), 
        SizedBox(height: 118,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8,6,8,14),
            child: Text(food.description, style: gFineText.copyWith(fontSize: 14), maxLines: 5, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center,),
          ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, spacing: 2, children: [
          Image.asset("assets/jp_app/details/currency_a.png", height: 18),
          Text(food.prices[food.prices.length-1].toStringAsFixed(2), style: gHeader.copyWith(fontSize: 19),)]),
        Padding(padding: EdgeInsets.fromLTRB(0, 6, 0, 6), child: Divider(color: gFineText.color, thickness: 0.5)),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          IngredientsBox(ingredients: food.ingredients), 
          ReviewBox(reviewAVG: food.reviewAVG)],)
      ]),  
    );
  }
}
