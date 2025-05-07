
import 'package:flutter_worksheets/src/common/widgets/my_text_input.dart';
import 'package:flutter_worksheets/src/common/widgets/my_transform.dart';

import 'src/themes/styles.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: Ws423()));
}

class Ws423 extends StatefulWidget {

  const Ws423({super.key});

  @override
  State<Ws423> createState() => _MainAppState();
}

class _MainAppState extends State<Ws423> {
  final List<Map<String, dynamic>> _listElements = const [
    {"key": "u1", "icon": Icons.face, "title": "User 1", "subtitle": "Der allererste"},
    {"key": "u2", "icon": Icons.face_2, "title": "User 2", "subtitle": "Immerhin die Zweite"},
    {"key": "u3", "icon": Icons.face_3, "title": "User 3", "subtitle": "Naja, wenigstens die Dritte"},
    {"key": "u4", "icon": Icons.face_4, "title": "User 4", "subtitle": "Räbäh... nur Vierter"},
    {"key": "u5", "icon": Icons.face_5, "title": "User 5", "subtitle": "...vorerst Letzter!"}];
  
  String text = "Golden Time for Developers";
  bool? checked = false;
  bool switchState = false;

  List<String> inputs = [];

  final GlobalKey<MyTransformState> _globalKey = GlobalKey(); // Globaler Key für das MyTransformState-Widget
  
  int? get transformAngle => _globalKey.currentState!.angle; // Zugriff auf getter/Attribute über den Key

  @override
  Widget build(BuildContext context) {
    return Scaffold(extendBodyBehindAppBar: true, 
        appBar: AppBar(title: Text("Flutter, Flatter..."), scrolledUnderElevation: 32, centerTitle: true, toolbarOpacity: 0.8, bottomOpacity: 0.4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.vertical(bottom: Radius.circular(12))), elevation: 24, shadowColor: Colors.green,
          // leading: IconButton.outlined(onPressed: () {}, icon: Icon(Icons.bathroom_outlined, color: Color.fromARGB(255, 213, 207, 22),)), 
          backgroundColor: Color.fromARGB(255, 13, 86, 85)), 
       
        floatingActionButton: FloatingActionButton.extended(onPressed: () {}, icon: Icon(Icons.help_center_rounded), label: Text("What?")),
        // bottomNavigationBar: BottomNavigationBar(onTap: (value) {}, backgroundColor: Colors.deepOrangeAccent[200], currentIndex: 1, type: BottomNavigationBarType.fixed, items: [
        //   BottomNavigationBarItem(label: "Item 1", icon: Icon(Icons.access_alarm, color: const Color.fromARGB(255, 4, 8, 7))), 
        //   BottomNavigationBarItem(label: "Item 2", icon: Icon(Icons.access_time, color: Colors.tealAccent)), 
        //   BottomNavigationBarItem(label: "Item 3", icon: Icon(Icons.ac_unit, color: Colors.tealAccent))]),
        // drawer: Drawer(backgroundColor: Colors.blueAccent[600], elevation: 8, clipBehavior: Clip.hardEdge , child: Text("Inside Drawer")),
        // drawerDragStartBehavior: DragStartBehavior.start,
        persistentFooterButtons: [ElevatedButton.icon(onPressed: () {}, label: Text("Bugs everywhere!"), iconAlignment: IconAlignment.start, icon: Icon(Icons.adb))], persistentFooterAlignment: AlignmentDirectional.bottomCenter, 
        body: SingleChildScrollView(scrollDirection: Axis.vertical, 
          child: Container(decoration: BoxDecoration(gradient: goldGradient),
            child: Center(
              child: SafeArea(
                child: Column(spacing: 8, children: [                  
                    Text(text, 
                      style: TextStyle(fontFamily: "CupertinoSystemDisplay", fontSize: 24, fontStyle: FontStyle.italic, 
                        fontWeight: FontWeight.w500, color: Color.fromARGB(255, 66, 60, 177))),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                      Checkbox(value: checked, onChanged: (value) => setState(() => checked = value), tristate: true, side: BorderSide(width: 1.2), splashRadius: 32, shape: StarBorder(innerRadiusRatio: 0.4, pointRounding: 0.5, rotation: 11, points: 6)), 
                      Switch(value: switchState, onChanged: (value) => setState(() => switchState = value), thumbIcon: WidgetStatePropertyAll(Icon(Icons.face_sharp))), 
                      FilledButton(onPressed: () {}, child: Text("Ich ein FilledButton"))]),
                    TextButton(onPressed: () {}, child: Text("Ich bin ein TextButton")),              
                    MyTextInput(onSubmitted: (value) => setState(() => inputs=value) /* inputs = value; setState(() => inputs); */ ), Text("Zurückgegebene Texte des Widgets: $inputs"),
                    // FilledButton.icon(onPressed: null, label: Text(" Mit Icon! Und Filled!"), icon: Icon(Icons.face_sharp, size: 36, color: Color.fromARGB(255, 173, 13, 13))),
                    Container(height: 250, decoration: BoxDecoration(gradient: goldGradient),
                      child: ListView.builder(itemCount: _listElements.length, itemBuilder: (context, index) {
                        Map m = _listElements[index];
                        return ListTile(
                          key: Key(m["key"]), dense: false, onTap: () {}, hoverColor: Colors.teal, leading: Icon(m["icon"]), 
                          title: Title(color: Color.fromARGB(255, 20, 65, 5), child: Text(m["title"])), 
                          subtitle: Text(m["subtitle"])); 
                      })
                      // child: ListBody(children: [ for(Map m in _listElements) 
                      //   ListTile(key: Key(m["key"]), dense: false, onTap: () {}, hoverColor: Colors.teal, leading: Icon(m["icon"]), title: Title(color: Color.fromARGB(255, 20, 65, 5), child: Text(m["title"])), subtitle: Text(m["subtitle"])) ]),
                        // ListTile(onTap: () {}, hoverColor: Colors.teal, leading: Icon(Icons.face_3), title: Title(color: Color.fromARGB(255, 20, 65, 5), child: Text("Listenelement 1")), subtitle: Text("Weil ich der erste in der Liste bin!")), 
                        // ListTile(onTap: () {}, hoverColor: Colors.teal, leading: Icon(Icons.face_2), title: Title(color: Color.fromARGB(255, 20, 65, 5), child: Text("Listenelement 2")), subtitle: Text("Weil ich die zweite in der Liste bin!"))],),
                    ),
                    // ListView(children: [ListTile(leading: Icon(Icons.face_5), title: Title(color: Color.fromARGB(255, 20, 65, 5), child: Text("Listenelement 1")), subtitle: Text("Weil ich der erste in der Liste bin!")), ListTile(leading: Icon(Icons.face_2), title: Title(color: Color.fromARGB(255, 20, 65, 5), child: Text("Listenelement 2")), subtitle: Text("Weil ich die zweite in der Liste bin!"))],),
                    Divider(thickness: 3),
                    MyTransform(key: _globalKey), // mit App-weit eindeutigem Key
                    IconButton.outlined(onPressed: () {}, icon: Icon(Icons.shopping_bag_outlined, color: Color.fromARGB(160, 160, 13, 13))),
                    Image.asset('assets/images/bitpanda-logo.gif', colorBlendMode: BlendMode.darken, width: 180)
                  ]
                ),
              ),
            ),
          ),
        ), 
        endDrawer: EndDrawerButton(),
        backgroundColor: Colors.white  // const Color.fromARGB(243, 165, 206, 175), 
      );
  }
}
