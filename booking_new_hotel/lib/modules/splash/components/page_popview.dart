import 'package:booking_new_hotel/languages/appLocalizations.dart';
import 'package:flutter/material.dart';

import '../../../utils/text_styles.dart';

class PagePopup extends StatelessWidget {
  final PageViewData imageData;
  const PagePopup({Key? key, required this.imageData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            flex: 8,
            child: Center(
              child: Container(
                  width: MediaQuery.of(context).size.width - 120,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Image.asset(
                      imageData.assetImage,
                      fit: BoxFit.cover,
                    ),
                  )),
            )),
        Expanded(
          flex: 1,
          child: Text(
            AppLocalizations(context).of(imageData.titleText),
            textAlign: TextAlign.center,
            style: TextStyles(context).getTitleStyle().copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(AppLocalizations(context).of(imageData.subText),
              textAlign: TextAlign.center,
              style: TextStyles(context).getDescriptionStyle()),
        ),
        const Expanded(
          flex: 1,
          child: SizedBox(),
        )
      ],
    );
  }
}

class PageViewData {
  final String titleText;
  final String subText;
  final String assetImage;

  PageViewData(
      {required this.titleText,
      required this.subText,
      required this.assetImage});
}
