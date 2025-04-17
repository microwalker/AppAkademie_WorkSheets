import 'package:flutter/material.dart';
import 'package:flutter_worksheets/src/data/gallery_data.dart';
import 'package:flutter_worksheets/src/themes/styles.dart';

class ImageCardWidget extends StatefulWidget {
  final GalleryItem item;
  final Function(GalleryItem item)? onTap;

  const ImageCardWidget({super.key, required this.item, this.onTap});

  @override
  State<ImageCardWidget> createState() => _ImageCardWidgetState();
}

class _ImageCardWidgetState extends State<ImageCardWidget> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(elevation: 8, shadowColor: Color(0xff000080), color: Color(0xffe0e0ff), 
        child: Padding(padding: EdgeInsets.all(4), 
          child: Column(children: [Expanded(
            child: ClipRRect(borderRadius: BorderRadius.all(Radius.circular(12)), 
              child: Image.asset(width: double.infinity, widget.item.imagePath, fit: BoxFit.cover))),
            Padding(padding: EdgeInsets.all(16), 
              child: Text(widget.item.imageTitle, style: carterBlue14, maxLines: 1, overflow: TextOverflow.fade, softWrap: false ))]))),
      onTap: () => widget.onTap!(widget.item));
  }
}
