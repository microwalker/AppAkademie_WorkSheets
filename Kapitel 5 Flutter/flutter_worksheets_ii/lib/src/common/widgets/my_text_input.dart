import 'package:flutter/material.dart';

class MyTextInput extends StatefulWidget {
  const MyTextInput({super.key, this.onSubmitted});
  
  final Function(List<String>)? onSubmitted;

  @override
  State<MyTextInput> createState() => _MyTextInputState();
}

class _MyTextInputState extends State<MyTextInput> {
  List<String> texte = ["", ""];
  
  @override
  Widget build(BuildContext context) {
    return Column(spacing: 16,
      children: [
        SizedBox(width: 300,
          child: TextField(
            onSubmitted: (value) { texte[0] = value; widget.onSubmitted!(texte); } , 
            style: TextStyle(
              color: Colors.limeAccent, fontWeight: FontWeight.bold),
            decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.elliptical(16, 16))), 
            labelText: "Gib was ein!", filled: true, fillColor: Colors.teal, hintText: "...muss auch keinen Sinn ergeben!")),
        ),
        SizedBox(width: 280,
          child: TextField(onSubmitted: (value) { texte[1] = value; widget.onSubmitted!(texte); } , style: TextStyle(color: Colors.limeAccent, fontWeight: FontWeight.bold),
            decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.elliptical(16, 16))), 
            labelText: "Gib noch was ein!", filled: true, fillColor: Colors.teal, hintText: "...sinnlos, oder!")),
        ),

      ],
    );
  }
}

