import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../model/token_data_market.dart';
import 'package:http/http.dart' as http;

class DataService {
  Future<List<Token>> fetchToken() async {
    final response = await http.get(
      Uri.parse(
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false',
      ),
    );
    if (response.statusCode == 200) {
      return compute(parseToken, response.body);
    } else {
      throw Exception('Failed to load token list');
    }
  }

  List<Token> parseToken(String responseBody) {
    return (jsonDecode(responseBody) as List)
        .map((e) => Token.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
