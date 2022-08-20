import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
                'Write here the words you saved while creating your wallet.',
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
                  onPressed: () {},
                  child: const Text('Continue'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
