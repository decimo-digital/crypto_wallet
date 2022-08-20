import 'dart:async';

import 'package:crypto_wallet/utils/passphrase_generator.dart';
import 'package:flutter/material.dart';

class DecentralizedSignup extends StatefulWidget {
  const DecentralizedSignup({super.key});

  @override
  State<DecentralizedSignup> createState() => _DecentralizedSignupState();
}

class _DecentralizedSignupState extends State<DecentralizedSignup> {
  final _wordsCompleter = Completer<List<String>>();

  @override
  void initState() {
    super.initState();
    generatePassphrase().then((words) => _wordsCompleter.complete(words));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
      ),
      child: Column(
        children: [
          Text(
            'Save these words as it will be the only way you can redover your wallet.',
            style: Theme.of(context).textTheme.bodyText1,
            textAlign: TextAlign.center,
          ),
          FutureBuilder<List<String>>(
            future: _wordsCompleter.future,
            builder: (context, snap) {
              if (snap.connectionState != ConnectionState.done) {
                return const CircularProgressIndicator();
              }

              final words = snap.data!;

              return Container(
                constraints: BoxConstraints.loose(const Size(500, 280)),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: const EdgeInsets.symmetric(vertical: 20),
                padding: const EdgeInsets.all(10),
                child: GridView.extent(
                  maxCrossAxisExtent: 150,
                  childAspectRatio: 1.7,
                  children: words.map((w) => Chip(label: Text(w))).toList(),
                ),
              );
            },
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Continue'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
