import 'package:flutter/material.dart';
import 'package:flutter_worksheets/src/features/gallery/presentation/gallery_about_page.dart';
import 'package:flutter_worksheets/src/features/gallery/presentation/api_gallery/api_gallery_page_widget.dart';
import 'package:flutter_worksheets/src/features/gallery/presentation/mock_gallery/gallery_page_widget.dart';
import 'package:flutter_worksheets/src/themes/styles.dart';

class GalleryMainWidget extends StatefulWidget {

  const GalleryMainWidget({super.key});

  @override
  State<GalleryMainWidget> createState() => _GalleryMainWidgetState();
}

class _GalleryMainWidgetState extends State<GalleryMainWidget> {
  int _pIndex = 0;
  int _galleryCols = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff0f0ff),
      appBar: AppBar(title: Text("Bildergalerie"), centerTitle: true, titleTextStyle: carterBlue24, backgroundColor: Color(0xffe0e0ff), elevation: 8, shadowColor: Color(0xff8080ff),
        actions: [ if(_pIndex < 2) IconButton(onPressed: () => setState(() => _galleryCols = _galleryCols == 2 ? 3 : 2),  
          icon: Icon(_galleryCols == 2 ? Icons.view_column_outlined : Icons.grid_view), color: Color(0xff4040ff))]),
      bottomNavigationBar: NavigationBar(
        labelTextStyle: WidgetStatePropertyAll(carterBlue11), 
        backgroundColor: Color(0xffe0e0ff), elevation: 8, shadowColor: Color(0xff8080ff), indicatorColor: Color(0xffb0b0e0), 
        onDestinationSelected: (value) => setState(() => _pIndex = value ), 
        selectedIndex: _pIndex,
        destinations: [ 
          NavigationDestination(icon: Icon(Icons.image_rounded), tooltip: "Vorgegebene Bilder", label: "Images"),
          NavigationDestination(icon: Icon(Icons.cloud_download), tooltip: "Zufällige Bilder von Picsum", label: "Api Images"),
          NavigationDestination(icon: Icon(Icons.person), tooltip: "Über Carsten", label: "About Me")]), 
      body: Padding(padding: EdgeInsets.all(8), 
        child: <Widget>[GalleryPageWidget(cols: _galleryCols), ApiGalleryPageWidget(cols: _galleryCols), AboutMePageWidget()][_pIndex])
    );
  }
}

