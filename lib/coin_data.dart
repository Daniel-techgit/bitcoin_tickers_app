//TODO: Add your imports here.
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

const apiKey = '8FE5FE06-8E9B-42C7-8510-77C57E61245C';

// const coinAPIURL =
//     'https://rest.coinapi.io/v1/exchangerate/BTC/USD/?apiKey=$apiKey';

class CoinData {
  //TODO 3: Update getCoinData to take the selectedCurrency as an input.

  //TODO: Create your getCoinData() method here.
  Future<dynamic> getCoinData(String selectedCurrency) async {
    //TODO 4: Update the URL to use the selectedCurrency input.
    String coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate/'
        'BTC/$selectedCurrency/?apiKey=$apiKey';
    var response = await http.get(Uri.parse(coinAPIURL));
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      double rate = double.tryParse(jsonResponse['rate'].toString()) ?? 0.0;
      // print(jsonResponse['rate']);
      return rate;
    } else {
      return response.statusCode.toString();
    }
  }

}
