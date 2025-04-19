import 'package:flutter/material.dart';
import 'package:flutter_worksheets/src/data/jp_app_data.dart';
import 'package:flutter_worksheets/src/features/snackish/features/home/presentation/widgets/category_button.dart';
import 'package:flutter_worksheets/src/features/snackish/features/home/presentation/widgets/category_menu_button.dart';
import 'package:flutter_worksheets/src/features/snackish/features/home/presentation/widgets/food_card.dart';
import 'package:flutter_worksheets/src/features/snackish/features/home/presentation/widgets/sub_card.dart';

class JPHomePage extends StatelessWidget {

  const JPHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(fit: StackFit.expand, children: [
        DecoratedBox(decoration: BoxDecoration(image: 
          DecorationImage(image: 
            AssetImage("assets/jp_app/hintergründe/bg_mainscreen.png"), fit: BoxFit.cover))),
        Padding(padding: EdgeInsets.fromLTRB(18, 86, 0, 24), 
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 300, height: 80, child: Text("Choose Your Favorite Snack", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900, height: 1.25, letterSpacing: 0.1))), 
              SingleChildScrollView( scrollDirection: Axis.horizontal, child: Row(spacing: 8, children: [
                CategoryMenuButton(), 
                CategoryButton(label: "Salty", selected: true), 
                CategoryButton(label: "Sweet", selected: false), 
                CategoryButton(label: "Dumpy", selected: false),
                CategoryButton(label: "Burpsy", selected: false),
                CategoryButton(label: "Icy", selected: false)])),
              SizedBox(height: 40),
              Container(height: 270, width: 392,
                child: PageView.builder(scrollDirection: Axis.horizontal,
                  itemCount: foods.length,
                  itemBuilder: (context, index) => FoodCard(food: foods[index])),
              ),
              //FoodCard(food: foods[0]),
              Container(padding: EdgeInsets.fromLTRB(8, 44, 8, 0), child: 
                Text("We Recommend", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900, height: 1.25, letterSpacing: 0.1))),
              Expanded(child: 
                ListView.separated(scrollDirection: Axis.horizontal, padding: EdgeInsets.all(16), 
                  itemCount: foods.length, 
                  itemBuilder: (context, index) => SubCard(food: foods[index]), 
                  separatorBuilder: (context, index) => SizedBox(width: 28)))
            ]))
      ],),
    );
  }
}
