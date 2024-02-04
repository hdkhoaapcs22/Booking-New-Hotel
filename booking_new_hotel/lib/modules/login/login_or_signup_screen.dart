import 'package:flutter/material.dart';

import 'login_screen.dart';
import 'signup_screen.dart';

class LoginOrSignUpScreen extends StatefulWidget {
  const LoginOrSignUpScreen({super.key});

  @override
  State<LoginOrSignUpScreen> createState() => _LoginOrSignUpScreenState();
}

class _LoginOrSignUpScreenState extends State<LoginOrSignUpScreen> {
  bool showLoginScreen = true;

  void toggleScreen()
  {
    setState(() {
      showLoginScreen = !showLoginScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(showLoginScreen)
    {
      return  LoginScreen(
        onTap: toggleScreen,
      );
    }
    else
    {
      return SignUpScreen(
        onTap: toggleScreen,
      );
    }
  }
}