import 'package:flutter/material.dart';
import 'package:flutter_yalla_harek/auth/service/auth_service.dart';
import 'package:flutter_yalla_harek/auth/view_models/otp_view_mode.dart';
import 'package:flutter_yalla_harek/l10n/l10n.dart';
import 'package:flutter_yalla_harek/l10n/locale_provider.dart';
import 'package:provider/provider.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsDialog extends StatelessWidget {
  const SettingsDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LocaleProvider? locale = Provider.of(context);

    return AlertDialog(
      content: Wrap(children: [
        Text(
          "${AppLocalizations.of(context)?.settings}",
          style: Theme.of(context).textTheme.headline2,
        ),
        const Divider(),
        RadioButton<Locale>(
          description: 'English',
          value: L10n.all[0],
          groupValue: locale?.locale ?? const Locale('en'),
          onChanged: (Locale? item) {
            locale?.locale = const Locale('en');
          },
        ),
        RadioButton<Locale>(
          description: 'العربية',
          value: L10n.all[1],
          groupValue: locale?.locale ?? const Locale('en'),
          onChanged: (Locale? item) {
            locale?.locale = const Locale('ar');
          },
        ),
        TextButton(
            onPressed: () {
              OtpViewModel? otp = Provider.of(context, listen: false);
              otp?.verificationId = null;
              AuthService().signOut();
              Navigator.pop(context);
            },
            child: Text("${AppLocalizations.of(context)?.sign_out}")),
      ]),
    );
  }
}
