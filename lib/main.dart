import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_yalla_harek/auth/service/auth_service.dart';
import 'package:flutter_yalla_harek/auth/view_models/otp_view_mode.dart';
import 'package:flutter_yalla_harek/home/view_models/home_search_filter.dart';
import 'package:flutter_yalla_harek/l10n/l10n.dart';
import 'package:flutter_yalla_harek/l10n/locale_provider.dart';
import 'package:flutter_yalla_harek/utils/colors.dart';
import 'package:flutter_yalla_harek/wrapper/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isIOS) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyC5cLlCTpKenZI2eD5xOxbOw-Bsoj21rn8",
          authDomain: "yallaharek-a562a.firebaseapp.com",
          projectId: "yallaharek-a562a",
          storageBucket: "yallaharek-a562a.appspot.com",
          messagingSenderId: "876131463885",
          appId: "1:876131463885:ios:00e8303fc3a9aaf9936f84"),
    );
  } else {
    await Firebase.initializeApp();
  }

  await LocaleProvider().fetch();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => OtpViewModel()),
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
        ChangeNotifierProvider(create: (_) => HomeSearchSort()),
        StreamProvider<User?>.value(
          initialData: null,
          value: AuthService().user,
        ),
      ],
      builder: (context, child) {
        LocaleProvider? locale = Provider.of(context);
        return MaterialApp(
          title: "Yalla Harek",
          theme: ThemeData(
            primarySwatch: AppColors.primaryColors,
            primaryColor: AppColors.primaryColors,
            textSelectionTheme: const TextSelectionThemeData(
              cursorColor: AppColors.primaryColors,
              selectionColor: AppColors.primaryColors,
              selectionHandleColor: AppColors.primaryColors,
            ),
            colorScheme: ColorScheme.fromSwatch().copyWith(
              secondary: AppColors.primaryColors,
            ),
            fontFamily: 'Poppins',
            textTheme: const TextTheme(
              headline1: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.w700,
                color: AppColors.primaryColors,
              ),
              headline2: TextStyle(
                fontSize: 20.0,
                color: AppColors.primaryColors,
              ),
              headline6: TextStyle(
                fontSize: 18.0,
                color: Color(0xff8c8c8c),
                fontWeight: FontWeight.w600,
                height: 1.5,
              ),
              bodyText1: TextStyle(
                fontSize: 15.0,
                color: AppColors.COLOR_ARC_GRAY,
              ),
              bodyText2: TextStyle(
                fontSize: 18.0,
                color: AppColors.COLOR_ARC_GRAY,
              ),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                primary: AppColors.primaryColors,
                textStyle: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: AppColors.COLOR_SECONDARY,
                textStyle: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            indicatorColor: AppColors.primaryColors,
          ),
          home: const Wrapper(),
          supportedLocales: L10n.all,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          locale: locale?.locale,
        );
      },
    );
  }
}
