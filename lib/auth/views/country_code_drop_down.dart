import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_yalla_harek/auth/view_models/otp_view_mode.dart';
import 'package:flutter_yalla_harek/utils/colors.dart';
import 'package:flutter_yalla_harek/utils/const.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CountryCodeDropDown extends StatelessWidget {
  const CountryCodeDropDown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var otpViewModel = Provider.of<OtpViewModel?>(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          if (otpViewModel?.isLoading ?? false) return;

          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                    top: Radius.circular(MAIN_RADIUS * 2))),
            builder: (_) => SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                   Padding(
                    padding: const EdgeInsets.all(MAIN_PADDING),
                    child: Text(
                      "${AppLocalizations.of(context)?.choose_country_code}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xff4f4f4f),
                        fontSize: 18,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  CountryPickerCupertino(
                    backgroundColor: Colors.white,
                    itemBuilder: _buildCupertinoItem,
                    pickerSheetHeight: MediaQuery.of(context).size.height / 3,
                    pickerItemHeight: MediaQuery.of(context).size.height / 18,
                    initialCountry: otpViewModel?.country,
                    onValuePicked: (Country country) =>
                        otpViewModel?.country = country,
                    priorityList: [
                      CountryPickerUtils.getCountryByIsoCode('AE'),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
        child: Row(
          children: <Widget>[
            const SizedBox(width: MAIN_PADDING / 2),
            Text(
              "${otpViewModel?.country?.isoCode} +${otpViewModel?.country?.phoneCode}",
              style: const TextStyle(
                color: AppColors.COLOR_TEXT_GRAY,
                fontWeight: FontWeight.w700,
                fontSize: 13,
                fontFamily: 'Poppins',
              ),
            ),
            const Icon(Icons.keyboard_arrow_down_rounded,
                color: AppColors.COLOR_TEXT_GRAY),
            const SizedBox(width: MAIN_PADDING / 2),
          ],
        ),
      ),
    );
  }

  Widget _buildCupertinoItem(Country country) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: MAIN_PADDING),
      child: Center(
        child: Text(
          "${country.name} +${country.phoneCode}",
          style: const TextStyle(
            color: AppColors.COLOR_TEXT_GRAY,
            fontWeight: FontWeight.w700,
            fontSize: 15,
            fontFamily: 'Poppins',
          ),
        ),
      ),
    );
  }
}
