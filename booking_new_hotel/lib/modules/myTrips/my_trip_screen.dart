import 'package:booking_new_hotel/languages/appLocalizations.dart';
import 'package:booking_new_hotel/providers/theme_provider.dart';
import 'package:booking_new_hotel/widgets/bottom_top_move_animation_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/enum.dart';
import '../../utils/text_styles.dart';
import '../../utils/themes.dart';
import '../../widgets/common_card.dart';
import 'favorites_list_view.dart';
// import 'finish_trip_view.dart';
import 'upcoming_list_view.dart';

class MyTripsScreen extends StatefulWidget {
  final AnimationController animationController;
  const MyTripsScreen({super.key, required this.animationController});

  @override
  State<MyTripsScreen> createState() => _MyTripsScreenState();
}

class _MyTripsScreenState extends State<MyTripsScreen>
    with TickerProviderStateMixin {
  late AnimationController tabAnimationController;
  Widget indexView = Container();
  TopBarType topBarType = TopBarType.Upcoming;

  @override
  void initState() {
    tabAnimationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    indexView = UpcomingListView(animationController: tabAnimationController);
    tabAnimationController.forward();
    widget.animationController.forward();
    super.initState();
  }

  Future<bool> getData() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return true;
  }

  @override
  void dispose() {
    tabAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BottomTopMoveAnimationView(
      animationController: widget.animationController,
      child: Consumer<ThemeProvider>(
        builder: (context, provider, child) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: Container(
                child: _getAppBar(),
              ),
            ),
            tabViewUI(topBarType),
            Expanded(child: indexView),
          ],
        ),
      ),
    );
  }

  _getAppBar() {
    return Padding(
      padding: EdgeInsets.only(
          left: 24, right: 24, top: AppBar().preferredSize.height),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppLocalizations(context).of("My_Trips"),
              style: TextStyles(context).getBoldStyle().copyWith(fontSize: 22)),
        ],
      ),
    );
  }

  tabViewUI(TopBarType tabType) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: CommonCard(
        color: AppTheme.backgroundColor,
        radius: 36,
        child: Column(
          children: [
            Row(
              children: [
                _getTabBarUI(() {
                  tabClick(TopBarType.Upcoming);
                },
                    tabType == TopBarType.Upcoming
                        ? AppTheme.primaryColor
                        : AppTheme.secondaryTextColor,
                    "upcoming"),
                _getTabBarUI(() {
                  tabClick(TopBarType.Favorites);
                },
                    tabType == TopBarType.Favorites
                        ? AppTheme.primaryColor
                        : AppTheme.secondaryTextColor,
                    "favorites"),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            )
          ],
        ),
      ),
    );
  }

  _getTabBarUI(VoidCallback onTap, Color color, String text) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(32.0)),
          highlightColor: Colors.transparent,
          splashColor: Theme.of(context).primaryColor.withOpacity(0.2),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16, top: 16),
            child: Center(
              child: Text(
                AppLocalizations(context).of(text),
                style: TextStyles(context).getRegularStyle().copyWith(
                      color: color,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void tabClick(TopBarType tabType) {
    // make color of current choice
    if (tabType != topBarType) {
      topBarType = tabType;
      tabAnimationController.reverse().then((value) {
        if (tabType == TopBarType.Upcoming) {
          setState(() {
            indexView =
                UpcomingListView(animationController: tabAnimationController);
          });
        } else {
          setState(() {
            indexView =
                FavoritesListView(animationController: tabAnimationController);
          });
        }
      });
    }
  }
}
