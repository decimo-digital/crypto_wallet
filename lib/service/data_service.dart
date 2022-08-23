import 'dart:convert';
import '../model/token_data_market.dart';
import 'package:http/http.dart' as http;

class DataService {
  Future<List<Token>> fetchToken() async {
    List<Token> tokenList = <Token>[];
    final response = await http.get(
      Uri.parse(
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false',
      ),
    );

    if (response.statusCode == 200) {
      List<dynamic> values = [];
      values = json.decode(response.body);
      if (values.isNotEmpty) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            tokenList.add(Token.fromJson(map));
          }
        }
      }
    } else {
      throw Exception('Failed to load token list');
    }
    return tokenList;
  }
}
