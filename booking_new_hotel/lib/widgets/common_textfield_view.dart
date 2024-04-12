import 'package:flutter/material.dart';

import '../utils/text_styles.dart';
import '../utils/themes.dart';

class CommonTextFieldView extends StatelessWidget {
  final String? titleText;
  final String? hintText;
  final String? errorText;
  final bool isObscureText; // used to hide password
  final EdgeInsetsGeometry padding;
  final TextEditingController? controller;
  final TextInputType? keyboardType; // used to set keyboard type
  final double dynamicDistance;

  const CommonTextFieldView(
      {super.key,
      this.titleText,
      this.hintText,
      this.errorText,
      this.isObscureText = false,
      required this.padding,
      this.keyboardType,
      this.controller,
      this.dynamicDistance = 20.0});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: EdgeInsets.only(top: dynamicDistance),
              child: Text(titleText ?? "",
                  style: TextStyles(context).getDescriptionStyle())),
          Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            shadowColor: Colors.black12.withOpacity(
                Theme.of(context).brightness == Brightness.dark ? 0.6 : 0.2),
            child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextField(
                  controller: controller,
                  obscureText: isObscureText,
                  style: TextStyles(context).getRegularStyle(),
                  maxLines: 1,
                  cursorColor: Theme.of(context).primaryColor,
                  onEditingComplete: () => FocusScope.of(context)
                      .nextFocus(), // it helps to move to next text field
                  decoration: InputDecoration(
                      hintText: hintText,
                      errorText: null,
                      border: InputBorder.none,
                      hintStyle:
                          TextStyle(color: Theme.of(context).disabledColor)),
                  keyboardType: keyboardType,
                )),
          ),
          if (errorText != null && errorText!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(5),
              child: Text(
                errorText ?? "",
                style: TextStyles(context).getDescriptionStyle().copyWith(
                      color: AppTheme.redErrorColor,
                    ),
              ),
            ),
        ],
      ),
    );
  }
}
