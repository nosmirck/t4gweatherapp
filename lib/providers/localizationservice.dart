import 'dart:async';

import 'package:flutter/foundation.dart' show SynchronousFuture;
import 'package:flutter/material.dart';

class AppLocalizationsDelegate
    extends LocalizationsDelegate<LocalizationsProvider> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'fr'].contains(locale.languageCode);

  @override
  Future<LocalizationsProvider> load(Locale locale) {
    LocalizationService.locale = locale;
    return SynchronousFuture<LocalizationsProvider>(
        LocalizationsProvider(locale));
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}

class LocalizationService {
  static Locale locale;
}

class LocalizationsProvider {
  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'title': 'T4G Weather',
    },
    'fr': {
      'title': 'T4G Météo',
    },
  };

  final Locale locale;

  LocalizationsProvider(this.locale);

  String get title {
    return _localizedValues[locale.languageCode]['title'];
  }

  static LocalizationsProvider of(BuildContext context) {
    return Localizations.of<LocalizationsProvider>(
        context, LocalizationsProvider);
  }
}
