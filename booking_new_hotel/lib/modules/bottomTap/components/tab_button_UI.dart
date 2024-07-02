import 'package:flutter/material.dart';

import '../../../utils/text_styles.dart';
import '../../../utils/themes.dart';

class TabButtonUI extends StatelessWidget {
  final IconData icon;
  final Function()? onTap;
  final bool isSelected;
  final String text;
  const TabButtonUI(
      {super.key,
      required this.icon,
      this.onTap,
      required this.isSelected,
      required this.text});

  @override
  Widget build(BuildContext context) {
    final _color =
        isSelected ? AppTheme.primaryColor : AppTheme.secondaryTextColor;
    return Expanded(
        child: Material(
            color: Colors.transparent,
            child: InkWell(
                highlightColor: Colors.transparent,
                splashColor: Theme.of(context).primaryColor.withOpacity(0.2),
                onTap: onTap,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 4,
                    ),
                    SizedBox(
                        width: 40,
                        height: 32,
                        child: Icon(
                          icon,
                          size: 26,
                          color: _color,
                        )),
                    Padding(
                        padding: const EdgeInsets.only(bottom: 0),
                        child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(text,
                                style: TextStyles(context)
                                    .getDescriptionStyle()
                                    .copyWith(
                                      color: _color,
                                    ))))
                  ],
                ))));
  }
}
