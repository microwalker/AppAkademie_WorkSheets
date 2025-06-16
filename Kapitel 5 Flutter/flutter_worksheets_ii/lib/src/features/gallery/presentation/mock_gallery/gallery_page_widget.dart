import 'package:flutter/material.dart';
import '../../../../data/gallery_data.dart';
import 'gallery_details_page_widget.dart';
import 'widgets/image_card_widget.dart';

class GalleryPageWidget extends StatefulWidget {
  final int cols;

  const GalleryPageWidget({super.key, this.cols = 2});

  @override
  State<GalleryPageWidget> createState() => _GalleryPageWidgetState();
}

class _GalleryPageWidgetState extends State<GalleryPageWidget> {

  @override
  void initState() {
    galleryData.shuffle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(padding: EdgeInsets.all(8), 
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: widget.cols), 
        itemCount: galleryData.length,
        itemBuilder: (context, index) => ImageCardWidget(item: galleryData[index], 
          onTap: (item) { Navigator.push(context, MaterialPageRoute(builder: (context) =>  GalleryDetailsPageWidget(item: item))); }));
  }

}