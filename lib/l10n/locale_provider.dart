import 'package:flutter/material.dart';
import 'package:flutter_yalla_harek/l10n/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale = const Locale('en');

  Locale get locale => _locale;

  set locale(Locale value) {
    if (!L10n.all.contains(value)) return;
    _saveLocale(value);

    _locale = value;
    notifyListeners();
  }

  fetch() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String localeCode = preferences.getString('lang') ?? 'en';
    locale = Locale(localeCode);
  }

  Future<void> _saveLocale(Locale value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('lang', value.languageCode);
  }
}
