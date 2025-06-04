import 'package:flutter/material.dart';

class FutureBuilderExercise extends StatefulWidget {
  const FutureBuilderExercise({super.key});

  @override
  State<FutureBuilderExercise> createState() => _FutureBuilderExerciseState();
}

class _FutureBuilderExerciseState extends State<FutureBuilderExercise> {
  Future<String>? city;
  TextEditingController plzController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("5.2.3 Future Builder"), centerTitle: true, backgroundColor: Colors.indigoAccent.shade100,),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 32, 
          children: [
            TextFormField( 
              controller: plzController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Postleitzahl",
              ),
            ),
            OutlinedButton(
              onPressed: () => setState(() { city = getCityFromZip(plzController.text); }),
              child: const Text("Suche"),
            ),
            FutureBuilder<String>(future: city, builder: (context, snapshot) => 
              Text(snapshot.connectionState == ConnectionState.done ? (snapshot.hasError ? "Fehler aufgetreten: ${snapshot.error}" : 
                   "Ergebnis: ${snapshot.data!}") : snapshot.connectionState == ConnectionState.waiting ? "Suche ist in vollem Gange..." : "Bitte geben Sie eine PLZ ein!",
                style: Theme.of(context).textTheme.labelLarge) 
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    plzController.dispose();
    super.dispose();
  }

  Future<String> getCityFromZip(String zip) async {
    // simuliere Dauer der Datenbank-Anfrage
    await Future.delayed(const Duration(seconds: 3));

    switch (zip) {
      case "10115":
        return 'Berlin';
      case "20095":
        return 'Hamburg';
      case "80331":
        return 'München';
      case "50667":
        return 'Köln';
      case "60311":
      case "60313":
        return 'Frankfurt am Main';
      case "x":
        throw("invalid zipcode");
      default:
        return 'Unbekannte Stadt';
    }
  }
}
