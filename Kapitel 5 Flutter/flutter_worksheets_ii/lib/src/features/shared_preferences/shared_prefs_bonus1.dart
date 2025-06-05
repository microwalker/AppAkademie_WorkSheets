import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesExercise extends StatefulWidget {
  const SharedPreferencesExercise({super.key});

  @override
  State<SharedPreferencesExercise> createState() => _SharedPreferencesExerciseState();
}

class _SharedPreferencesExerciseState extends State<SharedPreferencesExercise> {
  late SharedPreferences prefs;
  TextEditingController controller = TextEditingController();
  bool isReady = false;
  Color? bgColor;

  @override
  void initState() {
    super.initState();

    bgColor = Color(Random().nextInt(0x3f3f3f) | 0xffc0c0c0);
    initPreferences().then((value) {
      setState(() {
        controller.text = prefs.getString("ws_sp_name") ?? "";
        isReady = controller.text.isNotEmpty;
      }); 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: bgColor, 
      appBar: AppBar(backgroundColor: Colors.orangeAccent, title: Text("Shared Preferences")),
      body: Padding(padding: const EdgeInsets.all(12.0), child: 
        Column(mainAxisAlignment: MainAxisAlignment.center, spacing: 16, children: [
          TextField(controller: controller, onChanged: (value) => setState(() => isReady = false), decoration: InputDecoration(label: Text("Username"))),
          ElevatedButton.icon(onPressed: () async => prefs.setString("ws_sp_name", controller.text).then((value) => setState(() => isReady = true )), 
            label: Text("Speichern"), icon: isReady ? Icon(Icons.circle, color: Colors.green) : Icon(Icons.circle, color: Colors.red), 
            iconAlignment: IconAlignment.end),
          SizedBox(height: 60),
          // ElevatedButton(onPressed: () => initState(), child: Text("Reload Page"))
        ]),
      ),
    );
  }

  Future<void> initPreferences() async {
    // await Future.delayed(Duration(seconds: 3));
    prefs = await SharedPreferences.getInstance();
  }
}