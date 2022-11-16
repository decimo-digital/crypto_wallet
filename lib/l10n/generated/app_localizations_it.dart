import 'app_localizations.dart';

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get dateFormat => 'dd/MM';

  @override
  String get btnContinue => 'Continua';

  @override
  String get lblFavourites => 'Favoriti';

  @override
  String get txtNoFavouritesYet => 'Non hai preferiti';

  @override
  String get signUp => 'Registrati';

  @override
  String get txtUseEmailPassword => 'Usa email e password';

  @override
  String get hintEmail => 'Email';

  @override
  String get errInvalidEmail => 'Inserisci una email valida';

  @override
  String get hintPassword => 'Password';

  @override
  String get errEmptyPassword => 'Inserisci una password';

  @override
  String get signIn => 'Accedi';

  @override
  String get or => 'oppure';

  @override
  String get btnGoogleSignIn => 'Accedi con Google';

  @override
  String get btnGoogleSignUp => 'Registrati con Google';

  @override
  String get btnPassphraseLogin => 'Continua con la passphrase';

  @override
  String get lblSettings => 'Impostazioni';

  @override
  String get hintName => 'Qual è il tuo nome?';

  @override
  String get btnLogout => 'Esci';

  @override
  String get hintPassphraseLogin => 'Scrivi nel box qua sotto le parole che hai salvato quando hai creato il tuo wallet';

  @override
  String get hintSavePassphrase => 'Salvati queste parole perchè saranno l\'unico modo per recuperare il tuo wallet';

  @override
  String get lblSinceLastPurchase => 'Dall\'ultimo acquisto';

  @override
  String get btnPurchase => 'Acquista';

  @override
  String get lblClassicWallet => 'Crea un wallet classico';

  @override
  String get txtEmailPasswordSignup => 'Registrazione con email e password';

  @override
  String get tabHome => 'Homepage';

  @override
  String get swap => 'Scambia';

  @override
  String get purchasesList => 'Acquisti';

  @override
  String get txtNoPurchasesYet => 'Ancora nessun acquisto';

  @override
  String get timeStartHelp => 'Seleziona l\'ora di inizio per tracciare l\'andamento della moneta';

  @override
  String get timeEndHelp => 'Seleziona l\'ora di fine per tracciare l\'andamento della moneta';

  @override
  String priceChange(Object from, Object to) {
    return 'Dal $from al $to';
  }
}
