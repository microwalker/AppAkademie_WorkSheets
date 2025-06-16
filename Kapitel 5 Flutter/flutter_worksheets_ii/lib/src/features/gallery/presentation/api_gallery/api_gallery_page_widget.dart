import 'dart:math';

import 'package:flutter/material.dart';
import '../../../../data/gallery_data.dart';
import 'api_details_page_widget.dart';
import 'widgets/api_pic_card_widget.dart';

class ApiGalleryPageWidget extends StatefulWidget {
  final int cols;

  const ApiGalleryPageWidget({super.key, this.cols = 2});

  @override
  State<ApiGalleryPageWidget> createState() => _ApiGalleryPageWidgetState();
}

class _ApiGalleryPageWidgetState extends State<ApiGalleryPageWidget> {
  int page = 1;
  late Future<List<PicItem>> futurePicList; 

  @override
  void initState() {
    super.initState();
    page = Random().nextInt(20);
    futurePicList = getPicList(page: page, limit: 50);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(onRefresh: () async => setState(() {
        page = Random().nextInt(20);
        futurePicList = getPicList(page: page, limit: 50); }),
      child: FutureBuilder<List<PicItem>>(
        future: futurePicList,
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            return GridView.builder(padding: EdgeInsets.all(8),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: widget.cols),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Hero(tag: snapshot.data![index].id, child: ApiImageCardWidget(item: snapshot.data![index], onTap: (item) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Hero(tag: item.id, child: ApiGalleryDetailsPageWidget(item: item)))); 
                }));
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        }),
    );
  }
}