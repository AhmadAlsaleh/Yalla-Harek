import 'package:flutter/material.dart';
import 'package:flutter_yalla_harek/auth/view_models/otp_view_mode.dart';
import 'package:flutter_yalla_harek/auth/views/country_code_drop_down.dart';
import 'package:flutter_yalla_harek/utils/colors.dart';
import 'package:flutter_yalla_harek/utils/const.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PhoneInputWidget extends StatelessWidget {
  const PhoneInputWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var signInOtpViewModel = Provider.of<OtpViewModel?>(context);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(MAIN_RADIUS),
        border: Border.all(
          color: AppColors.COLOR_LIGHT_GRAY,
          width: 1,
        ),
        color: Colors.white,
      ),
      child: Row(
        children: [
          const SizedBox(width: MAIN_PADDING / 2),
          Icon(
            Icons.call,
            color: Theme.of(context).primaryColor,
          ),
          const SizedBox(width: MAIN_PADDING / 2),
          Container(
            height: 25.0,
            width: 1,
            color: AppColors.COLOR_LIGHT_GRAY,
          ),
          const CountryCodeDropDown(),
          Container(
            height: 25.0,
            width: 1,
            color: AppColors.COLOR_LIGHT_GRAY,
          ),
          Expanded(
            child: TextField(
              keyboardType: TextInputType.phone,
              onChanged: (value) => signInOtpViewModel?.phone = value,
              style: const TextStyle(
                color: Color(0xff4c4c4c),
                fontSize: 16,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w700,
              ),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  enabled: signInOtpViewModel?.isLoading == false,
                  hintStyle: const TextStyle(
                    color: Color(0xffbdbdbd),
                    fontSize: 15,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w700,
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: MAIN_PADDING / 2),
                  hintText: "${AppLocalizations.of(context)?.phone}"),
            ),
          ),
        ],
      ),
    );
  }
}
