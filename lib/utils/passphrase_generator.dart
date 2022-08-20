import 'dart:math';

import 'package:flutter/services.dart';

Future<List<String>> _retrieveWords() async {
  final textData = await rootBundle.loadString('assets/passphrase_words.txt');
  final words = textData.split('\n');
  assert(words.length == 2048);
  return words;
}

Future<List<String>> generatePassphrase({int length = 12}) async {
  final words = await _retrieveWords();
  final rand = Random.secure();
  final randomWords = List.generate(
    length,
    (index) => rand.nextInt(words.length),
  );
  return randomWords.map((i) => words[i]).toList();
}
