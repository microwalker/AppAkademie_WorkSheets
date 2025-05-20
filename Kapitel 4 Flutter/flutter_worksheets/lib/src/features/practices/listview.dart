import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(title: "Hello World", home: lv1()));
}

class lv1 extends StatefulWidget {
  const lv1({super.key});

  @override
  State<lv1> createState() => _lv1State();
}

class _lv1State extends State<lv1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mein schöner Screen"), backgroundColor: Colors.orange),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(padding: EdgeInsets.all(8), itemCount: 16, itemBuilder: (context, index) {
                return Card( margin: EdgeInsets.all(8), child:  Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("Item $index"),
                ));
              },),
            ),
            ElevatedButton(onPressed: () {}, style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.indigo)), child: Text("Show Less", style: TextStyle(color: Colors.white),))
          ],
        ),
      ),
    );}}
 