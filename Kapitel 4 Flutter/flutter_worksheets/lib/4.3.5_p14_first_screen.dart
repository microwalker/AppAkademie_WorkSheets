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
  runApp(const ws435());
}

class ws435 extends StatefulWidget {
  const ws435({super.key});

  @override
  State<ws435> createState() => _MainAppState();
}

class _MainAppState extends State<ws435> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: "MyCoins - CoinListPage",
      home: Scaffold(backgroundColor: Colors.green.shade900, primary: false,
        // appBar: AppBar(backgroundColor: const Color.fromARGB(255, 15, 101, 17), elevation: 16, shadowColor: Colors.black,  
        //   leading: BackButtonIcon(), 
        //   title: Row(mainAxisAlignment: MainAxisAlignment.center, spacing: 8, 
        //   children: [
        //     Image.asset("assets/images/mc_small.png", height: 28), 
        //     Text("Kryptowährungen", style: TextStyle(fontWeight: FontWeight.w600))]), 
        //   actions: [
        //     IconButton(onPressed: () {}, icon: Icon(Icons.account_circle), color: Colors.black,)], actionsPadding: EdgeInsets.only(right: 8)),
        // floatingActionButton: FloatingActionButton(onPressed: () {}, backgroundColor: Colors.yellow, child: Text("FAB")),
        body: 
          Column(spacing: 8,
            children: [ 
              Center(child: TextField(onSubmitted: (value) {} , style: TextStyle(fontWeight: FontWeight.bold),
                decoration: InputDecoration(prefixIcon: Icon(Icons.search), suffixIcon: Icon(Icons.cancel_outlined), 
                labelText: "Suchen", filled: true, fillColor: Colors.teal, hintText: "SearchCoin"))),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,  
                  children: [ Text("Verfügbare Kryptowährungen:", style: TextStyle(color: Colors.white, fontSize: 16)), Text("TEST") ]), 
              SizedBox(height: 500, child: ListView(scrollDirection: Axis.vertical, shrinkWrap: true, 
                children: [ for(Map m in testdaten) ListTile(title: CoinItem(title: m["name"], subtitle: m["symbol"], value: 12345.67, change: -543.21, selectable: false))]))]),
      ),
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
      Container(color: Colors.red, padding: EdgeInsets.all(4),  
        child: Expanded(
          child: 
            Row(mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.currency_bitcoin_rounded, size: 48), 
                Expanded(flex: 1,  
                  child: 
                    Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, crossAxisAlignment: CrossAxisAlignment.start,
                      children: [Text(widget.title), if(widget.subtitle != null) Text(widget.subtitle!)])
            ), 
                Expanded(flex: 1, 
                  child: 
                    Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, crossAxisAlignment: CrossAxisAlignment.end,
                      children: [if (widget.value != null) Text(widget.value!.toStringAsFixed(2)), if(widget.change != null) Text(widget.change!.toStringAsFixed(2) )])
            ),
            if(widget.selectable!) Checkbox(value: selected, onChanged: (value) => setState(() => selected = value!), tristate: false)
          ])
        )
      );
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
