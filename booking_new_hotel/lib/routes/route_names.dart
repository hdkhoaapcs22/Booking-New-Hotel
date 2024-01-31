import 'package:flutter/material.dart';
import 'routes.dart';
import '../modules/login/login_Screen.dart';

class NavigationServices {
  final BuildContext context;
  NavigationServices(this.context);

  Future<dynamic> _pushMaterialPageRoute(Widget widget,
      {bool fullscreenDialog = false}) async {
    return Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => widget, fullscreenDialog: fullscreenDialog));
  }

  void gotoIntroductionScreen() {
    Navigator.pushNamedAndRemoveUntil(
        context, RoutesName.Introduction, (Route<dynamic> route) => false);
  }

  Future<dynamic> gotoLoginScreen() async {
    return _pushMaterialPageRoute(const LoginScreen());
  }
}
