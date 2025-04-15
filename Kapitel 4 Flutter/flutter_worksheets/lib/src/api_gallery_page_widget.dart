import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_worksheets/src/api_details_page_widget.dart';
import 'package:flutter_worksheets/src/api_pic_card_widget.dart';
import 'package:flutter_worksheets/src/gallery_data.dart';

class ApiGalleryPageWidget extends StatefulWidget {
  final int cols;

  const ApiGalleryPageWidget({super.key, this.cols = 2});

  @override
  State<ApiGalleryPageWidget> createState() => _ApiGalleryPageWidgetState();
}

class _ApiGalleryPageWidgetState extends State<ApiGalleryPageWidget> {
  int page = 1;

  @override
  void initState() {
    page = Random().nextInt(20);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PicItem>>(
      future: getPicList(page: page, limit: 50),
      builder: (context, snapshot) {
        if (snapshot.hasData &&
            snapshot.connectionState == ConnectionState.done) {
          return GridView.builder(padding: EdgeInsets.all(8),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: widget.cols),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return ApiImageCardWidget(item: snapshot.data![index], onTap: (item) {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ApiGalleryDetailsPageWidget(item: item))); 
              });
            },
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      });
  }
}