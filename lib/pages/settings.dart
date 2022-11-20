import 'dart:io';

import 'package:crypto_wallet/main.dart';
import 'package:crypto_wallet/service/cache_service.dart';
import 'package:crypto_wallet/utils/extensions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  File? profilePic;
  final profPic = ValueNotifier(File);

  Future pickImg() async {
    final img = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (img == null) return;

    final imgTemp = File(img.path);
    setState(() => profilePic = imgTemp);
  }

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
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                  ),
                  child: profilePic != null
                      ? ClipOval(
                          child: Image.file(
                            profilePic!,
                            fit: BoxFit.cover,
                          ),
                        )
                      : const Icon(Icons.person),
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
                      onPressed: () {
                        pickImg();
                      },
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
                  onPressed: () async {
                    GetIt.instance.get<CacheService>().deleteBox();
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
