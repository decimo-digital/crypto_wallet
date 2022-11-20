// ignore_for_file: use_build_context_synchronously

import 'package:crypto_wallet/main.dart';
import 'package:crypto_wallet/service/api_connection.dart';
import 'package:crypto_wallet/utils/extensions.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
    return FutureBuilder(
      future: GetIt.instance.allReady(),
      builder: (context, snap) => snap.connectionState != ConnectionState.done
          ? const Center(child: CircularProgressIndicator())
          : Scaffold(
              appBar: AppBar(
                actions: [
                  TextButton(
                    onPressed: () => context.pushNamed(Routes.signup.name),
                    child: Text(context.localizations.signUp.toUpperCase()),
                  ),
                ],
              ),
              body: SafeArea(
                minimum:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      context.localizations.txtUseEmailPassword,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    AutofillGroup(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: context.localizations.hintEmail,
                                ),
                                autofillHints: const [AutofillHints.email],
                                autocorrect: false,
                                keyboardType: TextInputType.emailAddress,
                                controller: emailController,
                                textInputAction: TextInputAction.next,
                                validator: (email) {
                                  if (email!.isEmpty ||
                                      !EmailValidator.validate(email)) {
                                    return context
                                        .localizations.errInvalidEmail;
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
                                autofillHints: const [AutofillHints.password],
                                decoration: InputDecoration(
                                  hintText: context.localizations.hintPassword,
                                ),
                                autocorrect: false,
                                obscureText: true,
                                controller: passwordController,
                                validator: (psw) => psw!.isEmpty
                                    ? context.localizations.errEmptyPassword
                                    : null,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          try {
                            debugPrint('Logging in with firebase auth');
                            final credentials = await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                            )
                                .onError((error, stackTrace) {
                              debugPrint('Failed login: $error');
                              throw Exception(error);
                            });
                            debugPrint(
                              'Logged in as ${credentials.user?.email}',
                            );
                            GetIt.instance.get<ApiConnection>().getBalances();
                            context.goNamed(Routes.homepage.name);
                          } on FirebaseException catch (error) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('${error.message}')),
                            );
                            debugPrint('$error');
                          }
                          context
                              .go(context.namedLocation(Routes.homepage.name));
                        }
                      },
                      child: Text(context.localizations.signIn),
                    ),
                    Flexible(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Expanded(child: Divider()),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
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
                        onPressed: () async {
                          try {
                            final credential = await FirebaseAuth.instance
                                .signInWithProvider(GoogleAuthProvider());
                            debugPrint(
                              'logged in with ${credential.user?.uid}',
                            );
                            if (credential.user!.uid.isNotEmpty) {
                              context.go(
                                context.namedLocation(Routes.homepage.name),
                              );
                            }
                          } catch (e, s) {
                            debugPrint('Failed to request google login: $e');
                            debugPrintStack(stackTrace: s);
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset('assets/google_logo.png'),
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child:
                                  Text(context.localizations.btnGoogleSignIn),
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
                          child: Text(context.localizations.btnPassphraseLogin),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
