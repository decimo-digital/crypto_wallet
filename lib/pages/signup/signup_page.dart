import 'package:crypto_wallet/pages/signup/layouts/centralized_signup.dart';
import 'package:crypto_wallet/pages/signup/layouts/decentralized_signup.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _classicWallet = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signup'),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(20),
        child: SizedBox.expand(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.info_outline),
                  ),
                  Text(
                    'Create classic wallet',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  ValueListenableBuilder<bool>(
                    valueListenable: _classicWallet,
                    builder: (context, value, _) => Switch.adaptive(
                      value: value,
                      onChanged: (val) => _classicWallet.value = val,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ValueListenableBuilder<bool>(
                  valueListenable: _classicWallet,
                  builder: (context, value, _) {
                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      switchInCurve: Curves.easeInOut,
                      switchOutCurve: Curves.easeInOut,
                      child: value
                          ? const DecentralizedSignup()
                          : const CentralizedSignup(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
