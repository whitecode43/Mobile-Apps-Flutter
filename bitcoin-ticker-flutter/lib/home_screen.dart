import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'exchange_rate.dart';
import 'price_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void getCoinExchange() async {
    var coinDataRates = await RateExchanger(toCurrency: 'USD').getCoinRates();
    for (int i = 0; i < 3; i++) print(coinDataRates[i]);
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return PriceScreen(
        coinDataRates: coinDataRates,
      );
    }));
  }

  @override
  void initState() {
    super.initState();
    print('Home_screen Initialized');
    getCoinExchange();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.lightBlue,
        body: Center(
            child: SpinKitCircle(
          color: Colors.white,
          size: 100.0,
        )));
  }
}
