import 'package:flutter/material.dart';
import 'package:flutter_worksheets/src/data/jp_app_data.dart';
import 'package:flutter_worksheets/src/features/snackish/features/home/presentation/widgets/food_details.dart';
import 'package:flutter_worksheets/src/features/snackish/features/splash/presentation/widgets/glass_rect.dart';
import 'package:flutter_worksheets/src/themes/jp_app_styles.dart';


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
            GlassRect(width: width - 60, height: 330)),
          Positioned(top: 286, left: 30, child: 
            FoodDetails(food: widget.food)),
          Positioned(right: 12, top: 112, child: 
            IconButton.outlined(icon: 
              Icon(Icons.close, size: 18, color: gSubText.color), padding: EdgeInsets.all(4), constraints: BoxConstraints(maxHeight: 32, maxWidth: 32), 
                style: IconButton.styleFrom(backgroundColor: Color(0x17ffffff)), onPressed: () => Navigator.pop(context))),
          Positioned(bottom: 48, left: 30, width: width - 60, child: 
            Column(spacing: 24, children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  SegmentedButton<FoodSizes>(segments: [for(FoodSizes s in widget.food.sizes) ButtonSegment(value: s, label: Text(s.name.toString()))], 
                    selected: {size},
                    onSelectionChanged: (p0) => setState(() => size = p0.single ), 
                    showSelectedIcon: false, multiSelectionEnabled: false,
                    style: SegmentedButton.styleFrom(backgroundColor: Color(0x3f767680), padding: EdgeInsets.all(4), foregroundColor: gSubText.color,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(style: BorderStyle.solid, 
                      color: Color(0x3f767680))), side: BorderSide(width: 3, color: Color(0x3f767680)),
                      selectedBackgroundColor: Color(0xff636366), 
                      selectedForegroundColor: gHeader.color))]),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  IconButton.outlined(onPressed: () { setState(() { if(amount > 1) amount--; }); }, icon: Icon(Icons.remove, size: 20, color: gSubText.color), 
                    padding: EdgeInsets.all(2), constraints: BoxConstraints(maxHeight: 32, maxWidth: 32), style: IconButton.styleFrom(backgroundColor: Color(0x17ffffff)),),
                  Text("$amount", style: gSubText.copyWith(color: gHeader.color)),
                  IconButton.outlined(onPressed: () {setState(() { if(amount < 99) amount++; });}, icon: Icon(Icons.add, size: 20, color: gSubText.color), 
                    padding: EdgeInsets.all(2), constraints: BoxConstraints(maxHeight: 32, maxWidth: 32), style: IconButton.styleFrom(backgroundColor: Color(0x17ffffff)),),
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
