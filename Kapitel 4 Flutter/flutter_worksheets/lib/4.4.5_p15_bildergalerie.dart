import 'package:flutter/material.dart';
import 'package:flutter_worksheets/src/gallery_main_widget.dart';

void main() {
  runApp(Ws445());
}

class Ws445 extends StatelessWidget {
  const Ws445({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: "P15 Bildergalerie", debugShowCheckedModeBanner: false,
      home: GalleryMainWidget());
  }
}
