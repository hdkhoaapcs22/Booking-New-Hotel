import 'package:booking_new_hotel/global/global_var.dart';
import 'package:booking_new_hotel/modules/login/show_auth_error.dart';
import 'package:booking_new_hotel/modules/login/credentials_validity.dart';
import 'package:booking_new_hotel/widgets/common_button.dart';
import 'package:booking_new_hotel/widgets/common_textfield_view.dart';
import 'package:flutter/material.dart';
import '../../languages/appLocalizations.dart';
import '../../routes/route_names.dart';
import '../../service/database/database_service.dart';
import '../../utils/text_styles.dart';
import '../../utils/themes.dart';
import '../../widgets/remove_focus.dart';

class SignUpScreen extends StatefulWidget {
  final Function() onTap;
  const SignUpScreen({super.key, required this.onTap});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  ShowAuthError showAuthError = ShowAuthError();

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: RemoveFocus(
            onClick: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                    padding: EdgeInsets.only(
                        top: (AppBar().preferredSize.height * 2 - 12),
                        left: 15),
                    child: Text(AppLocalizations(context).of("sign_up"),
                        style: TextStyles(context).getTitleStyle(28))),
                Expanded(
                    child: Column(children: [
                  CommonTextFieldView(
                    controller: emailController,
                    padding:
                        const EdgeInsets.only(top: 15, left: 24, right: 24),
                    keyboardType: TextInputType.emailAddress,
                    titleText: AppLocalizations(context).of("mail"),
                    hintText: AppLocalizations(context).of("enter_your_email"),
                    errorText: showAuthError.getmessageFirstFieldError,
                  ),
                  CommonTextFieldView(
                    controller: passwordController,
                    padding: EdgeInsets.fromLTRB(
                        24,
                        showAuthError
                            .getgapBetweenFirstAndSecondFieldDuringError,
                        24,
                        showAuthError
                            .getgapBetweenSecondAndThirdFieldDuringError),
                    titleText: AppLocalizations(context).of("password"),
                    hintText: AppLocalizations(context).of("enter_password"),
                    keyboardType: TextInputType.text,
                    isObscureText: true,
                    errorText: showAuthError.getmessageSecondFieldError,
                  ),
                  CommonTextFieldView(
                    controller: confirmPasswordController,
                    padding: EdgeInsets.only(
                        left: 24,
                        right: 24,
                        bottom: showAuthError
                            .getgapBetweenThirdFieldAndButtonDuringError),
                    titleText: AppLocalizations(context).of("confirm_password"),
                    hintText:
                        AppLocalizations(context).of("enter_confirm_password"),
                    keyboardType: TextInputType.text,
                    errorText: showAuthError.getmessageThirdFieldError,
                    isObscureText: true,
                  ),
                  CommonButton(
                    padding:
                        const EdgeInsets.only(top: 15, left: 24, right: 24),
                    buttonTextWidget:
                        Text(AppLocalizations(context).of("sign_up"),
                            style: TextStyle(
                              color: AppTheme.whiteColor,
                              fontSize: 16,
                            )),
                    onTap: () {
                      userSignUp();
                    },
                  ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 5),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                AppLocalizations(context)
                                    .of('already_have_account'),
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                )),
                            TextButton(
                                onPressed: () {
                                  widget.onTap();
                                },
                                child: Text(
                                    AppLocalizations(context).of('sign_in'),
                                    style: const TextStyle(
                                      color: Colors.blue,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    )))
                          ]))
                ]))
              ],
            )));
  }

  Future userSignUp() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
    String tmpEmail = emailController.text.trim();
    String tmpPassword = passwordController.text;
    String tmpConfirmPassword = confirmPasswordController.text;
    CredentialsValidity credentialsValidity = CredentialsValidity();
    if (!credentialsValidity.checkValidityInSignUp(showAuthError, context,
        email: tmpEmail,
        password: tmpPassword,
        confirmPassword: tmpConfirmPassword)) {
      setState(() {});
      Navigator.pop(context);
    } else {
      await GlobalVar.authService
          .registerWithEmailAndPassword(email: tmpEmail, password: tmpPassword)
          .then((value) {
        if (value != null) {
          GlobalVar.databaseService = DatabaseService(uid: value);
          GlobalVar.databaseService!.userInfoDatabase.setUserInfoData(
            name: "",
            address: "",
            phone: "",
            email: tmpEmail,
            password: tmpPassword,
          );
          Navigator.pop(context);
          NavigationServices(context).gotoBottomTapScreen();
        }
      });
    }
  }
}
