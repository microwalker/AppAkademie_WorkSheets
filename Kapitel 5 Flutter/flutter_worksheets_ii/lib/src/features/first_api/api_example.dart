import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart';

class ApiExample extends StatefulWidget {
  const ApiExample({super.key});

  @override
  State<ApiExample> createState() => _ApiExampleState();
}

class _ApiExampleState extends State<ApiExample> {
  Map? _joke = null;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    getJoke().then((value) => setState(() => _joke = value));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("'Erste' API-App 🤪🥳..."), backgroundColor: Colors.tealAccent,),
      body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, spacing: 32, children: [ 
        if(_joke != null) 
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(spacing: 32, children: [
            Image.network(_joke!["icon_url"]),
            Text(_joke!["value"], style: Theme.of(context).textTheme.bodyLarge)]),
          ),
        ElevatedButton(onPressed: () async => getJoke().then((value) => setState(() => _joke = value)), child: Text("Nächster..."))
       ]))
    );
  }

  Future<Map> getJoke() async {
    // curl 'http://colormind.io/api/' --data-binary '{"model":"default"}'
    final response = await Client().get(Uri.parse(r'https://api.chucknorris.io/jokes/random'));

    return jsonDecode(response.body);
  }
}