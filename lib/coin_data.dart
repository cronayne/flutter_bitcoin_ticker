import 'package:http/http.dart' as http;
import 'dart:convert';

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

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = '7A9A11F2-9CCB-4E53-A571-55A9517CD92A';

class CoinData {

  Future getCoinData(String currency) async {

    Map<String, String> cryptoPrices = {};

    for (String crypto in cryptoList){
      String requestUrl = '$coinAPIURL/$crypto/$currency?apikey=$apiKey';
      http.Response response = await http.get(requestUrl);

      if(response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        var lastPrice = decodedData['rate'];
        cryptoPrices[crypto] = lastPrice.toStringAsFixed(0);
      } else {
        print(response.statusCode);
        throw 'There was a problem getting the data';
      }
    }
    return cryptoPrices;
  }
}
