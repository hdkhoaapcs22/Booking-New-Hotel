import 'package:booking_new_hotel/utils/text_styles.dart';
import 'package:booking_new_hotel/widgets/common_app_bar_view.dart';
import 'package:flutter/material.dart';

import '../../global/global_var.dart';
import '../../languages/appLocalizations.dart';
import '../../utils/themes.dart';
import '../../widgets/common_button.dart';
import '../../widgets/common_textfield_view.dart';
import '../../widgets/got_it_dialog.dart';
import '../../widgets/remove_focus.dart';
import '../login/credentials_validity.dart';
import '../login/show_auth_error.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController currentPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmNewPassword = TextEditingController();
  ShowAuthError showAuthError = ShowAuthError();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.scaffoldBackgroundColor,
      body: RemoveFocus(
        onClick: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: ListView(
          children: [
            CommonAppBarView(
              topPadding: AppBar().preferredSize.height,
              iconData: Icons.arrow_back,
              titleText: AppLocalizations(context).of("change_password"),
              onBackClick: () {
                Navigator.pop(context);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
                child: Text(
              AppLocalizations(context).of("strong_password_strong_defense"),
              style: TextStyles(context).getDescriptionStyle().copyWith(
                    fontSize: 18,
                  ),
            )),
            CommonTextFieldView(
              padding: const EdgeInsets.only(left: 24, top: 15, right: 24),
              titleText: AppLocalizations(context).of("current_password"),
              hintText: AppLocalizations(context).of("enter_current_password"),
              keyboardType: TextInputType.text,
              isObscureText: true,
              errorText: showAuthError.getmessageFirstFieldError,
              controller: currentPassword,
            ),
            CommonTextFieldView(
              padding: EdgeInsets.fromLTRB(
                  24,
                  showAuthError.getgapBetweenFirstAndSecondFieldDuringError,
                  24,
                  showAuthError.getgapBetweenSecondAndThirdFieldDuringError),
              titleText: AppLocalizations(context).of("new_password"),
              hintText: AppLocalizations(context).of("enter_new_password"),
              keyboardType: TextInputType.text,
              isObscureText: true,
              errorText: showAuthError.getmessageSecondFieldError,
              controller: newPassword,
            ),
            CommonTextFieldView(
              padding: EdgeInsets.only(
                  left: 24,
                  right: 24,
                  bottom: showAuthError
                      .getgapBetweenThirdFieldAndButtonDuringError),
              titleText: AppLocalizations(context).of("confirm_password"),
              hintText: AppLocalizations(context).of("enter_confirm_password"),
              keyboardType: TextInputType.text,
              isObscureText: true,
              errorText: showAuthError.getmessageThirdFieldError,
              controller: confirmNewPassword,
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24),
              child: CommonButton(
                buttonText: AppLocalizations(context).of("change_password"),
                onTap: () {
                  checkValidity();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future checkValidity() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
    String tmpCurrentPassword = currentPassword.text;
    String tmpNewPassword = newPassword.text;
    String tmpConfirmNewPassword = confirmNewPassword.text;
    CredentialsValidity credentialsValidity = CredentialsValidity();

    if (!credentialsValidity.checkValidityInChangePassword(
        showAuthError, context,
        currentPassword: tmpCurrentPassword,
        newPassword: tmpNewPassword,
        confirmPassword: tmpConfirmNewPassword)) {
      setState(() {});
      Navigator.pop(context);
    } else {
      try {
        await GlobalVar.authService
            .updateUserPassword(newPassword: tmpNewPassword)
            .then((value) {
          Navigator.pop(context);
          GotItDialog successDialog = GotItDialog(
            context: context,
            title: "updated",
            description: "password_updated",
          );
          GlobalVar.user!.setPassword(password: tmpNewPassword);
          successDialog.gotItDialog();
        });
      } catch (e) {
        print(e);
      }
    }
  }
}
