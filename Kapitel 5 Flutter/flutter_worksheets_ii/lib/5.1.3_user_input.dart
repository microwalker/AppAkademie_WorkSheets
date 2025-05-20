import 'package:flutter/material.dart';

List<Map<String, String>> users = [
  {"name": "Testuser", "pw": "12345"},
  {"name": "Admin", "pw": "sysadmin"},
  {"name": "Superman", "pw": "lois"}
];

void main() {
  runApp(const MaterialApp(home: Ws513()));
}

class Ws513 extends StatefulWidget {
  const Ws513({super.key});

  @override
  State<Ws513> createState() => _Ws513State();
}

class _Ws513State extends State<Ws513> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  WidgetStatesController loginController = WidgetStatesController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("User Input"), centerTitle: true), body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(autovalidateMode: AutovalidateMode.onUserInteraction, onChanged: () {
        loginController.update(WidgetState.disabled, nameController.text.isEmpty || passwordController.text.isEmpty); 
      }, child: Column(mainAxisAlignment: MainAxisAlignment.center, spacing: 12, 
        children: [
          TextFormField(controller: nameController, decoration: InputDecoration(hintText: "Benutzername")),
          TextFormField(controller: passwordController, decoration: InputDecoration(hintText: "Passwort"), obscureText: true),
          ElevatedButton(onPressed: () { 
            if(!loginController.value.contains(WidgetState.disabled)) {
              // print("Login: ${checkLogin(nameController.text, passwordController.text)}");
              Navigator.push(context, MaterialPageRoute(builder: (context) => Ws513_2(name: nameController.text)));
            } }, statesController: loginController, child: Text("Login") )
        ],
      ),),
    ));
  }

  @override
  void dispose() {
    nameController.dispose();
    passwordController.dispose();
    loginController.dispose();
    super.dispose();
  }

  bool checkLogin(String name, String pw) {
    return users.map((e) => e["name"]).toList().contains(name) ? users.singleWhere((element) => element["name"] == name)["pw"] == pw : false;
  }
}

class Ws513_2 extends StatelessWidget {
  final String name;

  const Ws513_2({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(), body: Center(child: Text("Hallo $name")));
  }
}