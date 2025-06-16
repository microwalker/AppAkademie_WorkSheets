import 'package:flutter/material.dart';
import 'src/features/gallery/presentation/gallery_main_page.dart';

void main() {
  runApp(const MaterialApp(title: "P20 API Bildergalerie", debugShowCheckedModeBanner: false, 
      home: Ws543p20()));
}

class Ws543p20 extends StatelessWidget {
  const Ws543p20({super.key});

  @override
  Widget build(BuildContext context) {
    return GalleryMainWidget();
  }
}
