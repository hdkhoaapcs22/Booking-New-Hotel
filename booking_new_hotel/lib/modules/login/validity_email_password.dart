import 'package:booking_new_hotel/modules/login/show_auth_error.dart';
import 'package:flutter/material.dart';

import '../../languages/appLocalizations.dart';

class ValidityEmailPassword {
  String _email = "", _password = "", _confirmPassword = "";
  ValidityEmailPassword(
      {String email = "", String password = "", String confirmPassword =""}) {
    _email = email;
    _password = password;
    _confirmPassword = confirmPassword;
  }

  bool isEmailEmpty() {
    return _email.isEmpty;
  }

  bool isPasswordEmpty() {
    return _password.isEmpty;
  }

  bool isConfirmPasswordEmpty() {
    return _confirmPassword.isEmpty;
  }

  void commonSetForPasswordEmpty(
      ShowAuthError showAuthError, BuildContext context) {
    showAuthError.setMessagePasswordError(
        messagePasswordError:
            AppLocalizations(context).of('password_cannot_empty'));
    showAuthError.setMessageEmailError(messageEmailError: "");
    showAuthError.setGapBetweenEmailAndPasswordDuringError(
        gapBetweenEmailAndPasswordDuringError: 34);
  }

  bool checkValidityInLogin(ShowAuthError showAuthError, BuildContext context) {
    if (isEmailEmpty()) {
      print("Email is empty");
      showAuthError.setMessageEmailError(
          messageEmailError: AppLocalizations(context).of('user_not_found'));
      showAuthError.setGapBetweenEmailAndPasswordDuringError(
          gapBetweenEmailAndPasswordDuringError: 0);
      if (!isPasswordEmpty()) {
        showAuthError.setGapBetweenPasswordAndButtonDuringError(
            gapBetweenPasswordAndButtonDuringError: 34);
        showAuthError.setMessagePasswordError(messagePasswordError: "");
      }
      return false;
    } else if (isPasswordEmpty()) {
      commonSetForPasswordEmpty(showAuthError, context);
      showAuthError.setGapBetweenPasswordAndButtonDuringError(
          gapBetweenPasswordAndButtonDuringError: 0);
      return false;
    }
    clear();
    showAuthError.clear();
    return true;
  }

  bool checkValidityInSignUp(
      ShowAuthError showAuthError, BuildContext context) {
    if (isEmailEmpty()) {
      showAuthError.setMessageEmailError(
          messageEmailError: AppLocalizations(context).of('user_not_found'));
      showAuthError.setGapBetweenEmailAndPasswordDuringError(
          gapBetweenEmailAndPasswordDuringError: 0);
      if (!isPasswordEmpty()) {
        showAuthError.setGapBetweenPasswordAndConfirmPasswordDuringError(
            gapBetweenPasswordAndConfirmPasswordDuringError: 34);
        showAuthError.setMessagePasswordError(messagePasswordError: "");
      }
      if (!isConfirmPasswordEmpty()) {
        showAuthError.setGapBetweenPasswordAndButtonDuringError(
            gapBetweenPasswordAndButtonDuringError: 34);
        showAuthError.setMessagePasswordConfirmError(
            messagePasswordConfirmError: "");
      }
      return false;
    } else if (isPasswordEmpty()) {
      commonSetForPasswordEmpty(showAuthError, context);
      showAuthError.setGapBetweenPasswordAndConfirmPasswordDuringError(
          gapBetweenPasswordAndConfirmPasswordDuringError: 0);
      return false;
    } else if (_password != _confirmPassword) {
      showAuthError.setMessagePasswordConfirmError(
          messagePasswordConfirmError:
              AppLocalizations(context).of('password_not_match'));
      showAuthError.setMessageEmailError(messageEmailError: "");
      showAuthError.setMessagePasswordError(messagePasswordError: "");
      showAuthError.setGapBetweenEmailAndPasswordDuringError(
          gapBetweenEmailAndPasswordDuringError: 34);
      showAuthError.setGapBetweenPasswordAndConfirmPasswordDuringError(
          gapBetweenPasswordAndConfirmPasswordDuringError: 34);
      showAuthError.setGapBetweenPasswordAndButtonDuringError(
          gapBetweenPasswordAndButtonDuringError: 0);
      return false;
    }
    clear();
    showAuthError.clear();
    return true;
  }

  void clear() {
    _email = "";
    _password = "";
    _confirmPassword = "";
  }
}
