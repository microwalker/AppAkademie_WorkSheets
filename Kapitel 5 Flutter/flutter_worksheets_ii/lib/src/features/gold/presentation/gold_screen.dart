import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../data/fake_gold_api.dart';
import 'widgets/gold_header.dart';

class GoldScreen extends StatefulWidget {
  const GoldScreen({super.key});

  @override
  State<GoldScreen> createState() => _GoldScreenState();
}

class _GoldScreenState extends State<GoldScreen> {
  StreamSubscription<double>? _priceStream;
  Stream<double>? _secondPriceStream;
  double _price = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _priceStream = getGoldPriceStream(1).listen((event) => setState(() => _price = event));
    _secondPriceStream = getGoldPriceStream(3);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GoldHeader(),
              SizedBox(height: 20),
              Text(
                'Live Kurs:',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(height: 20),
              // TODO: Verwende einen StreamBuilder, um den Goldpreis live anzuzeigen
              // statt des konstanten Platzhalters
              StreamBuilder<double>(stream: _secondPriceStream, builder: (context, snapshot) {
                if(snapshot.hasError) {
                  return Icon(Icons.error);
                } else {
                  return Text(snapshot.hasData ?
                    NumberFormat.simpleCurrency(locale: 'de_DE').format(snapshot.data) : "-,--",
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ));
                  }
                }
              ),
              Text("(by StreamBuilder)"),
              SizedBox(height: 64),
              Text(
                NumberFormat.simpleCurrency(locale: 'de_DE').format(_price),
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Text("(by StreamSubscription)"),
              // FilledButton(onPressed: () {
              //    _priceStream?.pause(Future.delayed(Duration(seconds: 10))); setState(() {}); }, child: 
              //    _priceStream!.isPaused ? Icon(Icons.disabled_by_default) : Icon(Icons.pause))
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _priceStream?.cancel();
    // TODO: implement dispose
    super.dispose();
  }
}


