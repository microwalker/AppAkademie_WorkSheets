import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: "MainApp",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Flutter, Flatter..."), leading: IconButton.outlined(onPressed: null, icon: Icon(Icons.bathroom_outlined, color: Color.fromARGB(255, 213, 207, 22),)), centerTitle: true, backgroundColor: Color.fromARGB(197, 13, 86, 85),),
        floatingActionButton: 
          FloatingActionButton.extended(
            onPressed: null, icon: Icon(Icons.help_center_rounded), label: Text("What?")),
        body: Center(
          child: Column(children: [
              Text("Golden times for Developers!", 
                style: TextStyle(fontFamily: "CupertinoSystemDisplay", fontSize: 24, fontStyle: FontStyle.italic, 
                  fontWeight: FontWeight.w500, color: Color.fromARGB(255, 66, 60, 177))),
              Checkbox(value: false, onChanged: null),
              Switch(value: true, onChanged: null),
              TextButton(onPressed: null, child: Text("Ich bin ein TextButton")),
              FilledButton(onPressed: null, child: Text("Ich ein FilledButton")),
              FilledButton(onPressed: null, child: 
                SizedBox(width: 192, child: Row(children: [Icon(Icons.face_sharp, size: 36, color: Color.fromARGB(255, 173, 13, 13)), Text(" Mit Icon! Und Filled!")]))),
              Spacer(flex: 1),
              ListBody(children: [ListTile(leading: Icon(Icons.face_5), title: Title(color: Color.fromARGB(255, 20, 65, 5), child: Text("Listenelement 1")), subtitle: Text("Weil ich der erste in der Liste bin!")), ListTile(leading: Icon(Icons.face_2), title: Title(color: Color.fromARGB(255, 20, 65, 5), child: Text("Listenelement 2")), subtitle: Text("Weil ich die zweite in der Liste bin!"))],),
              // ListView(children: [ListTile(leading: Icon(Icons.face_5), title: Title(color: Color.fromARGB(255, 20, 65, 5), child: Text("Listenelement 1")), subtitle: Text("Weil ich der erste in der Liste bin!")), ListTile(leading: Icon(Icons.face_2), title: Title(color: Color.fromARGB(255, 20, 65, 5), child: Text("Listenelement 2")), subtitle: Text("Weil ich die zweite in der Liste bin!"))],),
              Divider(thickness: 3),
              Spacer(flex: 1),
              Transform.rotate(angle: .22, child: Image(image: NetworkImage('https://files.readme.io/31ab3f6-small-CoinGecko_API_Documentation_-_SuperGecko.png'), 
                fit: BoxFit.contain, alignment: Alignment.topCenter, width: 300)),
              IconButton.outlined(onPressed: null, icon: Icon(Icons.shopping_bag_outlined, color: Color.fromARGB(160, 160, 13, 13))),
              Spacer(flex: 2)
            ]
          ),
        ), 
        backgroundColor: const Color.fromARGB(243, 165, 206, 175), 
      ),
    );
  }
}
