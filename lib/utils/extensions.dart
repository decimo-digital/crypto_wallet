import 'package:crypto_wallet/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  AppLocalizations get localizations {
    final localizations = AppLocalizations.of(this);
    assert(localizations != null);
    return localizations!;
  }
}
