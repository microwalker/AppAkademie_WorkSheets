import 'package:flutter/material.dart';

import '../../../../../data/gallery_data.dart';
import '../../../../../themes/styles.dart';

class ApiImageCardWidget extends StatefulWidget {
  final PicItem item;
  final Function(PicItem item)? onTap;

  const ApiImageCardWidget({super.key, required this.item, this.onTap});

  @override
  State<ApiImageCardWidget> createState() => _ApiImageCardWidgetState();
}

class _ApiImageCardWidgetState extends State<ApiImageCardWidget> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(elevation: 8, shadowColor: Color(0xff000080), color: Color(0xffe0e0ff), 
        child: Padding(padding: EdgeInsets.all(4), 
          child: Column(children: [Expanded(
            child: ClipRRect(borderRadius: BorderRadius.all(Radius.circular(12)), 
              child: Image.network(widget.item.downloadUrl, width: double.infinity, fit: BoxFit.cover))),
            Center(heightFactor: 0.5, child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text("Bild #${widget.item.id}", style: carterBlue14, maxLines: 1, overflow: TextOverflow.fade, softWrap: false ),
            ))]))),
      onTap: () => widget.onTap!(widget.item));
  }
}
