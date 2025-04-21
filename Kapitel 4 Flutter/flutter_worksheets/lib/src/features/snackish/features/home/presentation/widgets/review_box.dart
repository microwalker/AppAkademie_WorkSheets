import 'package:flutter/material.dart';
import 'package:flutter_worksheets/src/themes/jp_app_styles.dart';

class ReviewBox extends StatelessWidget {
  final double reviewAVG;
  
  const ReviewBox({
    super.key, required this.reviewAVG,
  });

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, spacing: 8, children: [
      Text("Reviews", style: gFineText.copyWith(fontWeight: FontWeight.w600)),
      Row(children: [ 
        for(int i=0;i<5;i++) Icon(reviewAVG.round() > i ? Icons.star : Icons.star_border_outlined, color: gSubText.color, size: 16), 
        Padding(padding: const EdgeInsets.only(left: 12.0), child: 
        Text(reviewAVG.toStringAsFixed(1), style: gHeader.copyWith(fontSize: 11, color: gFineText.color)),
      )])
    ]);
  }
}
