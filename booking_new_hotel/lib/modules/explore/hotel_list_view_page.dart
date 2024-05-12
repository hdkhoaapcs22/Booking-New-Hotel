import 'package:booking_new_hotel/languages/appLocalizations.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../models/hotel.dart';
import '../../providers/theme_provider.dart';
import '../../utils/enum.dart';
import '../../utils/helper.dart';
import '../../utils/text_styles.dart';
import '../../utils/themes.dart';
import '../../widgets/common_card.dart';
import '../../widgets/list_cell_animation_view.dart';

class HotelListViewPage extends StatelessWidget {
  final VoidCallback callback;
  final Hotel hotelData;
  final AnimationController animationController;
  final Animation<double> animation;
  final bool isShowDate;
  const HotelListViewPage({
    super.key,
    this.isShowDate = false,
    required this.callback,
    required this.hotelData,
    required this.animationController,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    return ListCellAnimationView(
      animation: animation,
      child: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 16),
        child: CommonCard(
          color: AppTheme.backgroundColor,
          radius: 15,
          child: ClipRect(
            child: AspectRatio(
              aspectRatio: 2.7,
              child: Stack(
                children: [
                  Row(
                    children: [
                      AspectRatio(
                        aspectRatio: 0.9,
                        child: Image.asset(
                          hotelData.imageHotel,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.width >= 360
                                  ? 12
                                  : 8),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(hotelData.name,
                                    maxLines: 1,
                                    textAlign: TextAlign.left,
                                    style: TextStyles(context)
                                        .getBoldStyle()
                                        .copyWith(fontSize: 16),
                                    overflow: TextOverflow.ellipsis),
                                Text(hotelData.locationOfHotel,
                                    maxLines: 1,
                                    textAlign: TextAlign.left,
                                    style: TextStyles(context)
                                        .getDescriptionStyle()
                                        .copyWith(fontSize: 14),
                                    overflow: TextOverflow.ellipsis),
                                Expanded(
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Icon(
                                                    FontAwesomeIcons
                                                        // ignore: deprecated_member_use
                                                        .mapMarkerAlt,
                                                    size: 12,
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                                const SizedBox(width: 10),
                                                Text(
                                                    hotelData.dist
                                                        .toStringAsFixed(1),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.left,
                                                    style: TextStyles(context)
                                                        .getDescriptionStyle()
                                                        .copyWith(
                                                            fontSize: 16)),
                                                const SizedBox(
                                                  width: 2.0,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    AppLocalizations(context)
                                                        .of("km_text"),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyles(context)
                                                        .getDescriptionStyle()
                                                        .copyWith(fontSize: 16),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 2,
                                                ),
                                              ],
                                            ),
                                            Helper.ratingStar(hotelData.rating),
                                          ],
                                        ),
                                      ),
                                      FittedBox(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8),
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                hotelData.discountRate == 0
                                                    ? Text(
                                                        "${hotelData.averagePrice}\$",
                                                        textAlign: TextAlign
                                                            .left,
                                                        style:
                                                            TextStyles(context)
                                                                .getBoldStyle()
                                                                .copyWith(
                                                                    fontSize:
                                                                        24))
                                                    : Row(children: [
                                                        Text(
                                                            "${hotelData.averagePrice}",
                                                            style: TextStyle(
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.4),
                                                              fontSize: 19,
                                                              decoration:
                                                                  TextDecoration
                                                                      .lineThrough,
                                                            )),
                                                        const SizedBox(
                                                          width: 4,
                                                        ),
                                                        Text(
                                                            "${hotelData.averagePrice - (hotelData.averagePrice * hotelData.discountRate ~/ 100)}\$",
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: TextStyles(
                                                                    context)
                                                                .getBoldStyle()
                                                                .copyWith(
                                                                    fontSize:
                                                                        24)),
                                                      ]),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: context
                                                                  .read<
                                                                      ThemeProvider>()
                                                                  .languageType ==
                                                              LanguageType.ar
                                                          ? 2.0
                                                          : 0.0),
                                                  child: Text(
                                                    AppLocalizations(context)
                                                        .of("per_night"),
                                                    style: TextStyles(context)
                                                        .getRegularStyle()
                                                        .copyWith(fontSize: 14),
                                                  ),
                                                )
                                              ]),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                        ),
                      ),
                    ],
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      highlightColor: Colors.transparent,
                      splashColor:
                          Theme.of(context).primaryColor.withOpacity(0.1),
                      onTap: () {
                        try {
                          callback();
                        } catch (e) {}
                      },
                    ),
                  ),
                  hotelData.discountRate == 0
                      ? const SizedBox()
                      : Positioned(
                          top: 0.9,
                          right: 1,
                          child: Container(
                              height: 30,
                              width: 42,
                              decoration: BoxDecoration(
                                  color: AppTheme.whiteColor,
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(15),
                                    bottomLeft: Radius.circular(15),
                                  )),
                              child: Text(
                                '-' + hotelData.discountRate.toString() + '%',
                                style: TextStyles(context)
                                    .getRegularStyle()
                                    .copyWith(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                    ),
                                textAlign: TextAlign.center,
                              )))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
