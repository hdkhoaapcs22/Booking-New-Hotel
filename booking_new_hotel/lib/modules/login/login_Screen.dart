import '../../utils/validator.dart';
import 'package:booking_new_hotel/widgets/common_button.dart';
import 'package:booking_new_hotel/widgets/common_textfield_view.dart';
import 'package:flutter/material.dart';
import '../../languages/appLocalizations.dart';
import '../../utils/themes.dart';
import '../../widgets/remove_focus.dart';
import '../../widgets/common_app_bar_view.dart';
import 'facebook_twitter_button_view.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String errorEmail = "";
  String errorPassword = "";
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  double dynamicDistance = 20.0;

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
                CommonAppBarView(
                  topPadding: AppBar().preferredSize.height - 20,
                  titleText: AppLocalizations(context).of("login"),
                  iconData: Icons.arrow_back_ios,
                  onBackClick: () {
                    Navigator.pop(context);
                  },
                ),
                Expanded(
                    child: Column(children: [
                  const Padding(
                    padding: EdgeInsets.zero,
                    child: FacebookTwitterButtonView(),
                  ),
                  CommonTextFieldView(
                    controller: emailController,
                    padding:
                        const EdgeInsets.only(top: 12, left: 24, right: 24),
                    keyboardType: TextInputType.emailAddress,
                    titleText: AppLocalizations(context).of("your_mail"),
                    hintText: AppLocalizations(context).of("enter_your_email"),
                    errorText: errorEmail,
                  ),
                  CommonTextFieldView(
                    controller: passwordController,
                    padding: EdgeInsets.only(
                        top: dynamicDistance,
                        left: 24,
                        right: 24,
                        bottom: dynamicDistance == 3 ? 0 : 34),
                    titleText: AppLocalizations(context).of("password"),
                    hintText: AppLocalizations(context).of("enter_password"),
                    keyboardType: TextInputType.text,
                    errorText: errorPassword,
                    isObscureText: true,
                    dynamicDistance: dynamicDistance,
                  ),
                  forgotPasswordUI(),
                  CommonButton(
                    padding:
                        const EdgeInsets.only(top: 15, left: 24, right: 24),
                    buttonTextWidget:
                        Text(AppLocalizations(context).of("login"),
                            style: TextStyle(
                              color: AppTheme.whiteColor,
                              fontSize: 16,
                            )),
                    onTap: () {
                      if (allValidation()) {
                        print('Login');
                      }
                    },
                  ),
                  const SizedBox(height: 35),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(children: [
                      Expanded(
                          child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      )),
                      Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: Text(
                          AppLocalizations(context).of("continue_with"),
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Expanded(
                          child: Divider(
                        thickness: 0.7,
                        color: Colors.grey[400],
                      )),
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey[200],
                        ),
                        child: Image.asset("assets/images/google.png",
                            height: 65)),
                  ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 5),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Not a member?",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                )),
                            TextButton(
                                onPressed: () {},
                                child: const Text("Sign Up",
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    )))
                          ]))
                ]))
              ],
            )));
  }

  forgotPasswordUI() {
    return Padding(
        padding: EdgeInsets.only(left: 24, right: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () {},
                child:
                    Text(AppLocalizations(context).of("forgot_your_Password"),
                        style: TextStyle(
                          color: Theme.of(context).disabledColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        )))
          ],
        ));
  }

  bool allValidation() {
    bool isValid = true;
    if (emailController.text.trim().isEmpty) {
      isValid = false;
      errorEmail = AppLocalizations(context).of("email_cannot_empty");
      dynamicDistance = 3;
    } else if (Validator.validateEmail(emailController.text.trim()) == false) {
      isValid = false;
      errorEmail = AppLocalizations(context).of("enter_valid_email");
    } else {
      errorEmail = "";
    }

    if (passwordController.text.trim().isEmpty) {
      isValid = false;
      errorPassword = AppLocalizations(context).of("password_cannot_empty");
    } else if (Validator.validateEmail(passwordController.text.trim()) ==
        false) {
      isValid = false;
      errorPassword = AppLocalizations(context).of("enter_valid_password");
    } else {
      errorPassword = "";
    }
    setState(() {});
    return isValid;
  }
}
