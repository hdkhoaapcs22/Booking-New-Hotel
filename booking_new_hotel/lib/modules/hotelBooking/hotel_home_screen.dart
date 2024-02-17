import 'dart:math';

import 'package:booking_new_hotel/languages/appLocalizations.dart';
import 'package:booking_new_hotel/providers/theme_provider.dart';
import 'package:booking_new_hotel/routes/route_names.dart';
import 'package:booking_new_hotel/utils/enum.dart';
import 'package:booking_new_hotel/widgets/common_card.dart';
import 'package:booking_new_hotel/widgets/remove_focus.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../models/hotel_list_data.dart';
import '../../utils/text_styles.dart';
import '../../utils/themes.dart';
import '../../widgets/common_search_bar.dart';
import '../myTrips/hotel_list_view.dart';
import 'components/filter_bar_UI.dart';
import 'components/map_and_list_view.dart';
import 'components/time_date_view.dart';

class HotelHomeScreen extends StatefulWidget {
  const HotelHomeScreen({super.key});

  @override
  State<HotelHomeScreen> createState() => _HotelHomeScreenState();
}

class _HotelHomeScreenState extends State<HotelHomeScreen>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late AnimationController _animationController;
  var hotelList = HotelListData.hotelList;
  ScrollController scrollController = ScrollController();

  int room = 1;
  int add = 2;

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 5));

  bool _isShowMap = false;

  final searchBarHeight = 158.0;
  final filterBarHeight = 52.0;

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));

    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 0));

    scrollController.addListener(() {
      if (mounted) {
        // check if the state is 'mounted'
        if (scrollController.offset <= 0) {
          // set a static value below half scrolling values
          _animationController.animateTo(0.0);
        } else if (scrollController.offset > 0.0 &&
            scrollController.offset < searchBarHeight) {
          //we need around half scrolling values
          _animationController
              .animateTo((scrollController.offset / searchBarHeight));
        } else {
          _animationController.animateTo(1.0);
        }
      }
    });

    super.initState();
  }

  Future<bool> getData() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return true;
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          RemoveFocus(
            onClick: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Column(
              children: [
                _getAppBarUI(),
                _isShowMap
                    ? _getSearchBarUI()
                    : Expanded(
                        child: Stack(children: [
                        Container(
                          color: AppTheme.scaffoldBackgroundColor,
                          child: ListView.builder(
                            controller: scrollController,
                            itemCount: hotelList.length,
                            padding: const EdgeInsets.only(
                              top: 8 + 158 + 52.0,
                            ),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              var count =
                                  hotelList.length > 10 ? 10 : hotelList.length;
                              var animation =
                                  Tween(begin: 0.0, end: 1.0).animate(
                                CurvedAnimation(
                                  parent: animationController,
                                  curve: Interval((1 / count) * index, 1.0,
                                      curve: Curves.fastOutSlowIn),
                                ),
                              );
                              animationController.forward();
                              return HotelListView(
                                  callback: () {
                                    NavigationServices(context)
                                        .gotoRoomBookingScreen(
                                            hotelList[index].titleTxt);
                                  },
                                  hotelData: hotelList[index],
                                  animation: animation,
                                  animationController: animationController,
                                  ratingOfHotel:
                                      Random().nextDouble() * 5.1 + 3.5);
                            },
                          ),
                        ),
                        AnimatedBuilder(
                          animation: _animationController,
                          builder: (BuildContext context, Widget? child) {
                            return Positioned(
                                top: -searchBarHeight *
                                    (_animationController.value),
                                left: 0,
                                right: 0,
                                child: Column(
                                  children: [
                                    Container(
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      child: Column(
                                        children: [
                                          Container(
                                            color: Theme.of(context)
                                                .scaffoldBackgroundColor,
                                            child: Column(
                                              children: [
                                                // hotel search view
                                                _getSearchBarUI(),

                                                // time date and no of rooms view
                                                const TimeDateView(),
                                              ],
                                            ),
                                          ),
                                          const FilterBarUI(),
                                        ],
                                      ),
                                    ),
                                  ],
                                ));
                          },
                        )
                      ]))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _getAppBarUI() {
    return Padding(
      padding: EdgeInsets.only(
          top: AppBar().preferredSize.height + 10, left: 8, right: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            alignment:
                context.read<ThemeProvider>().languageType == LanguageType.ar
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
            width: AppBar().preferredSize.height + 40,
            height: AppBar().preferredSize.height,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                  borderRadius: const BorderRadius.all(Radius.circular(32.0)),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8),
                    child: Icon(Icons.arrow_back),
                  )),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                AppLocalizations(context).of("explore"),
                style: TextStyles(context).getTitleStyle(),
              ),
            ),
          ),
          Container(
            width: AppBar().preferredSize.height + 40,
            height: AppBar().preferredSize.height,
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(32.0)),
                      onTap: () {},
                      child: const Padding(
                        padding: EdgeInsets.all(8),
                        child: Icon(
                          Icons.favorite_border,
                        ),
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(32.0)),
                      onTap: () {
                        _isShowMap = !_isShowMap;
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Icon(
                          _isShowMap
                              ? Icons.sort
                              // ignore: deprecated_member_use
                              : FontAwesomeIcons.mapMarkedAlt,
                        ),
                      ),
                    ),
                  ),
                ]),
          )
        ],
      ),
    );
  }

  Widget _getSearchBarUI() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 16, top: 8, bottom: 8),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CommonCard(
                color: AppTheme.backgroundColor,
                radius: 36,
                child: const CommonSearchBar(
                  enabled: true,
                  isShow: false,
                  text: "Lodon...",
                ),
              ),
            ),
          ),
          CommonCard(
            color: AppTheme.primaryColor,
            radius: 36,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  NavigationServices(context).gotoSearchScreen();
                },
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  // ignore: deprecated_member_use
                  child: Icon(FontAwesomeIcons.search,
                      size: 20, color: AppTheme.backgroundColor),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
