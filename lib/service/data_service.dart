import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/token_data_market.dart';

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

  Future<UserCredential?> signIn(
    TextEditingController email,
    TextEditingController password,
    BuildContext context,
  ) async {
    UserCredential? user;
    try {
      user = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );
    } on FirebaseException catch (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${error.message}')));
      debugPrint('$error');
      user = null;
    }
    return user;
  }

  Future signUp(
    TextEditingController email,
    TextEditingController password,
    BuildContext context,
  ) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );
    } on FirebaseException catch (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${error.message}')));
      debugPrint('$error');
    }

    //context.go(context.namedLocation(Routes.homepage.name));
  }

  Future<User> getFirebaseUser() async {
    return FirebaseAuth.instance.currentUser!;
  }
}
