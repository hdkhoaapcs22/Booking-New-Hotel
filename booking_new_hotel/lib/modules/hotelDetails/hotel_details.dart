import 'dart:math';
import 'dart:ui';

import 'package:booking_new_hotel/languages/appLocalizations.dart';
import 'package:booking_new_hotel/models/hotel_list_data.dart';
import 'package:booking_new_hotel/utils/themes.dart';
import 'package:booking_new_hotel/widgets/common_button.dart';
import 'package:booking_new_hotel/widgets/common_card.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../routes/route_names.dart';
import '../../utils/helper.dart';
import '../../utils/text_styles.dart';
import 'rating_view.dart';

class HotelDetails extends StatefulWidget {
  final HotelListData hotelData;
  const HotelDetails({super.key, required this.hotelData});

  @override
  State<HotelDetails> createState() => _HotelDetailsState();
}

class _HotelDetailsState extends State<HotelDetails>
    with TickerProviderStateMixin {
  ScrollController scrollController =
      ScrollController(initialScrollOffset: 0.0);
  String hotelText1 =
      "Featuring a fit ness center, Grand Royale Park Hotel is located in Sweden, 4.7km from National Musium...";
  String hotelText2 =
      "Featuring a fit ness center, Grand Royale Park Hotel is located in Sweden, 4.7km from National Musium a fitness center ";

  bool isFav = false;
  bool isReadless = false;
  late AnimationController animationController;
  double imageHeight = 0.0;
  late AnimationController _animationController;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 0), vsync: this);
    animationController.forward();
    scrollController.addListener(() {
      if (mounted) {
        if (scrollController.offset < 0.0) {
          // we static set the just below half scrolling values
          _animationController.animateTo(0.0);
        } else if (scrollController.offset > 0.0 &&
            scrollController.offset < imageHeight) {
          if (scrollController.offset < (imageHeight / 1.2)) {
            _animationController
                .animateTo((scrollController.offset / imageHeight));
          } else {
            _animationController.animateTo((imageHeight / 1.2) / imageHeight);
          }
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    imageHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          // background image and hotel name and their details and more animation view
          // it is the details of hotel
          CommonCard(
            radius: 0,
            color: AppTheme.scaffoldBackgroundColor,
            child: ListView(
              controller: scrollController,
              padding: EdgeInsets.only(top: 20 + imageHeight, bottom: 4),
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: getHotelDetails(isInList: true),
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Divider(
                    height: 1,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 24, right: 24),
                  child: Row(children: [
                    Expanded(
                      child: Text(
                        AppLocalizations(context).of("summary"),
                        style: TextStyles(context)
                            .getBoldStyle()
                            .copyWith(fontSize: 18, letterSpacing: 0.5),
                      ),
                    ),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: !isReadless ? hotelText1 : hotelText2,
                            style: TextStyles(context)
                                .getDescriptionStyle()
                                .copyWith(fontSize: 14),
                            recognizer: TapGestureRecognizer()..onTap = () {}),
                        TextSpan(
                            text: !isReadless
                                ? AppLocalizations(context).of("read_more")
                                : AppLocalizations(context).of("less"),
                            style: TextStyles(context)
                                .getDescriptionStyle()
                                .copyWith(
                                    color: AppTheme.primaryColor, fontSize: 14),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                setState(() {
                                  isReadless = !isReadless;
                                });
                              })
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 16),
                  child: RatingView(hotelData: widget.hotelData),                  
                ),
                _getPhotoReviewUI("room_photo","view_all",Icons.arrow_forward,(){}),
              ],
            ),
          ),
          _backgroundImageUI(widget.hotelData),
          Padding(
            padding: EdgeInsets.only(top: AppBar().preferredSize.height),
            child: Container(
              height: AppBar().preferredSize.height,
              child: Row(children: [
                _getAppBarUI(Theme.of(context).disabledColor.withOpacity(0.4),
                    Icons.arrow_back, AppTheme.backgroundColor, () {
                  if (scrollController.offset != 0.0) {
                    scrollController.animateTo(0.0,
                        duration: const Duration(milliseconds: 480),
                        curve: Curves.easeInOutQuad);
                  } else {
                    Navigator.pop(context);
                  }
                }),
                const Expanded(
                  child: SizedBox(),
                ),
                _getAppBarUI(
                    AppTheme.backgroundColor,
                    isFav ? Icons.favorite : Icons.favorite_border,
                    AppTheme.primaryColor, () {
                  setState(() {
                    isFav = !isFav;
                  });
                })
              ]),
            ),
          ),
        ],
      ),
    );
  }

  _getAppBarUI(
      Color color, IconData icon, Color iconColor, VoidCallback onTap) {
    return SizedBox(
      height: AppBar().preferredSize.height,
      child: Padding(
        padding: const EdgeInsets.only(top: 8, left: 10, right: 10),
        child: Container(
          width: AppBar().preferredSize.height - 8,
          height: AppBar().preferredSize.height - 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(32.0)),
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(icon, color: iconColor),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getPhotoReviewUI(
      String title, String view, IconData icon, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24),
      child: Row(
        children: [
          Expanded(
            child: Text(
              AppLocalizations(context).of(title), style: TextStyles(context).getBoldStyle().copyWith(
                    fontSize: 14,
                  ),
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(4.0)),
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Row(
                  children: [
                    Text(
                      AppLocalizations(context).of(view),
                      textAlign: TextAlign.left,
                      style: TextStyles(context).getBoldStyle().copyWith(
                            fontSize: 14,
                            color: Theme.of(context).primaryColor,
                          ),
                    ),
                    SizedBox(
                      height: 38,
                      width: 20,
                      child: Icon(
                        icon,
                        size: 18,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _backgroundImageUI(HotelListData hotelData) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: AnimatedBuilder(
          animation: _animationController,
          builder: (BuildContext context, Widget? child) {
            var opacity = 1.0 -
                (_animationController.value == 0.64
                    ? 1.0
                    : _animationController.value);
            return SizedBox(
              height: imageHeight * (1.0 - _animationController.value),
              child: Stack(
                children: [
                  IgnorePointer(
                    child: Container(
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              child: Image.asset(hotelData.imagePath,
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: MediaQuery.of(context).padding.bottom + 16,
                    left: 0,
                    right: 0,
                    child: Opacity(
                      opacity: opacity,
                      child: Column(
                        children: [
                          Container(
                            // we use container here and clipRRect to ensure it has a blur container with certain size
                            padding: const EdgeInsets.only(left: 24, right: 24),
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(24.0)),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                    sigmaX: 10.0,
                                    sigmaY:
                                        10.0), // the more value, the more blur
                                child: Container(
                                  color: Colors.black12,
                                  padding: const EdgeInsets.all(4.0),
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 4),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 16,
                                          right: 16,
                                          top: 8,
                                        ),
                                        child: getHotelDetails(),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: CommonButton(
                                          buttonText: AppLocalizations(context)
                                              .of("book_now"),
                                          onTap: () {
                                            NavigationServices(context)
                                                .gotoRoomBookingScreen(
                                              widget.hotelData.titleTxt,
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Center(
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(24.0)),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                    sigmaX: 10.0, sigmaY: 10.0),
                                child: Container(
                                  color: Colors.black12,
                                  child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        splashColor: Theme.of(context)
                                            .primaryColor
                                            .withOpacity(0.2),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(38.0)),
                                        onTap: () {
                                          try {
                                            scrollController.animateTo(
                                                MediaQuery.of(context)
                                                        .size
                                                        .height -
                                                    MediaQuery.of(context)
                                                            .size
                                                            .height /
                                                        5,
                                                duration: const Duration(
                                                    milliseconds: 500),
                                                curve: Curves.fastOutSlowIn);
                                          } catch (e) {}
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 16,
                                              right: 16,
                                              top: 4,
                                              bottom: 4),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                AppLocalizations(context)
                                                    .of("more_details"),
                                                style: TextStyles(context)
                                                    .getBoldStyle()
                                                    .copyWith(
                                                      color: Colors.white,
                                                    ),
                                              ),
                                              const Padding(
                                                padding:
                                                    EdgeInsets.only(top: 2),
                                                child: Icon(
                                                  Icons.keyboard_arrow_down,
                                                  color: Colors.white,
                                                  size: 24,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      )),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }

  getHotelDetails({bool isInList = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.hotelData.titleTxt,
                  textAlign: TextAlign.left,
                  style: TextStyles(context).getBoldStyle().copyWith(
                      fontSize: 22,
                      color: isInList ? AppTheme.fontcolor : Colors.white)),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(widget.hotelData.subTxt,
                        style: TextStyles(context).getRegularStyle().copyWith(
                            fontSize: 14,
                            color: isInList
                                ? Theme.of(context)
                                    .disabledColor
                                    .withOpacity(0.5)
                                : Colors.white)),
                    const SizedBox(width: 4),
                    // ignore: deprecated_member_use
                    Icon(FontAwesomeIcons.mapMarkerAlt,
                        size: 12, color: AppTheme.primaryColor),
                    Text(
                      widget.hotelData.dist.toStringAsFixed(1),
                      overflow: TextOverflow.ellipsis,
                      style: TextStyles(context).getRegularStyle().copyWith(
                          fontSize: 14,
                          color: isInList
                              ? Theme.of(context).disabledColor.withOpacity(0.5)
                              : Colors.white),
                    ),

                    Expanded(
                      child: Text(
                        AppLocalizations(context).of("km_to_city"),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyles(context).getRegularStyle().copyWith(
                            fontSize: 14,
                            color: isInList
                                ? Theme.of(context)
                                    .disabledColor
                                    .withOpacity(0.5)
                                : Colors.white),
                      ),
                    ),
                  ]),
              isInList
                  ? const SizedBox()
                  : Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Row(
                        children: [
                          Helper.ratingStar(Random().nextDouble() * 5.1 + 3.5),
                          Text(
                            "${widget.hotelData.reviews}",
                            style: TextStyles(context)
                                .getRegularStyle()
                                .copyWith(
                                    fontSize: 14,
                                    color: isInList
                                        ? Theme.of(context)
                                            .disabledColor
                                            .withOpacity(0.5)
                                        : Colors.white),
                          ),
                          Text(AppLocalizations(context).of("reviews"),
                              style: TextStyles(context)
                                  .getRegularStyle()
                                  .copyWith(
                                      fontSize: 14,
                                      color: isInList
                                          ? Theme.of(context)
                                              .disabledColor
                                              .withOpacity(0.5)
                                          : Colors.white)),
                        ],
                      ),
                    ),
            ],
          ),
        ),
        Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "\$${widget.hotelData.perNight}",
                textAlign: TextAlign.left,
                style: TextStyles(context).getBoldStyle().copyWith(
                    fontSize: 22,
                    color: isInList
                        ? Theme.of(context).textTheme.bodyLarge!.color
                        : Colors.white),
              ),
              Text(
                AppLocalizations(context).of("per_night"),
                textAlign: TextAlign.left,
                style: TextStyles(context).getRegularStyle().copyWith(
                    fontSize: 14,
                    color: isInList
                        ? Theme.of(context).disabledColor
                        : Colors.white),
              ),
            ]),
      ],
    );
  }
}
