import 'package:booking_new_hotel/utils/text_styles.dart';
import 'package:booking_new_hotel/widgets/common_app_bar_view.dart';
import 'package:flutter/material.dart';

import '../../languages/appLocalizations.dart';
import '../../widgets/common_button.dart';
import '../../widgets/common_textfield_view.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController currentPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        CommonAppBarView(
          topPadding: AppBar().preferredSize.height + 20,
          iconData: Icons.arrow_back,
          titleText: AppLocalizations(context).of("change_password"),
          onBackClick: () {
            Navigator.pop(context);
          },
        ),
        const SizedBox(
          height: 40,
        ),
        Center(
            child: Text(
          AppLocalizations(context).of("strong_password_strong_defense"),
          style: TextStyles(context).getRegularStyle().copyWith(
                fontSize: 16,
                color: Colors.grey,
              ),
        )),
        CommonTextFieldView(
          padding: const EdgeInsets.only(left: 24, top: 20, right: 24),
          titleText: AppLocalizations(context).of("current_password"),
          hintText: AppLocalizations(context).of("enter_current_password"),
          controller: currentPassword,
        ),
        CommonTextFieldView(
          padding: const EdgeInsets.only(left: 24, top: 20, right: 24),
          titleText: AppLocalizations(context).of("new_password"),
          hintText: AppLocalizations(context).of("enter_new_password"),
          controller: newPassword,
        ),
        CommonTextFieldView(
          padding: const EdgeInsets.only(left: 24, top: 20, right: 24),
          titleText: AppLocalizations(context).of("confirm_password"),
          hintText: AppLocalizations(context).of("enter_confirm_password"),
          controller: confirmPassword,
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
    ));
  }

  void  checkValidity() {
    // String tmpCurrentPassword = currentPassword.text.trim();
    //           String tmpNewPassword = newPassword.text.trim();
    //           String tmpConfirmPassword = confirmPassword.text.trim();
    // if(tmpC)
  }
}
