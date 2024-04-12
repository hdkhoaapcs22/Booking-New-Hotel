import 'package:flutter/material.dart';

import '../utils/text_styles.dart';

class CommonAppBarView extends StatelessWidget {
  final double? topPadding;
  final IconData iconData;
  final String titleText;
  final VoidCallback? onBackClick;
  const CommonAppBarView({
    super.key,
    this.topPadding,
    required this.iconData,
    required this.titleText,
    this.onBackClick,
  });

  @override
  Widget build(BuildContext context) {
    final double tmp = topPadding ?? MediaQuery.of(context).padding.top;
    return Padding(
      padding: EdgeInsets.only(top: tmp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: AppBar().preferredSize.height,
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 10, top: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  shape: BoxShape.circle,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        offset: const Offset(2.0, 4.0),
                        blurRadius: 8),
                  ],
                ),
                height: 60,
                width: 60,
                child: InkWell(
                  borderRadius: BorderRadius.circular(60),
                  onTap: onBackClick,
                  child: Center(
                    child: Icon(
                      iconData,
                      color: Colors.black.withOpacity(0.7),
                      size: 35,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(left: 15, top: 7, bottom: 15),
              child:
                  Text(titleText, style: TextStyles(context).getTitleStyle(28)))
        ],
      ),
    );
  }
}
