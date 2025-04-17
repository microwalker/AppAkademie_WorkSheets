import 'package:flutter/material.dart';
import 'package:flutter_worksheets/src/data/gallery_data.dart';
import 'package:flutter_worksheets/src/themes/styles.dart';

class ApiGalleryDetailsPageWidget extends StatelessWidget {
  final PicItem item;

  const ApiGalleryDetailsPageWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff0f0ff),
      appBar: AppBar(title: Text("Details zum Bild"), titleTextStyle: carterBlue24, backgroundColor: Color(0xffe0e0ff), elevation: 8, shadowColor: Color(0xff8080ff)),
      body: Stack(fit: StackFit.expand, children: [
        DecoratedBox(decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(item.downloadUrl), fit: BoxFit.cover, opacity: 0.2))),
        Padding(padding: EdgeInsets.all(16), child: SingleChildScrollView(
          child: Column(spacing: 12, children: [ 
            Material(borderRadius: BorderRadius.all(Radius.circular(12)), elevation: 8, shadowColor: Color(0xff4040ff), child: 
              ClipRRect(borderRadius: BorderRadius.all(Radius.circular(12)), child: 
                InteractiveViewer(maxScale: 4, minScale: 0.5, scaleEnabled: true, panEnabled: true, child: 
                  Image.network(item.downloadUrl, semanticLabel: item.url)))), 
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Text("Size: ${item.width} x ${item.height}", style: carterBlue14)]),
            Text("Author: ${item.author}", style: carterBlue24 /* TextStyle(fontSize: 18, color: Color(0xff000040)) */), 
            Text("Url: ${item.url}", style: carterBlue18 /* TextStyle(fontSize: 18, color: Color(0xff000040)) */),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [TextButton(onPressed: () => Navigator.pop(context), child: Text("<<< Zurück", style: carterBlue14))])
            ]))),
        ]),
      );
  }
}