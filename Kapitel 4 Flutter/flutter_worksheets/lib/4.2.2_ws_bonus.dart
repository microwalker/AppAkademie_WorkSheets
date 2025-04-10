
class Widget {
  // Cause all is a Widget !!! :-)

  @override
  String toString() => "Widget:\n  ";
}

class MaterialApp {
  final Widget? home;

  MaterialApp({required this.home});
  
  @override
  String toString() => "MaterialApp( $home )";
}

class Scaffold extends Widget {
  final Widget? body;

  Scaffold({required this.body});

  @override
  String toString() => "Scaffold( $body )";
}

class Center extends Widget {
  final Widget? child;

  Center({required this.child});

  @override
  String toString() => "Center( $child )";
}

class Column extends Widget {
  final List<Widget>? children;

  Column({required this.children});

  @override
  String toString() => "Column( $children )";
}

class Text extends Widget {
  final String? data;

  Text(this.data);

  @override
  String toString() => "Text( '$data' )";
}

void main() {
  String text1 = "Hallo";
  String text2 = "Welt";

  MaterialApp myApp = MaterialApp(home: Scaffold(body: Center(child: Column(children: [Text(text1) , Text(text2)]))));
  
  print("myApp = $myApp");
}