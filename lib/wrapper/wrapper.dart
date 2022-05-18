import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_yalla_harek/auth/views/sign_in_screen.dart';
import 'package:flutter_yalla_harek/home/views/home_screen.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User?>(context);
    if (user == null) return const SignInScreen();
    return const HomeScreen();
  }
}
