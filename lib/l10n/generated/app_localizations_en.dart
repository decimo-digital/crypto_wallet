import 'app_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get dateFormat => 'MM/dd';

  @override
  String get btnContinue => 'Continue';

  @override
  String get lblFavourites => 'Favourites';

  @override
  String get txtNoFavouritesYet => 'You don\'t have any favourites yet';

  @override
  String get signUp => 'Sign up';

  @override
  String get txtUseEmailPassword => 'Use email and password';

  @override
  String get hintEmail => 'Email';

  @override
  String get errInvalidEmail => 'Insert a valid email';

  @override
  String get hintPassword => 'Password';

  @override
  String get errEmptyPassword => 'Insert a password';

  @override
  String get signIn => 'Sign in';

  @override
  String get or => 'or';

  @override
  String get btnGoogleSignIn => 'Login with Google';

  @override
  String get btnGoogleSignUp => 'Sign up with Google';

  @override
  String get btnPassphraseLogin => 'Continue with passphrase';

  @override
  String get lblSettings => 'Settings';

  @override
  String get hintName => 'What\'s your name?';

  @override
  String get btnLogout => 'Logout';

  @override
  String get hintPassphraseLogin => 'Write here the words you saved while creating your wallet';

  @override
  String get hintSavePassphrase => 'Save these words as they will the only way to restore your wallet';

  @override
  String get lblSinceLastPurchase => 'From the last purchase';

  @override
  String get btnPurchase => 'Purchase';

  @override
  String get lblClassicWallet => 'Create a classic wallet';

  @override
  String get txtEmailPasswordSignup => 'Email and password sign up';

  @override
  String get tabHome => 'Homepage';

  @override
  String get swap => 'Swao';
}
