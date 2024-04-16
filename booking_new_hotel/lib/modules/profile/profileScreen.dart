import 'package:booking_new_hotel/global/global_var.dart';
import 'package:booking_new_hotel/languages/appLocalizations.dart';
import 'package:booking_new_hotel/models/setting_list_data.dart';
import 'package:booking_new_hotel/providers/theme_provider.dart';
import 'package:booking_new_hotel/widgets/bottom_top_move_animation_view.dart';
import 'package:booking_new_hotel/widgets/common_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../routes/route_names.dart';
import '../../utils/localfiles.dart';

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
              children: [
                Padding(
                    padding: const EdgeInsets.only(left: 40),
                    child: Row(
                      children: [
                        GlobalVar.iconic.appIcon(context),
                        const SizedBox(width: 10),
                        GlobalVar.iconic.nameOfApp(context),
                        const SizedBox(width: 140),
                        InkWell(
                          onTap: () {
                            NavigationServices(context).gotoSettingsScreen();
                          },
                          child: Icon(
                            Icons.settings,
                            color: Theme.of(context).disabledColor,
                            size: 45,
                          ),
                        ),
                      ],
                    )),
                const SizedBox(height: 55),
                const Center(
                  child: CircleAvatar(
                    radius: 65,
                    backgroundImage: AssetImage(Localfiles.userImage),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                CommonButton(
                  padding: const EdgeInsets.only(left: 48, right: 48),
                  buttonText: AppLocalizations(context).of("edit_profile"),
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
                    NavigationServices(context).gotoProfileScreen();
                  },
                ),
                const SizedBox(height: 30),
                Divider(
                  height: 1,
                  color: Colors.grey.withOpacity(0.5),
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
