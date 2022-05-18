import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/material.dart';

class OtpViewModel extends ChangeNotifier {
  Country? _country = CountryPickerUtils.getCountryByIsoCode("ae");
  String? _phone;
  String? _verificationId;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Country? get country => _country;

  set country(Country? value) {
    _country = value;
    notifyListeners();
  }

  String? get phone => _phone;

  set phone(String? value) {
    _phone = value;
    notifyListeners();
  }

  String? get verificationId => _verificationId;

  set verificationId(String? value) {
    _verificationId = value;
    notifyListeners();
  }
}
