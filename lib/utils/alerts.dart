import 'package:flutter/material.dart';

class CustomAlerts {
  static void showAlert(BuildContext context, String msg) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
}
