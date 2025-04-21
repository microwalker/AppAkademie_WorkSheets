import 'package:flutter/material.dart';
import 'package:flutter_worksheets/src/data/jp_app_data.dart';
import 'package:flutter_worksheets/src/themes/jp_app_styles.dart';

class IngredientsBox extends StatelessWidget {
  final Ingredients ingredients;
  
  const IngredientsBox({
    super.key, required this.ingredients,
  });

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, spacing: 8, children: [
      Text("Ingredients", style: gFineText.copyWith(fontWeight: FontWeight.w600)),
      Row(mainAxisAlignment: MainAxisAlignment.start, spacing: 6, children: [
        if(ingredients.noGluten) Image.asset("assets/jp_app/details/no_gluten.png", height: 20), 
        if(ingredients.noSugar) Image.asset("assets/jp_app/details/no_sugar.png", height: 20), 
        if(ingredients.lowFat) Image.asset("assets/jp_app/details/low_fat.png", height: 20), 
        Image.asset("assets/jp_app/details/kcal.png", height: 20), 
      ],)]);
  }
}