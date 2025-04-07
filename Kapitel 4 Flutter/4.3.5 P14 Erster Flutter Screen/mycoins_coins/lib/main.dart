import 'package:flutter/material.dart';

List<Map<String, String>> testdaten = [{"id": "bitcoin", "name": "Bitcoin", "symbol": "btc"}, 
  {"id": "ethereum", "name": "Ethereum", "symbol": "eth"}, 
  {"id": "ripple", "name": "XRP", "symbol": "xrp"}, 
  {"id": "tether", "name": "Tether", "symbol": "usdt"}, 
  {"id": "binancecoin", "name": "BNB", "symbol": "bnb"}, 
  {"id": "solana", "name": "Solana", "symbol": "sol"}, 
  {"id": "usd-coin", "name": "USDC", "symbol": "usdc"}, 
  {"id": "cardano", "name": "Cardano", "symbol": "ada"}, 
  {"id": "dogecoin", "name": "Dogecoin", "symbol": "doge"}, 
  {"id": "tron", "name": "TRON", "symbol": "trx"}, 
  {"id": "staked-ether", "name": "Lido Staked Ether", "symbol": "steth"}, 
  {"id": "wrapped-bitcoin", "name": "Wrapped Bitcoin", "symbol": "wbtc"}, 
  {"id": "chainlink", "name": "Chainlink", "symbol": "link"}, 
  {"id": "the-open-network", "name": "Toncoin", "symbol": "ton"}, 
  {"id": "avalanche-2", "name": "Avalanche", "symbol": "avax"}, 
  {"id": "wrapped-steth", "name": "Wrapped stETH", "symbol": "wsteth"}, 
  {"id": "leo-token", "name": "LEO Token", "symbol": "leo"}, 
  {"id": "stellar", "name": "Stellar", "symbol": "xlm"}, 
  {"id": "usds", "name": "USDS", "symbol": "usds"}, 
  {"id": "hedera-hashgraph", "name": "Hedera", "symbol": "hbar"}];

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(backgroundColor: Colors.green[900], 
        appBar: AppBar(backgroundColor: const Color.fromARGB(255, 15, 101, 17), elevation: 16, shadowColor: Colors.black,  
          leading: BackButtonIcon(), 
          title: Row(mainAxisAlignment: MainAxisAlignment.center, spacing: 8, 
            children: [Image.asset("assets/images/mc_small.png", height: 28), Text("Kryptowährungen", style: TextStyle(fontWeight: FontWeight.w600))]), 
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.account_circle), color: Colors.black,)], actionsPadding: EdgeInsets.only(right: 8),),
        body: Padding(padding: EdgeInsets.fromLTRB(16, 64, 16, 32), 
          child: Column(crossAxisAlignment: CrossAxisAlignment.center, spacing: 16,
            children: [SizedBox(width: 360, child: TextField(onSubmitted: (value) {} , style: TextStyle(fontWeight: FontWeight.bold),
              decoration: InputDecoration(prefixIcon: Icon(Icons.search), suffixIcon: Icon(Icons.cancel_outlined), 
              labelText: "Suchen", filled: true, fillColor: Colors.teal, hintText: "SearchCoin")),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [Text("Verfügbare Kryptowährungen:", style: TextStyle(color: Colors.white, fontSize: 16))]), 
            ListView(scrollDirection: Axis.vertical, 
              children: [ for(Map m in testdaten) CoinItem(title: m["name"]) ])
            // SingleChildScrollView(scrollDirection: Axis.vertical, padding: EdgeInsets.all(4),
            //   child: ListView(scrollDirection: Axis.vertical, 
            //     children: [for(Map m in testdaten) 
            //       Padding(padding: EdgeInsets.all(4), child:  // Text(m["name"]))
            //         Container(decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.all(Radius.circular(8))), height: 48,
            //           child: 
            //             Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            //               Icon(Icons.currency_bitcoin_outlined, size: 40), 
            //               Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            //                 Container(color: Colors.red, child: Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            //                   Text(m["name"]), Spacer(flex: 1), Text("12345,67")])), 
            //                 Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            //                   Text(m["symbol"]), Text(m["id"])])
            //               ])                 
            //             ]) 
            //           )
            //       )
            //         // ListTile(onTap: () {}, iconColor: Colors.red, leading: Icon(Icons.currency_bitcoin, size: 32, color: Colors.amber, fill: 0.8), textColor: Colors.white, title: Text(m["name"]), subtitle: Text(m["symbol"]), 
            //         // shape: RoundedRectangleBorder(side: BorderSide(width: 3, color: Colors.black), borderRadius: BorderRadius.all(Radius.circular(8)))))
            //     ]
            // ))
          ]
          )
        ),
      ),
    );
  }
}


class CoinItem extends StatelessWidget {
  final String? iconUri;
  final String title;
  final String? subtitle;
  final double? value;
  final double? change;
  final bool? selected;

  const CoinItem({super.key, required this.title, this.subtitle, this.iconUri, this.value, this.change, this.selected});

  @override
  Widget build(BuildContext context) {
    return Container(height: 48, width: 360, padding: EdgeInsets.all(4), 
      child: Row(mainAxisAlignment: MainAxisAlignment.start,
      children: [Text(title)]));
  }
}
