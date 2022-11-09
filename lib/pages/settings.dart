import 'package:crypto_wallet/main.dart';
import 'package:crypto_wallet/utils/extensions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.localizations.lblSettings)),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.center,
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                  ),
                  child: const Icon(Icons.person),
                ),
                Positioned(
                  bottom: -15,
                  right: -15,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                    child: TextButton(
                      onPressed: () {},
                      child: const Icon(Icons.edit),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: TextField(
                decoration: InputDecoration(
                  hintText: context.localizations.hintName,
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    context.goNamed(Routes.login.name);
                  },
                  child: Text(context.localizations.btnLogout),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
