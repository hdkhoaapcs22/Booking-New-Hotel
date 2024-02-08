import 'dart:math';

import 'package:booking_new_hotel/languages/appLocalizations.dart';
import 'package:booking_new_hotel/models/hotel_list_data.dart';
import 'package:booking_new_hotel/modules/explore/home_explore_slider_view.dart';
import 'package:booking_new_hotel/modules/explore/hotel_list_view_page.dart';
import 'package:booking_new_hotel/widgets/bottom_top_move_animation_view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../providers/theme_provider.dart';
import '../../utils/enum.dart';
import '../../utils/text_styles.dart';
import '../../utils/themes.dart';
import '../../widgets/common_button.dart';
import '../../widgets/common_card.dart';
import '../../widgets/common_search_bar.dart';
import 'popular_list_view.dart';
import 'title_view.dart';

class HomeExploreScreen extends StatefulWidget {
  final AnimationController animationController;

  const HomeExploreScreen({super.key, required this.animationController});

  @override
  State<HomeExploreScreen> createState() => _HomeExploreScreenState();
}

class _HomeExploreScreenState extends State<HomeExploreScreen>
    with TickerProviderStateMixin {
  var hotelList = HotelListData.hotelList;
  late ScrollController scrollController;
  late AnimationController animationController;
  var sliderImageHeight = 0.0;

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 0));
    widget.animationController.forward();
    scrollController = ScrollController(initialScrollOffset: 0.0);
    scrollController.addListener(() {
      if (mounted) {
        // check if the state is 'mounted'
        if (scrollController.offset < 0) {
          // set a static value below half scrolling values
          animationController.animateTo(0.0);
        } else if (scrollController.offset > 0.0 &&
            scrollController.offset < sliderImageHeight) {
          //we need around half scrolling values
          if (scrollController.offset < ((sliderImageHeight / 1.5))) {
            animationController
                .animateTo((scrollController.offset / sliderImageHeight));
          } else {
            animationController
                .animateTo(((sliderImageHeight / 1.5) / sliderImageHeight));
          }
        }
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    sliderImageHeight = MediaQuery.of(context).size.width * 1.3;
    return BottomTopMoveAnimationView(
        animationController: widget.animationController,
        child: Consumer<ThemeProvider>(
            builder: (Context, value, child) => Stack(children: [
                  Container(
                      color: AppTheme.scaffoldBackgroundColor,
                      child: ListView.builder(
                          controller: scrollController,
                          itemCount: 4,
                          padding: EdgeInsets.only(
                              top: sliderImageHeight + 32, bottom: 16),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            var count = 4;
                            var animation = Tween(begin: 0.0, end: 1.0).animate(
                              CurvedAnimation(
                                  parent: widget.animationController,
                                  curve: Curves.fastOutSlowIn),
                            );
                            if (index == 0) {
                              return TitleView(
                                titleText: AppLocalizations(context)
                                    .of("popular_destination"),
                                animationController: widget.animationController,
                                animation: animation,
                                click: () {},
                              );
                            } else if (index == 1) {
                              return Padding(
                                padding: EdgeInsets.only(top: 8),
                                child: PopularListView(
                                  animationController:
                                      widget.animationController,
                                  callBack: (index) {},
                                ),
                              );
                            } else if (index == 2) {
                              return TitleView(
                                  titleText:
                                      AppLocalizations(context).of("best_deal"),
                                  subText:
                                      AppLocalizations(context).of("view_all"),
                                  animationController:
                                      widget.animationController,
                                  animation: animation,
                                  isLeftButton: true,
                                  click: () {});
                            } else {
                              return getDealListView(index);
                            }
                          })),
                  sliderUI(), // animated slider UI
                  viewHotelButton(
                      animationController), // view hotel Button UI for on click event

                  //search bar UI
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                        height: 80,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                          colors: [
                            Theme.of(context)
                                .colorScheme
                                .background
                                .withOpacity(0.4),
                            Theme.of(context)
                                .colorScheme
                                .background
                                .withOpacity(0.0),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ))),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).padding.top,
                    left: 0,
                    right: 0,
                    child: searchUI(),
                  )
                ])));
  }

  sliderUI() {
    return Positioned(
        top: 0,
        left: 0,
        right: 0,
        child: AnimatedBuilder(
            animation: animationController,
            builder: (BuildContext context, Widget? child) {
              var opecity = 1.0 -
                  (animationController.value == 0.64
                      ? 1.0
                      : animationController.value);
              return SizedBox(
                  height: sliderImageHeight * (1.0 - animationController.value),
                  child: HomeExploreSliderView(
                    opValue: opecity,
                    click: () {},
                  ));
            }));
  }

  viewHotelButton(AnimationController animationController) {
    return AnimatedBuilder(
        animation: animationController,
        builder: (BuildContext context, Widget? child) {
          var opecity = 1.0 -
              (animationController.value == 0.64
                  ? 1.0
                  : animationController.value);
          return Positioned(
              left: 0,
              right: 0,
              top: 0,
              height: sliderImageHeight * (1.0 - animationController.value),
              child: Stack(children: [
                Positioned(
                    bottom: 32,
                    right: context.read<ThemeProvider>().languageType ==
                            LanguageType.ar
                        ? 24
                        : null,
                    left: context.read<ThemeProvider>().languageType ==
                            LanguageType.ar
                        ? null
                        : 24,
                    child: Opacity(
                      opacity: opecity,
                      child: CommonButton(
                        onTap: () {
                          if (opecity != 0) {
                            const Scaffold();
                          }
                        },
                        buttonTextWidget: Padding(
                            padding: const EdgeInsets.only(
                                left: 24, right: 24, top: 8, bottom: 8),
                            child: Text(
                              AppLocalizations(context).of("view_hotel"),
                              style: TextStyles(context)
                                  .getRegularStyle()
                                  .copyWith(color: AppTheme.whiteColor),
                            )),
                      ),
                    ))
              ]));
        });
  }

  searchUI() {
    return Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, top: 65),
        child: CommonCard(
            radius: 36,
            child: InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(30)),
              onTap: () {},
              child: CommonSearchBar(
                // ignore: deprecated_member_use
                iconData: FontAwesomeIcons.search,
                enabled: false,
                text: AppLocalizations(context).of("where_are_you_going"),
              ),
            )));
  }

  Widget getDealListView(int index) {
    var hotelList = HotelListData.hotelList;
    List<Widget> list = [];
    hotelList.forEach((element) {
      var animation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: widget.animationController,
          curve: Interval(0, 1.0, curve: Curves.fastOutSlowIn),
        ),
      );
      list.add(
        HotelListViewPage(
            callback: () {},
            hotelData: element,
            animationController: widget.animationController,
            animation: animation,
            rating:Random().nextDouble() * 5.1 + 1.0
            ),
      );
    });
    return Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Column(
          children: list,
        ));
  }
}
