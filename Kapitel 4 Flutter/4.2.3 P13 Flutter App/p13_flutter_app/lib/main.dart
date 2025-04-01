import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: "MainApp", debugShowCheckedModeBanner: kDebugMode,
      home: Scaffold(
        appBar: AppBar(title: Text("Flutter, Flatter..."), leading: IconButton.outlined(onPressed: null, icon: Icon(Icons.bathroom_outlined, color: Color.fromARGB(255, 213, 207, 22),)), centerTitle: true, backgroundColor: Color.fromARGB(197, 13, 86, 85),),
        floatingActionButton: FloatingActionButton.extended(onPressed: () => Dialog(child: Text("Dialog")), icon: Icon(Icons.help_center_rounded), label: Text("What?")),
        bottomNavigationBar: BottomNavigationBar(backgroundColor: Colors.deepOrangeAccent[200], currentIndex: 1, type: BottomNavigationBarType.fixed, items: [
          BottomNavigationBarItem(label: "Item 1", icon: Icon(Icons.access_alarm, color: Colors.tealAccent)), 
          BottomNavigationBarItem(label: "Item 2", icon: Icon(Icons.access_time, color: Colors.tealAccent)), 
          BottomNavigationBarItem(label: "Item 3", icon: Icon(Icons.ac_unit, color: Colors.tealAccent))]),
        drawer: Drawer(backgroundColor: Colors.blueAccent[600], elevation: 80, clipBehavior: Clip.hardEdge , child: Text("Inside Drawer")),
        drawerDragStartBehavior: DragStartBehavior.start,
        persistentFooterButtons: [IconButton.outlined(onPressed: null, icon: Icon(Icons.adb))],
        body: Center(
          child: Column(children: [
              Text("Golden times for Developers!", 
                style: TextStyle(fontFamily: "CupertinoSystemDisplay", fontSize: 24, fontStyle: FontStyle.italic, 
                  fontWeight: FontWeight.w500, color: Color.fromARGB(255, 66, 60, 177))),
              Checkbox(value: false, onChanged: null),
              Switch(value: true, onChanged: null),
              TextButton(onPressed: null, child: Text("Ich bin ein TextButton")),
              FilledButton(onPressed: null, child: Text("Ich ein FilledButton")),
              FilledButton.icon(onPressed: null, label: Text(" Mit Icon! Und Filled!"), icon: Icon(Icons.face_sharp, size: 36, color: Color.fromARGB(255, 173, 13, 13))),
              Spacer(flex: 1),
              ListBody(children: [ListTile(leading: Icon(Icons.face_5), title: Title(color: Color.fromARGB(255, 20, 65, 5), child: Text("Listenelement 1")), subtitle: Text("Weil ich der erste in der Liste bin!")), ListTile(leading: Icon(Icons.face_2), title: Title(color: Color.fromARGB(255, 20, 65, 5), child: Text("Listenelement 2")), subtitle: Text("Weil ich die zweite in der Liste bin!"))],),
              // ListView(children: [ListTile(leading: Icon(Icons.face_5), title: Title(color: Color.fromARGB(255, 20, 65, 5), child: Text("Listenelement 1")), subtitle: Text("Weil ich der erste in der Liste bin!")), ListTile(leading: Icon(Icons.face_2), title: Title(color: Color.fromARGB(255, 20, 65, 5), child: Text("Listenelement 2")), subtitle: Text("Weil ich die zweite in der Liste bin!"))],),
              Divider(thickness: 3),
              MyTransform(),
              Spacer(flex: 1),
              IconButton.outlined(onPressed: null, icon: Icon(Icons.shopping_bag_outlined, color: Color.fromARGB(160, 160, 13, 13))),
              Spacer(flex: 2)]
          ),
        ), 
        endDrawer: EndDrawerButton(),
        backgroundColor: const Color.fromARGB(243, 165, 206, 175), 
      )
    );
  }
}

class MyTransform extends StatefulWidget { 
  const MyTransform({super.key}); 
  
  @override
  State<StatefulWidget> createState() => _MyTransformState();
}

class _MyTransformState extends State<MyTransform> {
  int _angle = 0;

  @override
  Widget build(BuildContext context) {
    return 
        Column(spacing: 8, children: [
        Transform(transform: Matrix4.rotationY((_angle * (math.pi/180))), origin: Offset(150, 24), child: Image(image: NetworkImage('https://files.readme.io/31ab3f6-small-CoinGecko_API_Documentation_-_SuperGecko.png'), 
                fit: BoxFit.contain, alignment: Alignment.topCenter, width: 300)),
        Slider(value: _angle.toDouble(), onChanged: (value) => changeRotation(value), divisions: 64, thumbColor: Colors.green, label: "Drehung in Grad: $_angle", min: 0, max: 360, padding: EdgeInsets.fromLTRB(48, 8, 48, 8)),  
      // Slider(value: _angle.toDouble(), onChanged: (value) => changeRotation(value), divisions: 180, thumbColor: Colors.green, label: "Drehung in Grad: $_angle", min: 0, max: 360, padding: EdgeInsets.fromLTRB(48, 8, 48, 8)),      
        Text("Drehung aktuell bei $_angle Grad")]);
  }

  void changeRotation(double value) => setState(() {
    _angle = value.toInt();
  });
}

