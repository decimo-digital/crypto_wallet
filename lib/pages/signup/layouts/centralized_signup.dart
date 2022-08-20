import 'package:flutter/material.dart';

class CentralizedSignup extends StatefulWidget {
  const CentralizedSignup({super.key});

  @override
  State<CentralizedSignup> createState() => _CentralizedSignupState();
}

class _CentralizedSignupState extends State<CentralizedSignup> {
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: .7,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'Email and password registration',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: TextField(
              decoration: InputDecoration(hintText: 'Email'),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: TextField(
              decoration: InputDecoration(hintText: 'Password'),
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Register'),
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
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 50,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                primary: Colors.white,
                onPrimary: Colors.black.withOpacity(.56),
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
                    child: Text('Register with Google'),
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
