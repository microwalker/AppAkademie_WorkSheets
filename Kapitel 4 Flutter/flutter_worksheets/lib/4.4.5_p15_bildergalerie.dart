import 'package:flutter/material.dart';
import 'package:flutter_worksheets/src/features/gallery/presentation/gallery_main_page.dart';

void main() {
  runApp(const MaterialApp(title: "P15 Bildergalerie", debugShowCheckedModeBanner: false, 
      home: Ws445()));
}

class Ws445 extends StatelessWidget {
  const Ws445({super.key});

  @override
  Widget build(BuildContext context) {
    return GalleryMainWidget();
  }
}
