import 'package:flutter/material.dart';

import 'input_counter_box.dart';

class CbfScreen extends StatefulWidget {

  const CbfScreen({super.key});

  @override
  State<CbfScreen> createState() => _CbfScreenState();
}

class _CbfScreenState extends State<CbfScreen> {
  int totalLength = 0;

  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("5.1.6 Callback Functions"), centerTitle: true, backgroundColor: Colors.teal,),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 16,
          children: [
            InputCounterBox(onChanged: (value) => refreshTotalLength(), controller: controller1,),
            InputCounterBox(onChanged: (value) => refreshTotalLength(), controller: controller2,),
            InputCounterBox(onChanged: (value) => refreshTotalLength(), controller: controller3,),
            Text("Summe aller Längen: $totalLength")
          ],
        ),
      ),
    );
  }

  void refreshTotalLength() {
    setState(() => totalLength = controller1.value.text.length + controller2.text.length + controller3.text.length); 
  }

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();

    super.dispose();
  }
}
