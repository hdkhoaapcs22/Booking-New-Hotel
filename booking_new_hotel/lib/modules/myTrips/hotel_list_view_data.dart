import 'package:booking_new_hotel/widgets/list_cell_animation_view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../languages/appLocalizations.dart';
import '../../models/hotel_list_data.dart';
import '../../providers/theme_provider.dart';
import '../../utils/enum.dart';
import '../../utils/helper.dart';
import '../../utils/text_styles.dart';
import '../../utils/themes.dart';
import '../../widgets/common_card.dart';

class HotelListViewData extends StatelessWidget {
  final bool isShowDate;
  final VoidCallback callback;
  final HotelListData hotelData;
  final AnimationController animationController;
  final Animation<double> animation;
  final double ratingOfHotel;

  const HotelListViewData(
      {super.key,
      this.isShowDate = false,
      required this.callback,
      required this.hotelData,
      required this.animationController,
      required this.animation,
      required this.ratingOfHotel});

  @override
  Widget build(BuildContext context) {
    return ListCellAnimationView(
      animation: animation,
      animationController: animationController,
      child: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
        child: InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
            onTap: () {
              try {
                callback();
              } catch (e) {}
            },
            child: Row(children: [
              isShowDate ? getUI(context) : const SizedBox(),
              CommonCard(
                color: AppTheme.backgroundColor,
                radius: 16,
                child: SizedBox(
                  height: 150,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Image.asset(
                        hotelData.imagePath,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              !isShowDate ? getUI(context) : SizedBox(),
            ])),
      ),
    );
  }

  getUI(BuildContext context) {
    return Expanded(
      child: Container(
        height: 150,
        padding: EdgeInsets.only(
          left: !isShowDate ? 16 : 8,
          top: 8,
          bottom: 8,
          right: isShowDate ? 16 : 8,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment:
              isShowDate ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              hotelData.titleTxt,
              maxLines: 2,
              textAlign: isShowDate ? TextAlign.right : TextAlign.left,
              style: TextStyles(context).getBoldStyle().copyWith(fontSize: 16),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              hotelData.subTxt,
              style: TextStyles(context).getBoldStyle().copyWith(fontSize: 14),
            ),
            Text(
              Helper.getDateText(hotelData.date!),
              maxLines: 2,
              textAlign: isShowDate ? TextAlign.right : TextAlign.left,
              style: TextStyles(context).getBoldStyle().copyWith(fontSize: 12),
              overflow: TextOverflow.ellipsis,
            ),
            Expanded(
              child: FittedBox(
                child: SizedBox(
                  width: 150,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: isShowDate
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: isShowDate
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            // ignore: deprecated_member_use
                            FontAwesomeIcons.mapMarkerAlt,
                            size: 12,
                            color: Theme.of(context).primaryColor,
                          ),
                          Text(
                            " ${hotelData.dist.toStringAsFixed(1)}",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyles(context)
                                .getDescriptionStyle()
                                .copyWith(fontSize: 14),
                          ),
                          Text(
                            AppLocalizations(context).of("km_to_city"),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyles(context)
                                .getDescriptionStyle()
                                .copyWith(fontSize: 14),
                          ),
                        ],
                      ),
                      Helper.ratingStar(hotelData.rating),
                      Row(
                        mainAxisAlignment: isShowDate
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        children: [
                          Text(
                            "\$${hotelData.perNight}",
                            style: TextStyles(context)
                                .getRegularStyle()
                                .copyWith(
                                    fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: context
                                            .read<ThemeProvider>()
                                            .languageType ==
                                        LanguageType.ar
                                    ? 2.0
                                    : 0.0),
                            child: Text(
                              AppLocalizations(context).of("per_night"),
                              style: TextStyles(context).getDescriptionStyle(),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
