import 'package:crypto_wallet/main.dart';
import 'package:crypto_wallet/utils/extensions.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CentralizedSignup extends StatefulWidget {
  const CentralizedSignup({super.key});

  @override
  State<CentralizedSignup> createState() => _CentralizedSignupState();
}

class _CentralizedSignupState extends State<CentralizedSignup> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: .7,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            context.localizations.txtEmailPasswordSignup,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: context.localizations.hintEmail,
                    ),
                    controller: _emailController,
                    validator: (email) =>
                        email != null && !EmailValidator.validate(email)
                            ? context.localizations.errInvalidEmail
                            : null,
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 10)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: context.localizations.hintPassword,
                    ),
                    controller: _passwordController,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              try {
                await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: _emailController.text.trim(),
                  password: _passwordController.text.trim(),
                );
                if (mounted) {
                  context.go(context.namedLocation(Routes.homepage.name));
                }
              } on FirebaseException catch (error) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('${error.message}')));
                debugPrint('$error');
              }
            },
            child: Text(context.localizations.signUp),
          ),
          Flexible(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Expanded(child: Divider()),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: Text(
                    context.localizations.or,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                const Expanded(child: Divider()),
              ],
            ),
          ),
          ElevatedButtonTheme(
            data: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black.withOpacity(.56),
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                backgroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 50,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            child: ElevatedButton(
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/google_logo.png'),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(context.localizations.btnGoogleSignUp),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
