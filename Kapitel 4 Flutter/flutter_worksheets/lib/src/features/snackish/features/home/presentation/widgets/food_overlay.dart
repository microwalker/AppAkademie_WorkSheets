import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_worksheets/src/data/jp_app_data.dart';
import 'package:flutter_worksheets/src/features/snackish/features/splash/presentation/widgets/glass_rect.dart';
import 'package:flutter_worksheets/src/themes/styles.dart';


class FoodOverlay extends StatefulWidget {
  final Food food;

  const FoodOverlay({super.key, required this.food});

  @override
  State<FoodOverlay> createState() => _FoodOverlayState();
}

class _FoodOverlayState extends State<FoodOverlay> {
  FoodSizes size = FoodSizes.Large;
  int amount = 1;

  @override
  void initState() {
    size = widget.food.sizes.last;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;

    return 
      Scaffold(backgroundColor: Color(0x00ffffff), body:  
        Stack(fit: StackFit.expand, children: [
          Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            Container(width: width, height: height -160, // - 220, // margin: EdgeInsets.only(top: 90),
              decoration: BoxDecoration(gradient: LinearGradient(colors: [Color(0xff437f97), Color(0xff2f2b22)],
              end: Alignment(0, 0.3), begin: Alignment(0, 3.3), stops: [0, 1]),  
              borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24))), 
              // child: Column(children: [Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              //   CloseButton( onPressed: () => Navigator.pop(context))],)],)
              )]),
          Positioned(top: -20, left: (width - 400)/2, child: 
            Image(image: AssetImage(widget.food.imageUrl), width: 400, alignment: Alignment.topCenter)),
          Positioned(top: 286, left: 30, child: 
            GlassRect(width: 370, height: 330)),
          Positioned(top: 286, left: 30, child: 
            FoodDetails(food: widget.food)),
          Positioned(right: 12, top: 112, child: 
            IconButton.outlined(icon: 
              Icon(Icons.close, size: 18, color: gSubText.color), padding: EdgeInsets.all(4), constraints: BoxConstraints(maxHeight: 32, maxWidth: 32), 
                style: IconButton.styleFrom(backgroundColor: Color(0x17ffffff)), onPressed: () => Navigator.pop(context))),
          Positioned(bottom: 48, left: 30, width: width - 60, child: 
            Column(spacing: 24, children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Row(children: [
                  SegmentedButton<FoodSizes>(segments: [for(FoodSizes s in widget.food.sizes) ButtonSegment(value: s, label: Text(s.name.toString()))], 
                    selected: {size},
                    onSelectionChanged: (p0) => setState(() => size = p0.single ), 
                    showSelectedIcon: false, multiSelectionEnabled: false,
                    style: SegmentedButton.styleFrom(backgroundColor: Color(0x3f767680), padding: EdgeInsets.all(4), foregroundColor: gSubText.color,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(style: BorderStyle.solid, 
                      color: Color(0x3f767680))), side: BorderSide(width: 3, color: Color(0x3f767680)),
                      selectedBackgroundColor: Color(0xff636366), 
                      selectedForegroundColor: gHeader.color))]),
                Row(children: [
                  IconButton.outlined(onPressed: () { setState(() { if(amount > 1) amount--; }); }, icon: Icon(Icons.remove, size: 20, color: gSubText.color), 
                    padding: EdgeInsets.all(2), constraints: BoxConstraints(maxHeight: 32, maxWidth: 32), 
                    style: IconButton.styleFrom(backgroundColor: Color(0x17ffffff)),),
                  Text("$amount", style: gSubText.copyWith(color: gHeader.color)),
                  IconButton.outlined(onPressed: () {setState(() { if(amount < 99) amount++; });}, icon: Icon(Icons.add, size: 20, color: gSubText.color), 
                    padding: EdgeInsets.all(2), constraints: BoxConstraints(maxHeight: 32, maxWidth: 32), 
                    style: IconButton.styleFrom(backgroundColor: Color(0x17ffffff)),),
                ]),
              ]),
              GestureDetector(onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(backgroundColor: Colors.pink.withAlpha(0x1f), duration: Duration(milliseconds: 500), content: 
                  Center(child: Text("Zur Bestellung hinzugefügt!", style: gHeader,)))),
                    child: Container(height: 48, decoration: pinkButtonDecoration, child: 
                      Center(child: Row(mainAxisAlignment: MainAxisAlignment.center, spacing: 4, children: [
                        Text('Add to order for', style: gHeader), 
                        Image.asset("assets/jp_app/details/currency_a.png", height: 18), 
                        Text((widget.food.prices[widget.food.sizes.indexOf(size)] * amount).toStringAsFixed(2), style: gHeader)])),
                    ))
              ],
            ))
        ]
            ),
      );
  }
}

class FoodDetails extends StatelessWidget {
  const FoodDetails({
    super.key,
    required this.food,
  });

  final Food food;

  @override
  Widget build(BuildContext context) {
    return Container(width: 360, padding: EdgeInsets.all(20), child: 
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

class ReviewBox extends StatelessWidget {
  final double reviewAVG;
  
  const ReviewBox({
    super.key, required this.reviewAVG,
  });

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, spacing: 8, children: [
      Text("Reviews", style: gFineText.copyWith(fontWeight: FontWeight.w600)),
      Row(children: [ 
        for(int i=0;i<5;i++) Icon(reviewAVG.round() > i ? Icons.star : Icons.star_border_outlined, color: gSubText.color, size: 16), 
        Padding(padding: const EdgeInsets.only(left: 12.0), child: 
        Text(reviewAVG.toStringAsFixed(1), style: gHeader.copyWith(fontSize: 11, color: gFineText.color)),
      )])
    ]);
  }
}

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