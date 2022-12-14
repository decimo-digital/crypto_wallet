import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:crypto_wallet/main.dart';
import 'package:crypto_wallet/service/api_connection.dart';
import 'package:crypto_wallet/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class DecentralizedSignin extends StatefulWidget {
  const DecentralizedSignin({super.key});

  @override
  State<DecentralizedSignin> createState() => _DecentralizedSigninState();
}

class _DecentralizedSigninState extends State<DecentralizedSignin> {
  final _words = ValueNotifier(<String>[]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text(
                context.localizations.hintPassphraseLogin,
                style: Theme.of(context).textTheme.bodyText1,
                textAlign: TextAlign.center,
              ),
            ),
            Flexible(
              child: ValueListenableBuilder<List<String>>(
                valueListenable: _words,
                builder: (context, value, _) => Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  constraints: BoxConstraints.loose(const Size(500, 280)),
                  child: GridView.extent(
                    physics: const NeverScrollableScrollPhysics(),
                    maxCrossAxisExtent: 150,
                    childAspectRatio: 1.7,
                    children: [
                      ...value
                          .map(
                            (w) => Chip(
                              label: Text(w),
                              onDeleted: () => _words.value = [..._words.value]
                                ..removeWhere((element) => element == w),
                            ),
                          )
                          .toList(),
                      if (value.length < 12)
                        Chip(
                          label: EditableText(
                            focusNode: FocusNode()..requestFocus(),
                            cursorColor: Theme.of(context).colorScheme.primary,
                            style: Theme.of(context).chipTheme.labelStyle!,
                            controller: TextEditingController(),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(8),
                            ],
                            backgroundCursorColor: Colors.white,
                            onSubmitted: (label) {
                              if (label.length >= 3) {
                                _words.value = [..._words.value, label];
                              }
                            },
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: () async {
                    final words = _words.value;
                    final uid = base64Encode(
                      sha256.convert(utf8.encode(words.join())).bytes,
                    );

                    final response = await GetIt.instance
                        .get<ApiConnection>()
                        .validateUid(uid);
                    if (response && mounted) {
                      context.goNamed(Routes.homepage.name);
                    }
                  },
                  child: Text(context.localizations.btnContinue),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
