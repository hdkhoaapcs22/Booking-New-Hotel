import 'package:booking_new_hotel/global/global_var.dart';
import 'package:booking_new_hotel/languages/appLocalizations.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../providers/theme_provider.dart';
import '../../utils/themes.dart';
import '../../widgets/common_card.dart';
import '../explore/home_explore_screen.dart';
import '../myTrips/my_trip_screen.dart';
import '../profile/profile_screen.dart';
import 'components/tab_button_UI.dart';

class BottomTapScreen extends StatefulWidget {
  const BottomTapScreen({super.key});

  @override
  State<BottomTapScreen> createState() => _BottomTapScreenState();
}

class _BottomTapScreenState extends State<BottomTapScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  BottomBarType bottomBarType = BottomBarType.Explore;
  bool isFirstTime = true;
  Widget indexView = Container(); // it will be used to show the screen

  @override
  void initState() {
    print("It is in initState of BottomTapScreen");
    animationController = AnimationController(
        duration: const Duration(milliseconds: 400), vsync: this);
    indexView = Container();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // it will run after the build method
      starLoadingScreen();
    });
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  Future starLoadingScreen() async {
    print("It is in starLoadingScreen of BottomTapScreen");
    await Future.delayed(
        const Duration(milliseconds: 480)); // it will wait for 480ms
    setState(() {
      isFirstTime = false;
      indexView = HomeExploreScreen(
        animationController: animationController,
      );
      animationController.forward(); //it helps to run the animation
    });
  }

  @override
  Widget build(BuildContext context) {
    print("It is in BottomTapScreen");
    return Consumer<ThemeProvider>(
      builder: (_, provider, child) => Scaffold(
          bottomNavigationBar: SizedBox(
            height: 60 + MediaQuery.of(context).padding.bottom,
            child: getBottomBarUI(bottomBarType),
          ),
          body: isFirstTime
              ? const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                )
              : indexView),
    );
  }

  getBottomBarUI(BottomBarType bottomBarType) {
    return CommonCard(
        color: AppTheme.backgroundColor, // if isLightMode -> white else black
        radius: 0,
        child: Column(children: [
          Row(
            children: [
              TabButtonUI(
                icon: Icons.search,
                isSelected: bottomBarType ==
                    BottomBarType
                        .Explore, // if true -> primaryColor else secondaryTextColor
                text: AppLocalizations(context).of("explore"),
                onTap: () {
                  tabClick(BottomBarType.Explore);
                },
              ),
              TabButtonUI(
                icon: FontAwesomeIcons.heart,
                isSelected: bottomBarType == BottomBarType.Trips,
                text: AppLocalizations(context).of("trips"),
                onTap: () {
                  tabClick(BottomBarType.Trips);
                },
              ),
              TabButtonUI(
                icon: FontAwesomeIcons.user,
                isSelected: bottomBarType == BottomBarType.Profile,
                text: AppLocalizations(context).of("profile"),
                onTap: () {
                  tabClick(BottomBarType.Profile);
                },
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ]));
  }

  void tabClick(BottomBarType tabType) {
    if (tabType != bottomBarType) {
      // check because if the user click on the same tab then no need to do anything
      bottomBarType = tabType;
      animationController.reverse().then((value) => {
            if (tabType == BottomBarType.Explore)
              {
                setState(() {
                  indexView = HomeExploreScreen(
                      animationController: animationController);
                })
              }
            else if (tabType == BottomBarType.Trips)
              {
                setState(() {
                  indexView =
                      MyTripsScreen(animationController: animationController);
                })
              }
            else if (tabType == BottomBarType.Profile)
              {
                setState(() {
                  indexView =
                      ProfileScreen(animationController: animationController);
                })
              }
          });
    }
  }
}

enum BottomBarType { Explore, Trips, Profile }
