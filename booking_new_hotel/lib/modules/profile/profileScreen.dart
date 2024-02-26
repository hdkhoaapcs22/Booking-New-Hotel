import 'package:booking_new_hotel/languages/appLocalizations.dart';
import 'package:booking_new_hotel/models/setting_list_data.dart';
import 'package:booking_new_hotel/providers/theme_provider.dart';
import 'package:booking_new_hotel/widgets/bottom_top_move_animation_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../routes/route_names.dart';
import '../../utils/localfiles.dart';
import '../../utils/text_styles.dart';
import '../../utils/themes.dart';

class ProfileScreen extends StatefulWidget {
  final AnimationController animationController;
  const ProfileScreen({super.key, required this.animationController});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<SettingsListData> userSettingsList = SettingsListData.userSettingsList;

  @override
  initState() {
    widget.animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BottomTopMoveAnimationView(
      animationController: widget.animationController,
      child: Consumer<ThemeProvider>(
        builder: ((context, value, child) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(top: AppBar().preferredSize.height + 10),
                  child: Container(
                    child: appBar(),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(0.0),
                    physics: const BouncingScrollPhysics(),
                    itemCount: userSettingsList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          // Change Password Screen
                          switch (index) {
                            case 0:
                              {
                                NavigationServices(context)
                                    .gotoChangePasswordScreen();
                                break;
                              }
                            case 1:
                              {
                                NavigationServices(context)
                                    .gotoInviteFriendsScreen();
                                break;
                              }
                            case 2:
                              {
                                break;
                              }
                            case 3:
                              {
                                NavigationServices(context)
                                    .gotoHelpCenterScreen();
                                break;
                              }
                            case 4:
                              {
                                NavigationServices(context)
                                    .gotoSettingsScreen();
                                break;
                              }
                          }
                        },
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Text(
                                        AppLocalizations(context).of(
                                            userSettingsList[index].titleTxt),
                                        style: TextStyles(context)
                                            .getRegularStyle()
                                            .copyWith(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                            ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Container(
                                        child: Icon(
                                          userSettingsList[index].iconData,
                                          color: AppTheme.secondaryTextColor
                                              .withOpacity(0.7),
                                          size: 24,
                                        ),
                                      ))
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 16, right: 16),
                              child: Divider(
                                height: 1,
                                color: Colors.grey.withOpacity(0.4),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            )),
      ),
    );
  }

  appBar() {
    return InkWell(
      onTap: () {
        NavigationServices(context).gotoProfileScreen();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 24, right: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppLocalizations(context).of("view_edit"),
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      )),
                  Text(
                    AppLocalizations(context).of("view_edit"),
                    style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).disabledColor,
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(right: 24, left: 24, top: 16, bottom: 16),
            child: Container(
              width: 70,
              height: 70,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(40)),
                child: Image.asset(Localfiles.userImage),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
