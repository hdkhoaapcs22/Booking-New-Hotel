import 'package:booking_new_hotel/providers/theme_provider.dart';
import 'package:booking_new_hotel/utils/helper.dart';
import 'package:booking_new_hotel/widgets/list_cell_animation_view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../global/global_var.dart';
import '../../languages/appLocalizations.dart';
import '../../models/hotel_list_data.dart';
import '../../utils/enum.dart';
import '../../utils/text_styles.dart';
import '../../utils/themes.dart';
import '../../widgets/common_card.dart';

class HotelListView extends StatefulWidget {
  final bool isShowDate, isShowFav;
  final VoidCallback callback;
  final HotelListData hotelData;
  final AnimationController animationController;
  final Animation<double> animation;
  final double ratingOfHotel;
  const HotelListView(
      {super.key,
      this.isShowDate = false,
      this.isShowFav = true,
      required this.callback,
      required this.hotelData,
      required this.animationController,
      required this.animation,
      required this.ratingOfHotel});

  @override
  State<HotelListView> createState() => _HotelListViewState();
}

class _HotelListViewState extends State<HotelListView> {
  @override
  Widget build(BuildContext context) {
    bool isFav = GlobalVar.databaseService!.favoriteHotelsDatabase
        .isFavoriteHotel(name: widget.hotelData.titleTxt);
    return ListCellAnimationView(
      animation: widget.animation,
      animationController: widget.animationController,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
        child: Column(
          children: [
            widget.isShowDate
                ? Padding(
                    padding: const EdgeInsets.only(top: 12, bottom: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          Helper.getDateText(widget.hotelData.date!) + ', ',
                          style: TextStyles(context)
                              .getRegularStyle()
                              .copyWith(fontSize: 14),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Text(
                            Helper.getRoomText(widget.hotelData.roomData!) +
                                ', ',
                            style: TextStyles(context)
                                .getRegularStyle()
                                .copyWith(fontSize: 14),
                          ),
                        ),
                      ],
                    ))
                : const SizedBox(),
            CommonCard(
              color: AppTheme.backgroundColor,
              radius: 16,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        AspectRatio(
                          aspectRatio: 2,
                          child: Image.asset(widget.hotelData.imagePath,
                              fit: BoxFit.cover),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 8, bottom: 8, left: 16),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.hotelData.titleTxt,
                                      textAlign: TextAlign.left,
                                      style: TextStyles(context)
                                          .getBoldStyle()
                                          .copyWith(fontSize: 20),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          widget.hotelData.subTxt + ' ',
                                          textAlign: TextAlign.left,
                                          style: TextStyles(context)
                                              .getDescriptionStyle(),
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        // ignore: deprecated_member_use
                                        Icon(FontAwesomeIcons.mapMarkerAlt,
                                            size: 12,
                                            color:
                                                Theme.of(context).primaryColor),
                                        Text(
                                          "${widget.hotelData.dist.toStringAsFixed(1)}",
                                          textAlign: TextAlign.left,
                                          style: TextStyles(context)
                                              .getDescriptionStyle(),
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Expanded(
                                          child: Text(
                                            AppLocalizations(context)
                                                .of("km_to_city"),
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyles(context)
                                                .getDescriptionStyle(),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4),
                                      child: Row(
                                        children: [
                                          Helper.ratingStar(
                                              widget.ratingOfHotel),
                                          Text(
                                            "${widget.hotelData.reviews}",
                                            style: TextStyles(context)
                                                .getDescriptionStyle(),
                                          ),
                                          Text(
                                            AppLocalizations(context)
                                                .of("reviews"),
                                            style: TextStyles(context)
                                                .getDescriptionStyle(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(
                                    right: 16, top: 8, left: 16),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "\$${widget.hotelData.perNight}",
                                      style: TextStyles(context)
                                          .getBoldStyle()
                                          .copyWith(fontSize: 22),
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
                                        AppLocalizations(context)
                                            .of("per_night"),
                                        style: TextStyles(context)
                                            .getDescriptionStyle(),
                                      ),
                                    )
                                  ],
                                ))
                          ],
                        ),
                      ],
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      bottom: 0,
                      left: 0,
                      child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                              highlightColor: Colors.transparent,
                              splashColor: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.1),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16)),
                              onTap: () {
                                try {
                                  widget.callback();
                                } catch (e) {}
                              })),
                    ),
                    widget.isShowFav
                        ? Positioned(
                            top: 8,
                            right: 8,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.background,
                                shape: BoxShape.circle,
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(32)),
                                  onTap: () {
                                    if (isFav) {
                                      GlobalVar.databaseService!
                                          .favoriteHotelsDatabase
                                          .removeFavoriteHotel(
                                              name: widget.hotelData.titleTxt);
                                    } else {
                                      GlobalVar.databaseService!
                                          .favoriteHotelsDatabase
                                          .addFavoriteHotel(
                                              favoriteHotel: widget.hotelData);
                                    }
                                    setState(() {
                                      isFav = !isFav;
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Icon(
                                      isFav
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
