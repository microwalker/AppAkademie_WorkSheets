import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';

void main(List<String> args) {
  aufg1();

  aufg2();

  exit(-1);
}

void aufg2() {
  String jsonString = '{"name": "Lisa", "age": 25}';
  String name = jsonDecode(jsonString)["name"];
  print(name);

  jsonString = '{"product": {"title": "Schreibtisch", "price": 120.5}}';
  double price = (jsonDecode(jsonString)["product"])["price"];
  print(price);

  jsonString = '{"tags": ["flutter", "dart", "api"]}';
  List tags = jsonDecode(jsonString)["tags"];
  print(tags);

  jsonString = '{"user": {"name": "Tom", "email": "tom@example.com"}}';
  print((jsonDecode(jsonString)["user"])["email"]);
}

void aufg1() async {
  Response response = await Client().get(Uri.parse(r'https://jsonplaceholder.typicode.com/users'));
  if(response.statusCode == 200) {
    List<dynamic> users = jsonDecode(response.body);
    users.forEach((element) => print(element["name"]));
  } else {
    print(response.statusCode);
  }
}