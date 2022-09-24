import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../model/token_data_market.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      throw Exception('Failed to load tokens list');
    }
  }

  List<Token> parseToken(String responseBody) {
    return (jsonDecode(responseBody) as List)
        .map((e) => Token.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future signIn(
    TextEditingController email,
    TextEditingController password,
  ) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );
    } on FirebaseException catch (error) {
      print(error);
    }
  }

  Future signUp(
    TextEditingController email,
    TextEditingController password,
  ) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );
    } on FirebaseException catch (error) {
      print(error);
    }
  }

  Future<User> getFirebaseUser() async {
    return FirebaseAuth.instance.currentUser!;
  }
}
