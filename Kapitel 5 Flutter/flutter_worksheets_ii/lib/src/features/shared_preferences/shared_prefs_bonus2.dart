import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsBonus2 extends StatefulWidget {
  const SharedPrefsBonus2({super.key});

  @override
  State<SharedPrefsBonus2> createState() => _SharedPrefsBonus2State();
}

class _SharedPrefsBonus2State extends State<SharedPrefsBonus2> {
  List<String> drinks = ["Rum", "Tequila", "Kao Liang", "Korn", "Vodka", "Bier"];
  int anz = 0;
  DateTime date = DateTime.now();
  late SharedPreferences prefs;
  bool hasPrefs = false;

  @override
  void initState() {
    super.initState();
    initializePrefs();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Shared Prefs - Trinkhelfer"), backgroundColor: Colors.redAccent.shade200),
      body: 
      Column(mainAxisAlignment: MainAxisAlignment.center, spacing: 12, children: [
        Text("So viel geschafft:", style: Theme.of(context).textTheme.headlineSmall), 
        hasPrefs ? Text("$anz", style: Theme.of(context).textTheme.displayMedium?.copyWith(color: anz>10 ? Colors.red : anz>5 ? Colors.orange : Colors.green)) : CircularProgressIndicator(),
        Row(mainAxisAlignment: MainAxisAlignment.center, spacing: 12, children: [
          FilledButton(onPressed: () async => setDrink(++anz).then((value) => setState(() => anz)), child: Text("Glas ${drinks[Random().nextInt(drinks.length)]} trinken!")),
          FilledButton(onPressed: () => setState(() { anz = 0; setDrink(0); }), child: Text("Von vorne anfangen!"))
        ],)
      ],),
    );
  }

  Future<void> initializePrefs() async {
    prefs = await SharedPreferences.getInstance().whenComplete(() => setState(() => hasPrefs = true));
    // await Future.delayed(Duration(seconds: 2));
    anz = prefs.getInt("sp_drinks") ?? 0;
    date = DateTime.tryParse(prefs.getString("sp_last_drink") ?? "") ?? date;
    if(DateTime.now().day != date.day) { 
      anz = 0; 
    }
    setState(() { 
      anz; }); 
  }

  Future<void> setDrink(int anz) async {
    if(hasPrefs) {
      await prefs.setInt("sp_drinks", anz);
      await prefs.setString("sp_last_drink", date.toString());
    }
  }
}