import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_worksheets/src/data/jp_app_data.dart';
import 'jp_home_widgets.dart';
class JPHomePage extends StatelessWidget {

  const JPHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> categoryNames = ["Salty","Sweet","Dumpy","Burpsy","Puky","Icy"];
    return DecoratedBox(decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/jp_app/hintergründe/bg_mainscreen.png"), fit: BoxFit.cover)), child: 
      Scaffold(backgroundColor: Colors.transparent, body:         
        Padding(padding: EdgeInsets.fromLTRB(0, 86, 0, 24), child: 
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(padding: const EdgeInsets.only(left: 18.0), width: 300, height: 80, child: 
              Text("Choose Your Favorite Snack", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900, height: 1.25, letterSpacing: 0.1))), 
            SingleChildScrollView(padding: EdgeInsets.only(left: 18, right: 18), scrollDirection: Axis.horizontal, child: 
              Row(spacing: 8, children: [
                CategoryMenuButton(),
                for(int i = 0; i < categoryNames.length; i++) CategoryButton(label: categoryNames[i], selected: i == 0)
              ])),
            Column(children: [
              Padding(padding: EdgeInsets.only(left: 18, right: 18, top: 40), child: 
                Container(height: 290, width: 392, child: 
                  PageView.builder(scrollDirection: Axis.horizontal, controller: PageController(initialPage: Random().nextInt(foods.length)),
                    itemCount: foods.length,
                    itemBuilder: (context, index) => FoodCard(food: foods[index])),
                ),
              ),
              Container(padding: EdgeInsets.fromLTRB(24, 24, 8, 0), alignment: Alignment.centerLeft, child: 
                Text("We Recommend", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900, height: 1.25, letterSpacing: 0.1))),
              SizedBox(height: 318, child: 
                ListView.separated(scrollDirection: Axis.horizontal, padding: EdgeInsets.all(18), shrinkWrap: true, 
                  itemCount: foods.length, 
                  itemBuilder: (context, index) => SubCard(food: foods[index]), 
                  separatorBuilder: (context, index) => SizedBox(width: 28)))
            ])
          ])
        )
      )
    );
  }
}
