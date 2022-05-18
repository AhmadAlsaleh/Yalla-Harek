import 'package:flutter/material.dart';
import 'package:flutter_yalla_harek/auth/service/auth_service.dart';
import 'package:flutter_yalla_harek/auth/view_models/otp_view_mode.dart';
import 'package:flutter_yalla_harek/utils/alerts.dart';
import 'package:flutter_yalla_harek/utils/const.dart';
import 'package:flutter_yalla_harek/utils/loading.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SigInActionWidget extends StatelessWidget {
  const SigInActionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(MAIN_PADDING / 2)),
      onPressed: () async {
        OtpViewModel? signIn = Provider.of(
          context,
          listen: false,
        );
        if ((signIn?.phone ?? '').isEmpty) {
          CustomAlerts.showAlert(
              context, "${AppLocalizations.of(context)?.phone}");
          return;
        }

        Loading(
          context: context,
          action: () => _otpPhoneAction(context),
        ).showLoadingWithAction();
      },
      child: Text(
        "${AppLocalizations.of(context)?.submit}",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontFamily: "Poppins",
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  _otpPhoneAction(BuildContext context) async {
    OtpViewModel? signInOtpViewModel = Provider.of(
      context,
      listen: false,
    );

    var phoneNumber =
        "+${signInOtpViewModel?.country?.phoneCode}${signInOtpViewModel?.phone}";
    await AuthService().verifyPhone(phoneNumber, (verificationId) {
      Navigator.pop(context);
      signInOtpViewModel?.isLoading = false;
      signInOtpViewModel?.verificationId = verificationId;
    }, (error) {
      Navigator.pop(context);
      signInOtpViewModel?.isLoading = false;
      signInOtpViewModel?.verificationId = null;
      CustomAlerts.showAlert(context, "${AppLocalizations.of(context)?.wrong}");
    });
  }
}
