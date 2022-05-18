import 'package:flutter/material.dart';
import 'package:flutter_yalla_harek/auth/service/auth_service.dart';
import 'package:flutter_yalla_harek/auth/view_models/otp_view_mode.dart';
import 'package:flutter_yalla_harek/utils/alerts.dart';
import 'package:flutter_yalla_harek/utils/colors.dart';
import 'package:flutter_yalla_harek/utils/const.dart';
import 'package:flutter_yalla_harek/utils/loading.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SMSCodeInput extends StatefulWidget {
  const SMSCodeInput({Key? key}) : super(key: key);

  @override
  State<SMSCodeInput> createState() => _SMSCodeInputState();
}

class _SMSCodeInputState extends State<SMSCodeInput> {
  final pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    OtpViewModel? otpViewModel = Provider.of(context);

    final defaultPinTheme = PinTheme(
      height: 50,
      width: 50,
      textStyle: const TextStyle(fontSize: 20),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.COLOR_LIGHT_GRAY),
        borderRadius: BorderRadius.circular(MAIN_RADIUS),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Theme.of(context).primaryColor),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      textStyle: TextStyle(fontSize: 20, color: Theme.of(context).primaryColor),
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Theme.of(context).primaryColor.withOpacity(0.1),
      ),
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "${AppLocalizations.of(context)?.otp_sent}",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline6,
        ),
        const SizedBox(height: MAIN_PADDING),
        Pinput(
          length: 6,
          controller: pinController,
          androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsRetrieverApi,
          onCompleted: (pin) {
            Loading(
              context: context,
              action: () async {
                var user = await AuthService()
                    .authPhone(otpViewModel?.verificationId ?? '', pin);
                Navigator.pop(context);
                if (user == null) {
                  CustomAlerts.showAlert(context,
                      "${AppLocalizations.of(context)?.incorrect_code}");
                }
              },
            ).showLoadingWithAction();
          },
          defaultPinTheme: defaultPinTheme,
          focusedPinTheme: focusedPinTheme,
          submittedPinTheme: submittedPinTheme,
        ),
        const SizedBox(height: MAIN_PADDING),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${AppLocalizations.of(context)?.didnot_sent}",
              style: Theme.of(context).textTheme.bodyText1,
            ),
            TextButton(
              onPressed: () async {
                OtpViewModel? signInOtpViewModel = Provider.of(
                  context,
                  listen: false,
                );

                var phoneNumber =
                    "+${signInOtpViewModel?.country?.phoneCode}${signInOtpViewModel?.phone}";
                await AuthService().verifyPhone(phoneNumber, (id) {
                  Navigator.pop(context);
                  signInOtpViewModel?.verificationId = id;
                }, (e) {});
              },
              child: Text("${AppLocalizations.of(context)?.resend}"),
            )
          ],
        ),
      ],
    );
  }
}
