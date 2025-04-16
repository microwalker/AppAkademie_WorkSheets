
class MyWidget {
  // Cause all is a MyWidget !!! :-)

  @override
  String toString() => "MyWidget:\n  ";
}

class MyMaterialApp {
  final MyWidget? home;

  MyMaterialApp({required this.home});
  
  @override
  String toString() => "MaterialApp( $home )";
}

class MyScaffold extends MyWidget {
  final MyWidget? body;

  MyScaffold({required this.body});

  @override
  String toString() => "MyScaffold( $body )";
}

class MyCenter extends MyWidget {
  final MyWidget? child;

  MyCenter({required this.child});

  @override
  String toString() => "MyCenter( $child )";
}

class MyColumn extends MyWidget {
  final List<MyWidget>? children;

  MyColumn({required this.children});

  @override
  String toString() => "MyColumn( $children )";
}

class MyText extends MyWidget {
  final String? data;

  MyText(this.data);

  @override
  String toString() => "MyText( '$data' )";
}

void main() {
  String text1 = "Hallo";
  String text2 = "Welt";

  MyMaterialApp myApp = MyMaterialApp(home: MyScaffold(body: MyCenter(child: MyColumn(children: [MyText(text1) , MyText(text2)]))));
  
  print("myApp = $myApp");
}