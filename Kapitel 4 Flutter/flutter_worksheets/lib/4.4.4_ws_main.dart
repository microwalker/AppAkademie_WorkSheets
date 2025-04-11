import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_worksheets/src/my_transform.dart';
import 'package:flutter_worksheets/src/styles.dart';

void main() {
  runApp(const Ws444());
}

class Ws444 extends StatefulWidget {

  const Ws444({super.key});

  @override
  State<Ws444> createState() => _Ws444State();
}

enum Materials { material2, material3 }
class _Ws444State extends State<Ws444> {
  Materials material = Materials.material3;
  int pIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.blueGrey,
      home: Scaffold(backgroundColor: Color(0xff002000),
        appBar: AppBar(title: Text("Inside Screen Navigation"), backgroundColor: Color(0xff7f7f7f), elevation: 8, shadowColor: Color(0x7f3f3f3f),),
        drawer: material == Materials.material3 ? NavigationDrawer(backgroundColor: veryLightGreen, 
          selectedIndex: pIndex, onDestinationSelected: (value) => setState(() => pIndex = value), children: [
          DrawerHeader(curve: Curves.easeInOut, child: Container(decoration: BoxDecoration(gradient: goldGradient, borderRadius: BorderRadius.all(Radius.circular(8))), width: double.infinity, child: Center(child: Text("Menu (V3)")))),
          NavigationDrawerDestination(icon: Icon(Icons.home), label: Text("Home")),
          NavigationDrawerDestination(icon: Icon(Icons.account_balance_wallet_rounded), label: Text("Balance"))],
          ) :
          Drawer(backgroundColor: Colors.green, width: 200, child: 
            Container(decoration: BoxDecoration(gradient: lightGreenGradient, borderRadius: BorderRadius.all(Radius.circular(8))), margin: EdgeInsets.all(12), child: 
              Column(spacing: 16, children: [
                DrawerHeader(curve: Curves.easeInOut, child: Container(decoration: BoxDecoration(gradient: goldGradient, borderRadius: BorderRadius.all(Radius.circular(8))), width: double.infinity, child: Center(child: Text("Menu (V2)")))),
                TextButton.icon(onPressed: () => setState(() => pIndex = 0), label: Text("Homepage"), icon: Icon(Icons.home_filled)),
                TextButton.icon(onPressed: () => setState(() => pIndex = 1), label: Text("Balance"), icon: Icon(Icons.account_balance_wallet_rounded))
        ],),),),
        bottomNavigationBar: material == Materials.material2 ? 
          BottomNavigationBar(items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: "Balance")], 
            currentIndex: pIndex, 
            onTap: (value) => setState(() => pIndex = value)
          ) : 
          NavigationBar(backgroundColor: Color(0xff9f9f9f), elevation: 8, shadowColor: Color(0x7f3f3f3f), destinations: [
            NavigationDestination(icon: Icon(Icons.home), label: "Home", tooltip: "Homepage"),
            NavigationDestination(icon: Icon(Icons.account_balance_wallet), label: "Balance", tooltip: "Account Page")], 
            selectedIndex: pIndex,
            onDestinationSelected: (value) => setState(() => pIndex = value) 
          ),
        body: Padding(padding: EdgeInsets.all(16), child: Column(spacing: 16, children: [
          MyTransform(),
          <Widget>[ MyHomepage(), MyAccount() ][pIndex],
          Expanded(child: Container(color: Colors.blueGrey, child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, crossAxisAlignment: CrossAxisAlignment.center, children: [ 
            Text("Material-Style:"), 
            RadioListTile<Materials>(value: Materials.material2, groupValue: material, onChanged: (value) { setState(() { material = value!; }); }, title: Text("2"),), 
            RadioListTile<Materials>(value: Materials.material3, groupValue: material, onChanged: (value) { setState(() { material = value!; }); }, title: Text("3"),) ])))
        ]))
      )
    );
  }
}

class MyHomepage extends StatelessWidget {
  const MyHomepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(flex: 3, child: Container(decoration: BoxDecoration(gradient: goldGradient),child: Center(child: Image.asset('assets/images/mycoins_huge.png'),),)) ;
  }
}

class MyAccount extends StatelessWidget {
  const MyAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(flex: 3, child: Container(decoration: BoxDecoration(gradient: darkGreenGradient),child: Center(child: Image.asset('assets/images/chart.png'),),)) ;
  }
}

