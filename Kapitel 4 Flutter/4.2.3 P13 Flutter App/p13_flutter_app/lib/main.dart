import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final List<Map<String, dynamic>> _listElements = const [
    {"key": "u1", "icon": Icons.face, "title": "User 1", "subtitle": "Der allererste"},
    {"key": "u2", "icon": Icons.face_2, "title": "User 2", "subtitle": "Immerhin die Zweite"},
    {"key": "u3", "icon": Icons.face_3, "title": "User 3", "subtitle": "Naja, wenigstens die Dritte"},
    {"key": "u4", "icon": Icons.face_4, "title": "User 4", "subtitle": "Räbäh... nur Vierter"},
    {"key": "u5", "icon": Icons.face_5, "title": "User 5", "subtitle": "...vorerst Letzter!"}];
  
  String text = "Golden Time for Developers";
  bool? checked = false;
  bool switchState = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: "MainApp", debugShowCheckedModeBanner: kDebugMode,
      home: Scaffold(
        appBar: AppBar(title: Text("Flutter, Flatter..."), leading: IconButton.outlined(onPressed: () {}, icon: Icon(Icons.bathroom_outlined, color: Color.fromARGB(255, 213, 207, 22),)), centerTitle: true, backgroundColor: Color.fromARGB(197, 13, 86, 85),),
        floatingActionButton: FloatingActionButton.extended(onPressed: () { print("Hallo!"); }, icon: Icon(Icons.help_center_rounded), label: Text("What?")),
        bottomNavigationBar: BottomNavigationBar(onTap: (value) { print("Tabbed on $value");}, backgroundColor: Colors.deepOrangeAccent[200], currentIndex: 1, type: BottomNavigationBarType.fixed, items: [
          BottomNavigationBarItem(label: "Item 1", icon: Icon(Icons.access_alarm, color: Colors.tealAccent)), 
          BottomNavigationBarItem(label: "Item 2", icon: Icon(Icons.access_time, color: Colors.tealAccent)), 
          BottomNavigationBarItem(label: "Item 3", icon: Icon(Icons.ac_unit, color: Colors.tealAccent))]),
        drawer: Drawer(backgroundColor: Colors.blueAccent[600], elevation: 80, clipBehavior: Clip.hardEdge , child: Text("Inside Drawer")),
        drawerDragStartBehavior: DragStartBehavior.start,
        persistentFooterButtons: [IconButton.outlined(onPressed: () {},alignment: Alignment.topCenter, icon: Icon(Icons.adb))],
        body: Center(
          child: Column(spacing: 8, children: [
              Text(text, 
                style: TextStyle(fontFamily: "CupertinoSystemDisplay", fontSize: 24, fontStyle: FontStyle.italic, 
                  fontWeight: FontWeight.w500, color: Color.fromARGB(255, 66, 60, 177))),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Checkbox(value: checked, onChanged: (value) => setState(() => checked = value ), tristate: true, side: BorderSide(width: 1.2), splashRadius: 32, shape: StarBorder(innerRadiusRatio: 0.4, pointRounding: 0.5, rotation: 11, points: 6)), 
                Switch(value: switchState, onChanged: (value) => setState(() => switchState = value), thumbIcon: WidgetStatePropertyAll(Icon(Icons.face_sharp))), 
                FilledButton(onPressed: () { }, child: Text("Ich ein FilledButton"))]),
              TextButton(onPressed: () {}, child: Text("Ich bin ein TextButton")),              
              MyTextInput(),
              // FilledButton.icon(onPressed: null, label: Text(" Mit Icon! Und Filled!"), icon: Icon(Icons.face_sharp, size: 36, color: Color.fromARGB(255, 173, 13, 13))),
              SizedBox(height: 250,
                child: ClipRect(clipBehavior: Clip.antiAliasWithSaveLayer, 
                  child: SingleChildScrollView(
                    child: Padding(padding: EdgeInsets.only(left: 16, right: 16),
                      child: ListBody(children: [ for(Map m in _listElements) 
                        ListTile(key: Key(m["key"]), dense: false, onTap: () => onElementTab(m["key"]), hoverColor: Colors.teal, leading: Icon(m["icon"]), title: Title(color: Color.fromARGB(255, 20, 65, 5), child: Text(m["title"])), subtitle: Text(m["subtitle"])) ]),
                        // ListTile(onTap: () {}, hoverColor: Colors.teal, leading: Icon(Icons.face_3), title: Title(color: Color.fromARGB(255, 20, 65, 5), child: Text("Listenelement 1")), subtitle: Text("Weil ich der erste in der Liste bin!")), 
                        // ListTile(onTap: () {}, hoverColor: Colors.teal, leading: Icon(Icons.face_2), title: Title(color: Color.fromARGB(255, 20, 65, 5), child: Text("Listenelement 2")), subtitle: Text("Weil ich die zweite in der Liste bin!"))],),
                    ),
                  ),
                ),
              ),
              // ListView(children: [ListTile(leading: Icon(Icons.face_5), title: Title(color: Color.fromARGB(255, 20, 65, 5), child: Text("Listenelement 1")), subtitle: Text("Weil ich der erste in der Liste bin!")), ListTile(leading: Icon(Icons.face_2), title: Title(color: Color.fromARGB(255, 20, 65, 5), child: Text("Listenelement 2")), subtitle: Text("Weil ich die zweite in der Liste bin!"))],),
              Divider(thickness: 3),
              MyTransform(),
              IconButton.outlined(onPressed: () {}, icon: Icon(Icons.shopping_bag_outlined, color: Color.fromARGB(160, 160, 13, 13))) ]
          ),
        ), 
        endDrawer: EndDrawerButton(),
        backgroundColor: const Color.fromARGB(243, 165, 206, 175), 
      )
    );
  }

  void onElementTab(String key) => print(key);

  void getWidget(Key key) {
    
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

class MyTextInput extends StatefulWidget {
  const MyTextInput({super.key});

  String get text => _MyTextInputState().text;

  @override
  State<MyTextInput> createState() => _MyTextInputState();
}

class _MyTextInputState extends State<MyTextInput> {
  String _text = "";

  String get text => _text;
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(width: 320,
      child: TextField(onSubmitted: (value) => _text = value, style: TextStyle(color: Colors.limeAccent, fontWeight: FontWeight.bold),
        decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.elliptical(16, 16))), 
        labelText: "Gib was ein!", filled: true, fillColor: Colors.teal, hintText: "...muss auch keinen Sinn ergeben!")),
    );
  }
}

