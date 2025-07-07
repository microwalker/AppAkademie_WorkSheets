import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Ts614 extends StatefulWidget {
  const Ts614({super.key});

  @override
  State<Ts614> createState() => _Ts614State();
}

class _Ts614State extends State<Ts614> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("6.1.4 Firestore"), backgroundColor: Colors.pinkAccent.shade100, elevation: 12, shadowColor: Colors.purple,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: FutureBuilder(future: getCollection(), builder: (context, snapshot) {
            if(snapshot.hasData) {
              return Column(mainAxisAlignment: MainAxisAlignment.center, spacing: 24, children: [
              Text("Die Collection 'Retrocomputer' hat ${snapshot.data?.size ?? "--"} Dokumente"),
              ListView.builder(padding: EdgeInsets.symmetric(horizontal: 32), shrinkWrap: true, itemCount: snapshot.data?.size, itemBuilder: (context, index) {
                return Text("Dokument $index mit der ID '${snapshot.data?.docs[index].id}'");
              }),
              ListView.builder(padding: EdgeInsets.symmetric(horizontal: 32), shrinkWrap: true, itemCount: snapshot.data?.docs.length, itemBuilder: (context, index) {
                return Text("Einträge zu ${snapshot.data?.docs[index].id}:\n ${snapshot.data?.docs[index].data().values}");
              },)
            ]);
            } else { return CircularProgressIndicator(); }
            }
          )),
      ));
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getCollection() async {
    await Future.delayed(Duration(milliseconds: 500));
    return await FirebaseFirestore.instance.collection("Retrocomputer").get();
  }
}