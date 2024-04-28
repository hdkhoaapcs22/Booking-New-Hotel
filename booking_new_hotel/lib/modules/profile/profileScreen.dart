import 'package:booking_new_hotel/global/global_var.dart';
import 'package:booking_new_hotel/languages/appLocalizations.dart';
import 'package:booking_new_hotel/models/setting_list_data.dart';
import 'package:booking_new_hotel/utils/text_styles.dart';
import 'package:booking_new_hotel/widgets/bottom_top_move_animation_view.dart';
import 'package:booking_new_hotel/widgets/common_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../routes/route_names.dart';
import '../../utils/enum.dart';
import '../../utils/localfiles.dart';
import '../../utils/themes.dart';
import 'pop_up_menu_list_items.dart';

int count = 1;

class ProfileScreen extends StatefulWidget {
  final AnimationController animationController;
  const ProfileScreen({super.key, required this.animationController});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<SettingsListData> userSettingsList = SettingsListData.userSettingsList;
  Stream? userStream;
  var userInfoData;

  void fetchUserInfoData() async {
    userStream = await GlobalVar.databaseService!.getUserInfoData();
    setState(() {});
  }

  @override
  initState() {
    fetchUserInfoData();
    widget.animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(count++);
    return StreamBuilder(
        stream: userStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            userInfoData = snapshot.data!.docs[0];
            return BottomTopMoveAnimationView(
                animationController: widget.animationController,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(
                            left: 20, top: AppBar().preferredSize.height),
                        child: Row(
                          children: [
                            GlobalVar.iconic.appIcon(context),
                            const SizedBox(width: 10),
                            GlobalVar.iconic.nameOfApp(context),
                            const SizedBox(width: 200),
                            PopupMenuButton<PopupListItems>(
                              icon: const Icon(Icons.more_horiz),
                              offset: const Offset(-10, 38),
                              itemBuilder: (_) =>
                                  PopupMenuListItems().getPopupListItems(),
                              onSelected: (PopupListItems result) {
                                switch (result) {
                                  case PopupListItems.Settings:
                                    {
                                      NavigationServices(context)
                                          .gotoSettingsScreen();
                                      break;
                                    }
                                  case PopupListItems.ChangePassword:
                                    {
                                      NavigationServices(context)
                                          .gotoChangePasswordScreen();
                                      break;
                                    }
                                }
                              },
                            )
                          ],
                        )),
                    const SizedBox(height: 90),
                    const Center(
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: AssetImage(Localfiles.userImage),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    CommonButton(
                      padding: const EdgeInsets.only(left: 48, right: 48),
                      buttonTextWidget: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            FontAwesomeIcons.penToSquare,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            AppLocalizations(context).of("edit_profile"),
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        NavigationServices(context).gotoEditProfileScreen();
                      },
                    ),
                    const SizedBox(height: 28),
                    Divider(
                      height: 1,
                      color: Colors.grey.withOpacity(0.5),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: profileDetails(userInfoData),
                    )
                  ],
                ));
          }
          return const SizedBox();
        });
  }

  profileDetails(userInfoData) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.backgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(16.0)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(children: [
          profileItemDetail(
              "name", const Icon(FontAwesomeIcons.person), userInfoData),
          Divider(
            height: 2,
            color: Colors.grey.withOpacity(0.5),
            indent: 20,
            endIndent: 20,
          ),
          const SizedBox(height: 10),
          profileItemDetail(
              "mail_text", const Icon(FontAwesomeIcons.envelope), userInfoData),
          Divider(
            height: 2,
            color: Colors.grey.withOpacity(0.5),
            indent: 20,
            endIndent: 20,
          ),
          const SizedBox(height: 10),
          profileItemDetail(
              "phone", const Icon(FontAwesomeIcons.phone), userInfoData),
          Divider(
            height: 2,
            color: Colors.grey.withOpacity(0.5),
            indent: 20,
            endIndent: 20,
          ),
          const SizedBox(height: 10),
          profileItemDetail("address_text",
              const Icon(FontAwesomeIcons.locationArrow), userInfoData),
        ]),
      ),
    );
  }

  profileItemDetail(String item, Icon icon, userInfoData) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        icon,
        const SizedBox(width: 10),
        Text(AppLocalizations(context).of(item),
            style: TextStyles(context).getTitleStyle().copyWith(
                  fontSize: 20,
                )),
      ]),
      Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
        child: Text(
          chooseItem(item, userInfoData),
          style: TextStyles(context).getDescriptionStyle(),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ),
    ]);
  }

  chooseItem(String item, userInfoData) {
    switch (item) {
      case "name":
        {
          return userInfoData['name'];
        }
      case "mail_text":
        {
          return GlobalVar.user!.getEmail;
        }
      case "phone":
        {
          return userInfoData['phone'];
        }
      case "address_text":
        {
          return userInfoData['address'];
        }
    }
  }
}
