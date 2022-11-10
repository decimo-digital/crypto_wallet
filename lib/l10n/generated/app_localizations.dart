import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_it.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('it')
  ];

  /// No description provided for @dateFormat.
  ///
  /// In it, this message translates to:
  /// **'dd/MM'**
  String get dateFormat;

  /// No description provided for @btnContinue.
  ///
  /// In it, this message translates to:
  /// **'Continua'**
  String get btnContinue;

  /// No description provided for @lblFavourites.
  ///
  /// In it, this message translates to:
  /// **'Favoriti'**
  String get lblFavourites;

  /// No description provided for @txtNoFavouritesYet.
  ///
  /// In it, this message translates to:
  /// **'Non hai preferiti'**
  String get txtNoFavouritesYet;

  /// No description provided for @signUp.
  ///
  /// In it, this message translates to:
  /// **'Registrati'**
  String get signUp;

  /// No description provided for @txtUseEmailPassword.
  ///
  /// In it, this message translates to:
  /// **'Usa email e password'**
  String get txtUseEmailPassword;

  /// No description provided for @hintEmail.
  ///
  /// In it, this message translates to:
  /// **'Email'**
  String get hintEmail;

  /// No description provided for @errInvalidEmail.
  ///
  /// In it, this message translates to:
  /// **'Inserisci una email valida'**
  String get errInvalidEmail;

  /// No description provided for @hintPassword.
  ///
  /// In it, this message translates to:
  /// **'Password'**
  String get hintPassword;

  /// No description provided for @errEmptyPassword.
  ///
  /// In it, this message translates to:
  /// **'Inserisci una password'**
  String get errEmptyPassword;

  /// No description provided for @signIn.
  ///
  /// In it, this message translates to:
  /// **'Accedi'**
  String get signIn;

  /// No description provided for @or.
  ///
  /// In it, this message translates to:
  /// **'oppure'**
  String get or;

  /// No description provided for @btnGoogleSignIn.
  ///
  /// In it, this message translates to:
  /// **'Accedi con Google'**
  String get btnGoogleSignIn;

  /// No description provided for @btnGoogleSignUp.
  ///
  /// In it, this message translates to:
  /// **'Registrati con Google'**
  String get btnGoogleSignUp;

  /// No description provided for @btnPassphraseLogin.
  ///
  /// In it, this message translates to:
  /// **'Continua con la passphrase'**
  String get btnPassphraseLogin;

  /// No description provided for @lblSettings.
  ///
  /// In it, this message translates to:
  /// **'Impostazioni'**
  String get lblSettings;

  /// No description provided for @hintName.
  ///
  /// In it, this message translates to:
  /// **'Qual è il tuo nome?'**
  String get hintName;

  /// No description provided for @btnLogout.
  ///
  /// In it, this message translates to:
  /// **'Esci'**
  String get btnLogout;

  /// No description provided for @hintPassphraseLogin.
  ///
  /// In it, this message translates to:
  /// **'Scrivi nel box qua sotto le parole che hai salvato quando hai creato il tuo wallet'**
  String get hintPassphraseLogin;

  /// No description provided for @hintSavePassphrase.
  ///
  /// In it, this message translates to:
  /// **'Salvati queste parole perchè saranno l\'unico modo per recuperare il tuo wallet'**
  String get hintSavePassphrase;

  /// No description provided for @lblSinceLastPurchase.
  ///
  /// In it, this message translates to:
  /// **'Dall\'ultimo acquisto'**
  String get lblSinceLastPurchase;

  /// No description provided for @btnPurchase.
  ///
  /// In it, this message translates to:
  /// **'Acquista'**
  String get btnPurchase;

  /// No description provided for @lblClassicWallet.
  ///
  /// In it, this message translates to:
  /// **'Crea un wallet classico'**
  String get lblClassicWallet;

  /// No description provided for @txtEmailPasswordSignup.
  ///
  /// In it, this message translates to:
  /// **'Registrazione con email e password'**
  String get txtEmailPasswordSignup;

  /// No description provided for @tabHome.
  ///
  /// In it, this message translates to:
  /// **'Homepage'**
  String get tabHome;

  /// No description provided for @swap.
  ///
  /// In it, this message translates to:
  /// **'Scambia'**
  String get swap;

  /// No description provided for @purchasesList.
  ///
  /// In it, this message translates to:
  /// **'Acquisti'**
  String get purchasesList;

  /// No description provided for @txtNoPurchasesYet.
  ///
  /// In it, this message translates to:
  /// **'Ancora nessun acquisto'**
  String get txtNoPurchasesYet;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'it'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'it': return AppLocalizationsIt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
