import 'dart:convert';
import 'package:bitcoin_price_view/data_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<BitcoinPriceIndex> fetchBitcoinPriceIndex() async {
    final response = await http.get(Uri.parse('https://api.coindesk.com/v1/bpi/currentprice.json'));
    if (response.statusCode == 200) {
      return BitcoinPriceIndex.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load Bitcoin Price Index');
    }
  }
}