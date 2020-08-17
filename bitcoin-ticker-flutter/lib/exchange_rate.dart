import 'package:http/http.dart' as http;
import 'dart:convert';

const apiKey = '3F0891AE-32B7-44D1-98F2-5185F0BAD462';
const coinUrl = 'https://rest.coinapi.io/v1/exchangerate';
const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class RateExchanger {
  final String toCurrency;
  RateExchanger({this.toCurrency});
  Future<dynamic> getCoinRates() async {
    var rates = [];
    for (int i = 0; i < 3; i++) {
      String fromCurrency = cryptoList[i];
      String url = '$coinUrl/$fromCurrency/$toCurrency?apikey=$apiKey';
      http.Response response = await http.get(url);
      var coinData = jsonDecode(response.body);
      double temp = coinData['rate'];
      rates.add(temp.toInt().toString());
    }

    return rates;
  }
}
