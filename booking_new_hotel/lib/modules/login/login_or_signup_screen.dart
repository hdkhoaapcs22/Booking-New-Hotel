import 'package:flutter/material.dart';

import 'login_screen.dart';
import 'signup_screen.dart';

// ignore: must_be_immutable
class LoginOrSignUpScreen extends StatefulWidget {
  bool gobalState;
  LoginOrSignUpScreen({super.key, required this.gobalState});

  @override
  State<LoginOrSignUpScreen> createState() =>
      _LoginOrSignUpScreenState(showLoginScreen: gobalState);
}

class _LoginOrSignUpScreenState extends State<LoginOrSignUpScreen> {
  bool showLoginScreen;

  _LoginOrSignUpScreenState({required this.showLoginScreen});

  void toggleScreen() {
    setState(() {
      showLoginScreen = !showLoginScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginScreen) {
      return LoginScreen(
        onTap: toggleScreen,
      );
    } else {
      return SignUpScreen(
        onTap: toggleScreen,
      );
    }
  }
}
