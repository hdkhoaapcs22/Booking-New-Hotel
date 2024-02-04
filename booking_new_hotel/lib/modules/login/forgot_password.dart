import 'package:booking_new_hotel/utils/text_styles.dart';
import 'package:booking_new_hotel/widgets/common_textfield_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../languages/appLocalizations.dart';
import '../../utils/themes.dart';
import '../../widgets/common_app_bar_view.dart';
import '../../widgets/common_button.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String errorEmail = "";
  TextEditingController emailController = TextEditingController();
  double distanceEmailError = 34;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CommonAppBarView(
                topPadding: AppBar().preferredSize.height,
                titleText: AppLocalizations(context).of("forgot_password"),
                iconData: Icons.arrow_back_ios,
                onBackClick: () {
                  Navigator.pop(context);
                },
              ),
              Expanded(
                  child: SingleChildScrollView(
                      child: Column(children: [
                Padding(
                    padding: const EdgeInsets.fromLTRB(24, 25, 24, 15),
                    child: SizedBox(
                      child: Image.asset("assets/images/reset_Password.png"),
                      height: 145,
                    )),
                Padding(
                    padding:
                        const EdgeInsets.only(left: 24, top: 20, right: 24),
                    child: Text(
                        AppLocalizations(context).of("resend_email_link"),
                        style: TextStyles(context).getRegularStyle(),
                        textAlign: TextAlign.center)),
                CommonTextFieldView(
                  controller: emailController,
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  keyboardType: TextInputType.emailAddress,
                  hintText: AppLocalizations(context).of("enter_your_email"),
                  errorText: errorEmail,
                ),
                CommonButton(
                  padding: EdgeInsets.only(
                      top: distanceEmailError, left: 24, right: 24),
                  buttonTextWidget:
                      Text(AppLocalizations(context).of("reset_password"),
                          style: TextStyle(
                            color: AppTheme.whiteColor,
                            fontSize: 16,
                          )),
                  onTap: () {
                    resetPassword();
                  },
                ),
              ])))
            ]));
  }

  Future resetPassword() async {
    if (emailController.text.isEmpty) {
      errorEmail = AppLocalizations(context).of("email_empty");
      distanceEmailError = 0;
      setState(() {});
    }
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      distanceEmailError = 34;
      errorEmail = "";
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                  content: Text(
                    AppLocalizations(context).of("reset_password_message"),
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  actions: [
                    Container(
                        height: 45,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                        ),
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            AppLocalizations(context).of("got_it"),
                            style: TextStyle(wordSpacing: 1.5, fontSize: 18),
                          ),
                        ))
                  ]));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        errorEmail = AppLocalizations(context).of("user_not_found");
        distanceEmailError = 0;
        setState(() {});
      }
    }
  }
}
