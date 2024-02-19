import 'package:flutter/material.dart';

import '../utils/text_styles.dart';
import '../utils/themes.dart';

class CommonAppBarView extends StatelessWidget {
  final double? topPadding;
  final IconData iconData;
  final String titleText;
  final VoidCallback? onBackClick;
  final Widget? backButton;

  const CommonAppBarView(
      {super.key,
      this.topPadding,
      required this.iconData,
      required this.titleText,
      this.onBackClick,
      this.backButton});

  @override
  Widget build(BuildContext context) {
    final double tmp = topPadding ?? MediaQuery.of(context).padding.top;
    return Padding(
        padding: EdgeInsets.only(top: tmp),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
              height: AppBar().preferredSize.height,
              child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 10, top: 10),
                  child: SizedBox(
                      child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: onBackClick,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: backButton ??
                              Icon(iconData, color: AppTheme.primaryTextColor),
                        )),
                  )))),
          Padding(
              padding: const EdgeInsets.only(left: 15, top: 7, bottom: 15),
              child:
                  Text(titleText, style: TextStyles(context).getTitleStyle(28)))
        ]));
  }
}
