import 'dart:convert';

import 'package:http/http.dart' as http;

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

const exchangeRateUrl = 'https://rest.coinapi.io/v1/exchangerate';
const headers = {'X-CoinAPI-Key': '0B873F71-30F3-4EEE-A736-E0285CD74E2E'};

class CoinData {
  Future<int?> getCoinData({
    required String base,
    required String quote,
  }) async {
    final response = await http.get(
      Uri.parse('$exchangeRateUrl/$base/$quote'), //?apikey=$apiKey
      headers: headers,
    );

    if (response.statusCode == 200) {
      final rate = jsonDecode(response.body)['rate'] as double;
      return rate.toInt();
    } else {
      print(response.statusCode);
      print(response.body);
    }
    return Future.value(null);
  }
}
