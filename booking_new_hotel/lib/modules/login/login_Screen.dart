import '../../routes/routes.dart';
import 'package:booking_new_hotel/widgets/common_button.dart';
import 'package:booking_new_hotel/widgets/common_textfield_view.dart';
import 'package:flutter/material.dart';
import '../../languages/appLocalizations.dart';
import '../../utils/themes.dart';
import '../../widgets/remove_focus.dart';
import '../../widgets/common_app_bar_view.dart';
import 'facebook_twitter_button_view.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  final Function() onTap;
  const LoginScreen({super.key, required this.onTap});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String errorEmail = "";
  String errorPassword = "";
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  double distanceEmailError = 34, distancePasswordError = 34;

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
                    padding: const EdgeInsets.only(top: 8, left: 24, right: 24),
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
                    errorText: errorPassword,
                    isObscureText: true,
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
                      userLogin();
                    },
                  ),
                  const SizedBox(height: 25),
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
                            height: 55)),
                  ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 5),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(AppLocalizations(context).of('not_a_member'),
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                )),
                            TextButton(
                                onPressed: () {
                                  widget.onTap();
                                },
                                child: Text(
                                    AppLocalizations(context).of('register'),
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

  forgotPasswordUI() {
    return Padding(
        padding: EdgeInsets.only(left: 24, right: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () {
                  print("Forgot Password");
                },
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

  Future userLogin() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));

    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      )
          .then((value) {
        errorPassword = "";
        distancePasswordError = 34;
        passwordController.clear();
        Navigator.pushReplacementNamed(context, RoutesName.NextPage);
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'channel-error') {
        errorEmail = AppLocalizations(context).of('user_not_found');
        distanceEmailError = 0;
      } else if (e.code == 'invalid-email') {
        errorEmail = AppLocalizations(context).of('invalid_email');
        distanceEmailError = 0;
      } else if (e.code == 'invalid-credential') {
        errorPassword = AppLocalizations(context).of('wrong_password');
        distancePasswordError = 0;
        errorEmail = "";
        distanceEmailError = 34;
      }
      setState(() {});
      Navigator.pop(context);
    }
  }
}
