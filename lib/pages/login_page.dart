// ignore_for_file: use_build_context_synchronously

import 'package:crypto_wallet/main.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../service/data_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final service = DataService();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () => context.pushNamed(Routes.signup.name),
            child: const Text('SIGNUP'),
          ),
        ],
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Use email and password',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Email',
                      ),
                      controller: emailController,
                      validator: (email) {
                        if (email!.isEmpty || !EmailValidator.validate(email)) {
                          return 'Enter a valid mail';
                        }
                        return null;
                      },
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                    ),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Password',
                      ),
                      obscureText: true,
                      controller: passwordController,
                      validator: (psw) =>
                          psw!.isEmpty ? 'Enter a password' : null,
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  final user = await service.signIn(
                    emailController,
                    passwordController,
                    context,
                  );
                  if (user != null) {
                    context.go(context.namedLocation(Routes.homepage.name));
                  }
                }
              },
              child: const Text('Login'),
            ),
            Flexible(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Expanded(child: Divider()),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      'or',
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
                    const Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text('Login with Google'),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: TextButton(
                  onPressed: () async {
                    context.pushNamed(Routes.decentralizedLogin.name);
                  },
                  child: const Text('Continue with passphrase'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
