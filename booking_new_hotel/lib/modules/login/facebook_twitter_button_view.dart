import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../widgets/common_button.dart';

class FacebookTwitterButtonView extends StatelessWidget {
  const FacebookTwitterButtonView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Expanded(
          child: CommonButton(
        padding: const EdgeInsets.fromLTRB(24, 10, 5, 10),
        backgroundColor: Colors.lightBlue[900],
        buttonTextWidget: buttonTextWidgetUI(),
      )),
      const SizedBox(
        width: 15,
      ),
      Expanded(
          child: CommonButton(
        padding: const EdgeInsets.fromLTRB(5, 10, 24, 10),
        backgroundColor: Colors.lightBlue[400],
        buttonTextWidget: buttonTextWidgetUI(false),
      ))
    ]));
  }

  Widget buttonTextWidgetUI([bool isFacebook = true]) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Icon(isFacebook ? FontAwesomeIcons.facebook : FontAwesomeIcons.twitter,
          color: Colors.white),
      const SizedBox(width: 12),
      Text(isFacebook ? "Facebook" : "Twitter",
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: Colors.white,
          ))
    ]);
  }
}
