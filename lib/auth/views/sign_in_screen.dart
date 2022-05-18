import 'package:flutter/material.dart';
import 'package:flutter_yalla_harek/auth/view_models/otp_view_mode.dart';
import 'package:flutter_yalla_harek/auth/views/phone_input_widget.dart';
import 'package:flutter_yalla_harek/auth/views/signin_action.dart';
import 'package:flutter_yalla_harek/auth/views/sms_code.dart';
import 'package:flutter_yalla_harek/utils/const.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OtpViewModel? signInOtpViewModel = Provider.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(MAIN_PADDING),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: Container()),
              Text(
                "${AppLocalizations.of(context)?.sign_in}",
                style: Theme.of(context).textTheme.headline1,
              ),
              Text(
                "${AppLocalizations.of(context)?.slug}",
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(height: MAIN_PADDING * 2),
              const PhoneInputWidget(),
              const SizedBox(height: MAIN_PADDING * 2),
              if (signInOtpViewModel?.verificationId?.isNotEmpty == true)
                const SMSCodeInput(),
              Expanded(child: Container(), flex: 2),
              const SigInActionWidget(),
              const SizedBox(height: MAIN_PADDING / 2),
            ],
          ),
        ),
      ),
    );
  }
}
