import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'exchange_rate.dart';

class PriceScreen extends StatefulWidget {
  var coinDataRates;
  PriceScreen({this.coinDataRates});
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String chosenCurrency = 'USD';
  List<String> rates = ['?', '?', '?'];
  void updateUI(coinDataRates) {
    if (coinDataRates == null) {
      for (int i = 0; i < 3; i++) {
        rates[i] = '?';
      }
      return;
    }
    setState(() {
      for (int i = 0; i < 3; i++) rates[i] = coinDataRates[i];
    });
  }

  DropdownButton<String> getDropDownButton() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String curr in currenciesList) {
      dropDownItems.add(DropdownMenuItem(
        child: Text(curr),
        value: curr,
      ));
    }
    return DropdownButton(
        value: chosenCurrency,
        onChanged: (value) async {
          RateExchanger exchanger = RateExchanger(toCurrency: value);
          var coinDataRates = await exchanger.getCoinRates();
          chosenCurrency = value;
          updateUI(coinDataRates);
        },
        items: dropDownItems);
  }

  CupertinoPicker getIosPicker() {
    List<Text> pickerItems = [];
    for (String curr in currenciesList) pickerItems.add(Text(curr));
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) async {
        String value = pickerItems[selectedIndex].data;
        RateExchanger exchanger = RateExchanger(toCurrency: value);
        var coinDataRates = await exchanger.getCoinRates();

        setState(() {
          chosenCurrency = value;
          updateUI(coinDataRates);
        });
      },
      children: pickerItems,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateUI(widget.coinDataRates);
  }

  Widget getTabs() {
    List<Widget> cards = [];
    for (int i = 0; i < 3; i++) {
      cards.add(
        card_converter(
            fromCurrency: cryptoList[i],
            rate: rates[i],
            toCurrency: chosenCurrency),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: cards,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          getTabs(),
          Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child: Platform.isIOS ? getIosPicker() : getDropDownButton()),
        ],
      ),
    );
  }
}

class card_converter extends StatelessWidget {
  const card_converter({
    Key key,
    @required this.fromCurrency,
    @required this.rate,
    @required this.toCurrency,
  }) : super(key: key);
  final String fromCurrency;
  final String rate;
  final String toCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $fromCurrency = $rate $toCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
