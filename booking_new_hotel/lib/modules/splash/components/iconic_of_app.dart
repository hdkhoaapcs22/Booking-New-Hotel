import 'package:flutter/material.dart';

import '../../../utils/localfiles.dart';
import '../../../utils/text_styles.dart';

class Iconic {
  Container appIcon(BuildContext context) {
    return Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            boxShadow: [
              BoxShadow(
                  color: Theme.of(context).dividerColor,
                  offset: const Offset(1.1, 1.1),
                  blurRadius: 10.0)
            ]),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          child: Image.asset(Localfiles.appIcon),
        ));
  }

  Text nameOfApp(BuildContext context) {
    return Text("Katel",
        textAlign: TextAlign.left,
        style: TextStyles(context)
            .getBoldStyle()
            .copyWith(fontSize: 24, letterSpacing: 1.5));
  }
}
