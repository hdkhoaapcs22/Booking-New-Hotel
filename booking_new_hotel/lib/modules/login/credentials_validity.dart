import 'package:booking_new_hotel/modules/login/show_auth_error.dart';
import 'package:flutter/material.dart';

import '../../languages/appLocalizations.dart';

class CredentialsValidity {
  bool isFirstFieldEmpty(String email) {
    return email.isEmpty;
  }

  bool isSecondFieldEmpty(String password) {
    return password.isEmpty;
  }

  bool isThirdFieldEmpty(String confirmPassword) {
    return confirmPassword.isEmpty;
  }

  void commonShowErrorInSecondField(
      ShowAuthError showAuthError, BuildContext context) {
    showAuthError.setMessageSecondFieldError(
        messageSecondFieldError:
            AppLocalizations(context).of('password_cannot_empty'));
    showAuthError.setMessageFirstFieldError(messageFirstFieldError: "");
    showAuthError.setGapBetweenFirstAndSecondFieldDuringError(
        gapBetweenFirstAndSecondFieldDuringError: 34);
  }

  void commonShowErrorInFirstField(
    ShowAuthError showAuthError,
    BuildContext context, {
    required String secondField,
    required String thirdField,
    required String messageFirstFieldError,
  }) {
    showAuthError.setMessageFirstFieldError(
        messageFirstFieldError:
            AppLocalizations(context).of(messageFirstFieldError));
    showAuthError.setGapBetweenFirstAndSecondFieldDuringError(
        gapBetweenFirstAndSecondFieldDuringError: 0);
    if (!isSecondFieldEmpty(secondField)) {
      showAuthError.setGapBetweenSecondAndThirdDuringError(
          gapBetweenSecondAndThirdFieldDuringError: 34);
      showAuthError.setMessageSecondFieldError(messageSecondFieldError: "");
    }
    if (!isThirdFieldEmpty(thirdField)) {
      showAuthError.setGapBetweenThirdFieldAndButtonDuringError(
          gapBetweenThirdFieldAndButtonDuringError: 34);
      showAuthError.setMessageThirdFieldError(messageThirdFieldError: "");
    }
  }

  bool checkValidityInLogin(ShowAuthError showAuthError, BuildContext context,
      {required String email, required String password}) {
    if (isFirstFieldEmpty(email)) {
      showAuthError.setMessageFirstFieldError(
          messageFirstFieldError:
              AppLocalizations(context).of('user_not_found'));
      showAuthError.setGapBetweenFirstAndSecondFieldDuringError(
          gapBetweenFirstAndSecondFieldDuringError: 0);
      if (!isSecondFieldEmpty(password)) {
        showAuthError.setGapBetweenThirdFieldAndButtonDuringError(
            gapBetweenThirdFieldAndButtonDuringError: 34);
        showAuthError.setMessageSecondFieldError(messageSecondFieldError: "");
      }
      return false;
    } else if (isSecondFieldEmpty(password)) {
      commonShowErrorInSecondField(showAuthError, context);
      showAuthError.setGapBetweenThirdFieldAndButtonDuringError(
          gapBetweenThirdFieldAndButtonDuringError: 0);
      return false;
    }
    return true;
  }

  bool helperCheckValidityInSignUpAndChangePassowrd(
    ShowAuthError showAuthError,
    BuildContext context, {
    required String firstField,
    required String secondField,
    required String thirdField,
    required String messageForFirstError,
  }) {
    if (isFirstFieldEmpty(firstField)) {
      commonShowErrorInFirstField(showAuthError, context,
          secondField: secondField,
          thirdField: thirdField,
          messageFirstFieldError: messageForFirstError);
      return false;
    } else if (isSecondFieldEmpty(secondField)) {
      commonShowErrorInSecondField(showAuthError, context);
      showAuthError.setGapBetweenSecondAndThirdDuringError(
          gapBetweenSecondAndThirdFieldDuringError: 0);
      return false;
    } else if (secondField != thirdField) {
      showAuthError.setMessageThirdFieldError(
          messageThirdFieldError:
              AppLocalizations(context).of('password_not_match'));
      showAuthError.setMessageFirstFieldError(messageFirstFieldError: "");
      showAuthError.setMessageSecondFieldError(messageSecondFieldError: "");
      showAuthError.setGapBetweenFirstAndSecondFieldDuringError(
          gapBetweenFirstAndSecondFieldDuringError: 34);
      showAuthError.setGapBetweenSecondAndThirdDuringError(
          gapBetweenSecondAndThirdFieldDuringError: 34);
      showAuthError.setGapBetweenThirdFieldAndButtonDuringError(
          gapBetweenThirdFieldAndButtonDuringError: 0);
      return false;
    }
    return true;
  }

  bool checkValidityInSignUp(ShowAuthError showAuthError, BuildContext context,
      {required String email,
      required String password,
      required String confirmPassword}) {
    return helperCheckValidityInSignUpAndChangePassowrd(
      showAuthError,
      context,
      firstField: email,
      secondField: password,
      thirdField: confirmPassword,
      messageForFirstError: 'email_cannot_empty',
    );
  }

  bool checkValidityInChangePassword(
      {required ShowAuthError showAuthError,
      required BuildContext context,
      required String previousPassword,
      required String enterPassword,
      required String newPassword,
      required String confirmPassword}) {
    if (helperCheckValidityInSignUpAndChangePassowrd(
      showAuthError,
      context,
      firstField: enterPassword,
      secondField: newPassword,
      thirdField: confirmPassword,
      messageForFirstError: 'password_cannot_empty',
    )) {
      if (enterPassword != previousPassword) {
        showAuthError.setMessageFirstFieldError(
            messageFirstFieldError:
                AppLocalizations(context).of('current_password_not_match'));
        showAuthError.setGapBetweenFirstAndSecondFieldDuringError(
            gapBetweenFirstAndSecondFieldDuringError: 0);
        showAuthError.setGapBetweenSecondAndThirdDuringError(
            gapBetweenSecondAndThirdFieldDuringError: 34);
        if (!isThirdFieldEmpty(confirmPassword)) {
          showAuthError.setGapBetweenThirdFieldAndButtonDuringError(
              gapBetweenThirdFieldAndButtonDuringError: 34);
          showAuthError.setMessageThirdFieldError(messageThirdFieldError: "");
        }
        return false;
      }
    }
    showAuthError.setMessageFirstFieldError(messageFirstFieldError: "");
    return true;
  }
}
