import 'package:flutter/material.dart';
import 'package:flutter_worksheets/src/data/gallery_data.dart';
import 'package:flutter_worksheets/src/themes/styles.dart';

class GalleryDetailsPageWidget extends StatelessWidget {
  final GalleryItem item;

  const GalleryDetailsPageWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff0f0ff),
      appBar: AppBar(title: Text("Details zum Bild"), titleTextStyle: carterBlue24, backgroundColor: Color(0xffe0e0ff), elevation: 8, shadowColor: Color(0xff8080ff)),
      body: Padding(padding: EdgeInsets.all(16), child: SingleChildScrollView(
        child: Column(spacing: 12, children: [ 
          ClipRRect(borderRadius: BorderRadius.all(Radius.circular(12)), child: InteractiveViewer(maxScale: 4, minScale: 0.5, scaleEnabled: true, panEnabled: true, child: Image.asset(item.imagePath))), 
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [Text(item.imageDate)]),
          Text(item.imageTitle, style: carterBlue24 /* TextStyle(fontSize: 18, color: Color(0xff000040)) */), 
          Text(item.imageDescription, style: carterBlue18 /* TextStyle(fontSize: 18, color: Color(0xff000040)) */), 
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [TextButton(onPressed: () => Navigator.pop(context), child: Text("...Zurück"))],)
          ]),
      )));
  }
}