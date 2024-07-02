import 'package:booking_new_hotel/providers/theme_provider.dart';
import 'package:booking_new_hotel/utils/helper.dart';
import 'package:booking_new_hotel/widgets/list_cell_animation_view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../global/global_var.dart';
import '../../languages/appLocalizations.dart';
import '../../models/hotel.dart';
import '../../utils/enum.dart';
import '../../utils/text_styles.dart';
import '../../utils/themes.dart';
import '../../widgets/common_card.dart';

class HotelListView extends StatefulWidget {
  final isShowFavIcon;
  final VoidCallback callback;
  final Hotel hotelData;
  final AnimationController animationController;
  final Animation<double> animation;
  const HotelListView({
    super.key,
    this.isShowFavIcon = true,
    required this.callback,
    required this.hotelData,
    required this.animationController,
    required this.animation,
  });

  @override
  State<HotelListView> createState() => _HotelListViewState();
}

class _HotelListViewState extends State<HotelListView> {
  @override
  Widget build(BuildContext context) {
    bool isFav = GlobalVar.databaseService!.favoriteHotelsDatabase
        .isFavoriteHotel(name: widget.hotelData.name);
    if (isFav) {
      print(widget.hotelData.name + " is favorite hotel");
    } else {
      print(widget.hotelData.name + " is not favorite hotel");
    }
    return ListCellAnimationView(
      animation: widget.animation,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 8, 18, 5),
        child: CommonCard(
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
                      child: Image.asset(widget.hotelData.imageHotel,
                          fit: BoxFit.cover),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 1, left: 6),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.hotelData.name,
                                  textAlign: TextAlign.left,
                                  style: TextStyles(context)
                                      .getBoldStyle()
                                      .copyWith(fontSize: 20),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 1),
                                  child: Row(
                                    children: [
                                      Helper.ratingStar(
                                          widget.hotelData.rating),
                                      Text(
                                        "${widget.hotelData.reviews}",
                                        style: TextStyles(context)
                                            .getDescriptionStyle(),
                                      ),
                                      Text(
                                        AppLocalizations(context).of("reviews"),
                                        style: TextStyles(context)
                                            .getDescriptionStyle(),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.662,
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                            widget.hotelData.locationOfHotel +
                                                ' ',
                                            textAlign: TextAlign.left,
                                            style: TextStyles(context)
                                                .getDescriptionStyle(),
                                          ),
                                        )),
                                    // ignore: deprecated_member_use
                                  ],
                                ),
                                Row(children: [
                                  Icon(FontAwesomeIcons.locationDot,
                                      size: 12,
                                      color: Theme.of(context).primaryColor),
                                  const SizedBox(width: 4),
                                  Text(
                                    "${widget.hotelData.dist.toStringAsFixed(1)}",
                                    textAlign: TextAlign.left,
                                    style: TextStyles(context)
                                        .getRegularStyle()
                                        .copyWith(
                                          fontSize: 14,
                                        ),
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    AppLocalizations(context).of("km_text"),
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyles(context)
                                        .getRegularStyle()
                                        .copyWith(
                                          fontSize: 14,
                                        ),
                                  ),
                                ]),
                              ],
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            widget.hotelData.discountRate > 0
                                ? Row(children: [
                                    Text("${widget.hotelData.averagePrice}",
                                        style: TextStyle(
                                          color: Colors.grey.withOpacity(0.4),
                                          fontSize: 20,
                                          decoration:
                                              TextDecoration.lineThrough,
                                        )),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      "${widget.hotelData.averagePrice - (widget.hotelData.averagePrice * widget.hotelData.discountRate ~/ 100)}\$",
                                      style: TextStyles(context)
                                          .getBoldStyle()
                                          .copyWith(fontSize: 22),
                                    ),
                                  ])
                                : Text(
                                    "${widget.hotelData.averagePrice}\$",
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
                                AppLocalizations(context).of("per_night"),
                                style: TextStyles(context)
                                    .getDescriptionStyle()
                                    .copyWith(
                                      fontSize: 15,
                                    ),
                              ),
                            )
                          ],
                        ),
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
                          splashColor:
                              Theme.of(context).primaryColor.withOpacity(0.1),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16)),
                          onTap: () {
                            try {
                              widget.callback();
                            } catch (e) {}
                          })),
                ),
                widget.isShowFavIcon
                    ? Positioned(
                        top: 8,
                        left: 8,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.background,
                            shape: BoxShape.circle,
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(32)),
                              onTap: () {
                                if (isFav) {
                                  GlobalVar
                                      .databaseService!.favoriteHotelsDatabase
                                      .removeFavoriteHotel(
                                          name: widget.hotelData.name);
                                } else {
                                  GlobalVar
                                      .databaseService!.favoriteHotelsDatabase
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
                widget.hotelData.discountRate > 0
                    ? Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                            height: 32,
                            width: 48,
                            decoration: BoxDecoration(
                                color: AppTheme.whiteColor,
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(15),
                                  bottomLeft: Radius.circular(15),
                                ),
                                border: Border.all(
                                    color: Colors.grey.withOpacity(0.1),
                                    width: 1.5)),
                            child: Text(
                              '-' +
                                  widget.hotelData.discountRate.toString() +
                                  "%",
                              style: TextStyles(context)
                                  .getRegularStyle()
                                  .copyWith(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  ),
                              textAlign: TextAlign.center,
                            )))
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
