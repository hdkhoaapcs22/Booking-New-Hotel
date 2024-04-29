import 'package:booking_new_hotel/global/global_var.dart';
import 'package:booking_new_hotel/widgets/common_button.dart';
import 'package:booking_new_hotel/widgets/common_textfield_view.dart';
import 'package:flutter/material.dart';
import '../../languages/appLocalizations.dart';
import '../../routes/route_names.dart';
import '../../service/Database/database_service.dart';
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
  String errorEmail = "";
  String errorPassword = "";
  String errorPasswordConfirm = "";
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  double distanceEmailError = 34,
      distancePasswordError = 34,
      distanceConfirmPasswordError = 34;

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
                    titleText: AppLocalizations(context).of("your_mail"),
                    hintText: AppLocalizations(context).of("enter_your_email"),
                    errorText: errorEmail,
                  ),
                  CommonTextFieldView(
                    controller: passwordController,
                    padding: EdgeInsets.fromLTRB(
                        24, distanceEmailError, 24, distancePasswordError),
                    titleText: AppLocalizations(context).of("password"),
                    hintText: AppLocalizations(context).of("enter_password"),
                    keyboardType: TextInputType.text,
                    isObscureText: true,
                    errorText: errorPassword,
                  ),
                  CommonTextFieldView(
                    controller: confirmPasswordController,
                    padding: EdgeInsets.only(
                        left: 24,
                        right: 24,
                        bottom: distanceConfirmPasswordError),
                    titleText: AppLocalizations(context).of("confirm_password"),
                    hintText:
                        AppLocalizations(context).of("enter_confirm_password"),
                    keyboardType: TextInputType.text,
                    errorText: errorPasswordConfirm,
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
    String tmpPassword = passwordController.text.trim();
    String tmpConfirmPassword = confirmPasswordController.text.trim();

    if (tmpEmail.isEmpty) {
      errorEmail = AppLocalizations(context).of('user_not_found');
      distanceEmailError = 0;
      if (tmpPassword.isNotEmpty) {
        distancePasswordError = 34;
        errorPassword = "";
      }
      if (tmpConfirmPassword.isNotEmpty) {
        distanceConfirmPasswordError = 34;
        errorPasswordConfirm = "";
      }
      setState(() {});
      Navigator.pop(context);
    } else if (tmpPassword.isEmpty) {
      errorPassword = AppLocalizations(context).of('password_cannot_empty');
      errorEmail = "";
      distanceEmailError = 34;
      distancePasswordError = 0;
      setState(() {});
      Navigator.pop(context);
    } else if (tmpPassword != tmpConfirmPassword) {
      errorPasswordConfirm = AppLocalizations(context).of('password_not_match');
      errorEmail = errorPassword = "";
      distancePasswordError = distanceEmailError = 34;
      distanceConfirmPasswordError = 0;
      setState(() {});
      Navigator.pop(context);
    } else {
      await GlobalVar.authService
          .registerWithEmailAndPassword(email: tmpEmail, password: tmpPassword)
          .then((value) {
        if (value != null) {
          errorPassword = errorEmail = errorPasswordConfirm = "";
          distancePasswordError = distanceEmailError = 34;
          distanceEmailError =
              distancePasswordError = distanceConfirmPasswordError = 34;
          GlobalVar.databaseService = DatabaseService(uid: value.getUID);
          GlobalVar.user = value;
          GlobalVar.user!
              .setUserInfo(name: "", email: tmpEmail, password: tmpPassword, address: "", phone: "");
          GlobalVar.databaseService!.updateUserInfoData(
            name: "",
            address: "",
            phone: "",
          );
          NavigationServices(context).gotoBottomTapScreen();
        }
      });
    }
  }
}
