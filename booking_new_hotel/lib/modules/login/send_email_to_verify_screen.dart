import 'dart:async';

import 'package:booking_new_hotel/global/global_var.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../utils/localfiles.dart';
import '../../utils/text_styles.dart';
import '../../widgets/common_button.dart';

// ignore: must_be_immutable
class SendEmailToVerify extends StatefulWidget {
  String email;
  SendEmailToVerify({super.key, required this.email});

  @override
  State<SendEmailToVerify> createState() => _SendEmailToVerifyState();
}

class _SendEmailToVerifyState extends State<SendEmailToVerify>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _animation;
  String remaningPartOfEmail = "";
  bool isEmailVerified = false;

  @override
  void initState() {
    // TODO: implement initState
    if (widget.email.length > 19) {
      remaningPartOfEmail = ' ' + widget.email.substring(19);
      widget.email = widget.email.substring(0, 19);
    }
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    _animation =
        CurvedAnimation(parent: _animationController!, curve: Curves.easeInOut);
    _animationController!.forward();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 80),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: Image.asset(
                    Localfiles.verifyScreenImage,
                  ),
                ),
              ),
              Text(
                "Verify your email address",
                style: TextStyles(context)
                    .getTitleStyle(26)
                    .copyWith(wordSpacing: 1.3, fontWeight: FontWeight.bold),
              ),
              AnimatedBuilder(
                animation: _animationController!,
                builder: (BuildContext context, child) {
                  return FadeTransition(
                    opacity: _animation!,
                    child: Transform(
                      transform: Matrix4.translationValues(
                          // animate it from left to right
                          5 * _animation!.value,
                          0.0,
                          0.0),
                      child: child,
                    ),
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.92,
                  height: MediaQuery.of(context).size.height * 0.3,
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text.rich(
                          TextSpan(
                            text: "You've entered ",
                            style:
                                TextStyles(context).getRegularStyle().copyWith(
                                      fontSize: 17,
                                    ),
                            children: <TextSpan>[
                              TextSpan(
                                  text: widget.email!,
                                  style: TextStyles(context)
                                      .getBoldStyle()
                                      .copyWith(
                                        fontSize: 20,
                                      )),
                              TextSpan(
                                  text: remaningPartOfEmail,
                                  style: TextStyles(context)
                                      .getBoldStyle()
                                      .copyWith(
                                        fontSize: 20,
                                      )),
                              const TextSpan(
                                text: " as the email address for your account.",
                              ),
                            ],
                          ),
                        ),
                        Text(
                            "We will send verification email to your email. Please check your inbox and click on the link.",
                            style:
                                TextStyles(context).getRegularStyle().copyWith(
                                      fontSize: 17,
                                    )),
                      ]),
                ),
              ),
              CommonButton(
                padding: const EdgeInsets.only(left: 48, right: 48),
                buttonTextWidget: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FontAwesomeIcons.envelope,
                      color: Colors.white,
                    ),
                    SizedBox(width: 12),
                    Text(
                      "Send email",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                onTap: () async {
                  isEmailVerified = await checkmailVerified();
                  if (isEmailVerified) {
                    Navigator.pop(context, true);
                  }
                },
              ),
              const SizedBox(height: 20),
              CommonButton(
                padding: const EdgeInsets.only(left: 48, right: 48),
                buttonTextWidget: const Text(
                  "Cancel",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  GlobalVar.authService.signOutAccount();
                  Navigator.pop(context);
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  checkmailVerified() async {
    FirebaseAuth _auth = GlobalVar.authService.getAuthInstance();
    bool isEmailVerified = _auth.currentUser!.emailVerified;
    if (!isEmailVerified) {
      await _auth.currentUser!.sendEmailVerification();
      Timer.periodic(
          const Duration(seconds: 3),
          (timer) => _auth.currentUser!.reload().then((value) {
                if (_auth.currentUser!.emailVerified) {
                  timer.cancel();
                  Navigator.pop(context, true);
                }
              }));

      return _auth.currentUser!.emailVerified;
    }
  }
}
