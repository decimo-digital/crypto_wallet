import 'package:crypto_wallet/model/favorite_tokens.dart';
import 'package:crypto_wallet/pages/coin_details.dart';
import 'package:crypto_wallet/pages/decentralized_signin.dart';
import 'package:crypto_wallet/pages/homepage/homepage.dart';
import 'package:crypto_wallet/pages/login_page.dart';
import 'package:crypto_wallet/pages/settings.dart';
import 'package:crypto_wallet/pages/signup/signup_page.dart';
import 'package:crypto_wallet/utils/short_it_lookup_messages.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:timeago/timeago.dart';
import 'package:firebase_core/firebase_core.dart';

enum Routes {
  login._('login'),
  decentralizedLogin._('decentralized'),
  signup._('signup'),
  homepage._('homepage'),
  settings._('settings'),
  coinDetails._('details');

  const Routes._(this.name);

  final String name;
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setLocaleMessages('it', ShortLookupItMessages());
  await Hive.initFlutter();
  Hive.registerAdapter(FavoriteTokensAdapter());

  await Hive.openBox<FavoriteTokens>('favoriteTokensBox');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _router = GoRouter(
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/',
        redirect: (state) => '/login',
      ),
      GoRoute(
        name: Routes.login.name,
        path: '/login',
        builder: (context, state) => const LoginPage(),
        routes: [
          GoRoute(
            name: Routes.decentralizedLogin.name,
            path: 'decentralized',
            builder: (context, state) => const DecentralizedSignin(),
          )
        ],
      ),
      GoRoute(
        name: Routes.signup.name,
        path: '/signup',
        builder: (context, state) => const SignupPage(),
      ),
      GoRoute(
        name: Routes.homepage.name,
        path: '/homepage',
        builder: (context, state) => const Homepage(),
        routes: [
          GoRoute(
            name: Routes.settings.name,
            path: 'settings',
            builder: (context, state) => const Settings(),
          ),
          GoRoute(
            name: Routes.coinDetails.name,
            path: ':coin',
            builder: (context, state) => CoinDetails(
              coinId: state.params['coin']!,
            ),
          )
        ],
      )
    ],
    initialLocation: '/login',
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: _router.routerDelegate,
      routeInformationParser: _router.routeInformationParser,
      routeInformationProvider: _router.routeInformationProvider,
      title: 'Cryptowallet',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: const ColorScheme(
          brightness: Brightness.dark,
          primary: Color(0xFFEE6C4D),
          background: Color(0xFF293241),
          surface: Color(0xFF293241),
          secondary: Color(0xFFEE6C4D),
          onPrimary: Colors.white,
          onSurface: Colors.white,
          onBackground: Colors.white,
          onSecondary: Colors.black,
          onError: Colors.white,
          error: Colors.red,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            textStyle: GoogleFonts.montserrat(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
              color: Colors.white,
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: GoogleFonts.montserrat(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          prefixStyle: GoogleFonts.montserrat(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderSide: const BorderSide(style: BorderStyle.none),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(style: BorderStyle.none),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 70,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        dividerTheme: const DividerThemeData(
          color: Colors.white,
          thickness: .8,
        ),
        scaffoldBackgroundColor: const Color(0xFF293241),
        textTheme: GoogleFonts.montserratTextTheme(
          const TextTheme(
            bodyText1: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
            subtitle1: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            bodyText2: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        tabBarTheme: TabBarTheme(
          indicator: const BoxDecoration(),
          labelStyle: GoogleFonts.montserrat(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: GoogleFonts.montserrat(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
          labelColor: const Color(0xFFEE6C4D),
          unselectedLabelColor: Colors.white,
          indicatorSize: TabBarIndicatorSize.tab,
        ),
        switchTheme: SwitchThemeData(
          thumbColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return const Color(0xFFE0E0E0);
            }
            return const Color(0xFF828282);
          }),
          trackColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return const Color(0xFF27AE60);
            }
            return Colors.white;
          }),
        ),
        chipTheme: ChipThemeData(
          labelStyle: GoogleFonts.montserrat(
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
        ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          foregroundColor: Colors.white,
          centerTitle: false,
          elevation: 0,
        ),
        cardTheme: CardTheme(
          color: const Color(0xFFE4E4E4),
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        listTileTheme: const ListTileThemeData(
          textColor: Colors.black,
          iconColor: Color(0xFFEE6C4D),
        ),
      ),
    );
  }
}
