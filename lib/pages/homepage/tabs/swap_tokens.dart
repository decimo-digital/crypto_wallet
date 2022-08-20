import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SwapTokens extends StatefulWidget {
  const SwapTokens({super.key});

  @override
  State<SwapTokens> createState() => _SwapTokensState();
}

class _SwapTokensState extends State<SwapTokens> {
  final _topSelected = ValueNotifier(_tokens.first.icon);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            helperText: '0.0005 BTC',
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ValueListenableBuilder<IconData>(
                    valueListenable: _topSelected,
                    builder: (context, value, _) => DropdownButton<IconData>(
                      items: _tokens
                          .map(
                            (t) => DropdownMenuItem<IconData>(
                              value: t.icon,
                              alignment: Alignment.center,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(t.icon, color: Colors.black),
                                  Text(
                                    t.name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (val) => _topSelected.value = val ?? value,
                      alignment: Alignment.center,
                      underline: Container(),
                      itemHeight: kMinInteractiveDimension,
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.black,
                      ),
                      dropdownColor: Colors.white,
                      value: value,
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 40,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Icon(
            FontAwesomeIcons.arrowRightArrowLeft,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        TextField(
          decoration: InputDecoration(
            helperText: '0.0005 BTC',
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ValueListenableBuilder<IconData>(
                    valueListenable: _topSelected,
                    builder: (context, value, _) => DropdownButton<IconData>(
                      items: _tokens
                          .map(
                            (t) => DropdownMenuItem<IconData>(
                              value: t.icon,
                              alignment: Alignment.center,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(t.icon, color: Colors.black),
                                  Text(
                                    t.name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (val) => _topSelected.value = val ?? value,
                      alignment: Alignment.center,
                      underline: Container(),
                      itemHeight: kMinInteractiveDimension,
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.black,
                      ),
                      dropdownColor: Colors.white,
                      value: value,
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 40,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Swap'),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class Token {
  final IconData icon;
  final String name;

  const Token(this.icon, this.name);
}

const _tokens = [
  Token(FontAwesomeIcons.bitcoin, 'BTC'),
  Token(FontAwesomeIcons.ethereum, 'ETH'),
];
