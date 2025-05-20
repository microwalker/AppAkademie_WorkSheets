import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(title: "Hello World", home: Page1()));
}

class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Text("Hello AppAkademie"), 
        ElevatedButton(onPressed: () {} , child: Text("Go to next page")),
        Spacer(),
        IconButton(onPressed: () {}, icon: Icon(Icons.star, color: Colors.green)),
        Row(children: [
          IconButton(onPressed: () {}, icon: Icon(Icons.circle)), 
          IconButton(onPressed: () {}, icon: Icon(Icons.polyline))
        ]),
        IconButton(onPressed: () {}, icon: Icon(Icons.square))
      ]),
         
      );
  }
}
