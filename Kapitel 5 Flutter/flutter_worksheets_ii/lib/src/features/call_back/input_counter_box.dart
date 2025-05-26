import 'dart:math';

import 'package:flutter/material.dart';

class InputCounterBox extends StatefulWidget {
  final Color? backgroundColor;
  final void Function(String value)? onChanged;
  final TextEditingController? controller;

  const InputCounterBox({super.key, this.onChanged, this.backgroundColor, this.controller});

  @override
  State<InputCounterBox> createState() => _InputCounterBoxState();

  Color getRandomColor() => Color(Random().nextInt(0x7f7f7f) | 0xff808080); 
}

class _InputCounterBoxState extends State<InputCounterBox> {
  int _length = 0;
  Color? color;

  @override
  void initState() {
    super.initState();
    color = widget.backgroundColor ?? widget.getRandomColor();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: widget.controller,
              onChanged: (text) {
                setState(() {
                  _length = text.length;
                  widget.onChanged?.call(text);
                });
              },
              decoration: InputDecoration(
                hintText: 'Text eingeben',
                border: OutlineInputBorder(),
              ),
            ),
            Text('Länge: $_length'),
          ],
        ),
      ),
    );
  }
}
