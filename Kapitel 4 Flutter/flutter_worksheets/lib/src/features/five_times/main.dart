import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: FiveTimes()));
}

class FiveTimes extends StatelessWidget {
  const FiveTimes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Five Times"), centerTitle: true),
        body: Center(
          child: Column(spacing: 4, mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(padding: EdgeInsets.all(16), child: Text("Klicke ein Element 5 mal, dann wird die Hintergrundfarbe grün! Klickst Du das selbe Element weitere 5 Male, so wird es wieder zufällig eingefärbt...\n" +
                "Diesen Vorgang kannst Du beliebig oft mit jedem Element in der Liste wiederholen 😊", softWrap: true)),
              ListView.builder(
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (context, index) => FiveTimesItem()
              ),
            ],
          ),
        ),
      );
  }
}

class FiveTimesItem extends StatefulWidget {
  const FiveTimesItem({super.key});

  @override
  State<FiveTimesItem> createState() => _FiveTimesItemState();
}

class _FiveTimesItemState extends State<FiveTimesItem> {
  int counter = 0;
  Color c = Color(Random().nextInt(0x7f7f7f) | 0xff808080);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(elevation: 8, shadowColor: c.withAlpha(128), margin: EdgeInsets.all(12), color: c, 
        child: Padding(padding: EdgeInsets.all(8), child: Center(child: Text("Counter: $counter")))), onTap: () { setState(() {
      counter++; 
      if(counter % 5 == 0) c = counter % 10 == 0 ? Color(Random().nextInt(0x7f7f7f) | 0xff808080) : Colors.green;
    });},);
  }
}
