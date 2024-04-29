import 'package:booking_new_hotel/modules/login/show_auth_error.dart';
import 'package:flutter/material.dart';

import '../../languages/appLocalizations.dart';

class ValidityEmailPassword {
  String? email, password, confirmPassword;
  ValidityEmailPassword({this.email, this.password, this.confirmPassword});

  bool isEmailEmpty() {
    return email!.isEmpty;
  }

  bool isPasswordEmpty() {
    return password!.isEmpty;
  }

  bool isConfirmPasswordEmpty() {
    return confirmPassword!.isEmpty;
  }

  bool checkValidityInLogin(ShowAuthError showAuthError, BuildContext context) {
    if (isEmailEmpty()) {
      showAuthError.setMessage(
          message: AppLocalizations(context).of('user_not_found'));
      showAuthError.setGapBetweenEmailAndPasswordDuringError(
          gapBetweenEmailAndPasswordDuringError: 0);
      if (!isPasswordEmpty()) {
        showAuthError.setGapBetweenPasswordAndButtonDuringError(
            gapBetweenPasswordAndButtonDuringError: 34);
        showAuthError.setMessage(message: "");
      }
      return false;
    } else if (isPasswordEmpty()) {
      showAuthError.setMessage(message: "");
      showAuthError.setGapBetweenEmailAndPasswordDuringError(
          gapBetweenEmailAndPasswordDuringError: 34);
      showAuthError.setGapBetweenPasswordAndButtonDuringError(
          gapBetweenPasswordAndButtonDuringError: 0);
      return false;
    }
    return true;
  }

  void clear() {
    email = "";
    password = "";
    confirmPassword = "";
  }
}
