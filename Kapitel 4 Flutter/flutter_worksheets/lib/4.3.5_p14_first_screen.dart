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
  runApp(const MaterialApp(title: "MyCoins - CoinListPage", home: Ws435()));
}

class Ws435 extends StatefulWidget {
  const Ws435({super.key});

  @override
  State<Ws435> createState() => _MainAppState();
}

class _MainAppState extends State<Ws435> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.green.shade900, primary: false,
        appBar: AppBar(backgroundColor: const Color.fromARGB(255, 15, 101, 17), elevation: 16, shadowColor: Colors.black,  
          // leading: BackButtonIcon(), 
          title: Row(mainAxisAlignment: MainAxisAlignment.center, spacing: 8, 
          children: [
            Image.asset("assets/images/mc_small.png", height: 28), 
            Text("Kryptowährungen", style: TextStyle(fontWeight: FontWeight.w600))]), 
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.account_circle), color: Colors.black,)], actionsPadding: EdgeInsets.only(right: 8)),
        floatingActionButton: FloatingActionButton(onPressed: () {}, backgroundColor: Colors.yellow, child: Text("FAB")),
        body: 
          Column(spacing: 8,
            children: [ 
              Center(child: TextField(onSubmitted: (value) {} , style: TextStyle(fontWeight: FontWeight.bold),
                decoration: InputDecoration(prefixIcon: Icon(Icons.search), suffixIcon: Icon(Icons.cancel_outlined), 
                labelText: "Suchen", filled: true, fillColor: Colors.teal, hintText: "SearchCoin"))),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,  
                  children: [ Text("Verfügbare Kryptowährungen:", style: TextStyle(color: Colors.white, fontSize: 16)), Text("TEST") ]), 
              Expanded(child: ListView(scrollDirection: Axis.vertical, 
                children: [ for(Map m in testdaten) ListTile(title: CoinItem(title: m["name"], subtitle: m["symbol"], value: 12345.67, change: -543.21, selectable: true))]))]),
      );
  }
}


class CoinItem extends StatefulWidget {
  final String? iconUri;
  final String title;
  final String? subtitle;
  final double? value;
  final double? change;
  final bool? selectable;

  const CoinItem({super.key, required this.title, this.subtitle, this.iconUri, this.value, this.change, this.selectable});

  @override
  State<CoinItem> createState() => _CoinItemState();
}

class _CoinItemState extends State<CoinItem> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return
      InkWell(onTap: () { showDialog(context: context, builder: (context) => AlertDialog(content: SizedBox(width: 200, height: 200, child: Center(child: Text("You clicked ${widget.title}")))));},
        child: Card(elevation: 8, shadowColor: Colors.black, shape: RoundedRectangleBorder(side: BorderSide(width: 1), borderRadius: BorderRadius.circular(12)), color: Colors.greenAccent[600], margin: EdgeInsets.all(4), child: 
          SizedBox(height: 80, width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Row(spacing: 4, children: [
                IconButton.filled(onPressed: () {}, iconSize:40, icon: Icon(Icons.currency_bitcoin, shadows: [Shadow(offset: Offset(4, 4), blurRadius: 2)], color: Colors.white), color: Colors.green), 
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(spacing: 4, mainAxisAlignment: MainAxisAlignment.center, children: [ 
                      Expanded(child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [ Expanded(child: Text(widget.title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), softWrap: true, maxLines: 2, overflow: TextOverflow.ellipsis)), FittedBox(fit: BoxFit.contain, child: Text(widget.value!.toStringAsFixed(2), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), maxLines: 1, softWrap: false)) ])),
                      Expanded(child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [ Expanded(child: Text(widget.subtitle!, maxLines: 1,)), FittedBox(child: Text(widget.change!.toStringAsFixed(2), maxLines: 1, softWrap: false)) ])) 
                      ]),
                  ),
                ),
                if(widget.selectable!) Checkbox(value: selected, onChanged: (value) => setState(() => selected = value!), activeColor: Color(0xff004000), tristate: false),
              ],),
            ),
          ),),
      ); 
      // Container(color: Colors.red, padding: EdgeInsets.all(4),  
      //   child: Expanded(
      //     child: 
      //       Row(mainAxisAlignment: MainAxisAlignment.start,
      //         children: [
      //           Icon(Icons.currency_bitcoin_rounded, size: 48), 
      //           Expanded(flex: 1,  
      //             child: 
      //               Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, crossAxisAlignment: CrossAxisAlignment.start,
      //                 children: [Text(widget.title), if(widget.subtitle != null) Text(widget.subtitle!)])
      //       ), 
      //           Expanded(flex: 1, 
      //             child: 
      //               Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, crossAxisAlignment: CrossAxisAlignment.end,
      //                 children: [if (widget.value != null) Text(widget.value!.toStringAsFixed(2)), if(widget.change != null) Text(widget.change!.toStringAsFixed(2) )])
      //       ),
      //       if(widget.selectable!) Checkbox(value: selected, onChanged: (value) => setState(() => selected = value!), tristate: false)
      //     ])
      //   )
      // );
  }
}

class TestWidget extends StatefulWidget {
  const TestWidget({super.key});

  @override
  State<TestWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
