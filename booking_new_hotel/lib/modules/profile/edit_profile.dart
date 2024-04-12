import 'package:booking_new_hotel/languages/appLocalizations.dart';
import 'package:booking_new_hotel/utils/localfiles.dart';
import 'package:booking_new_hotel/widgets/common_app_bar_view.dart';
import 'package:booking_new_hotel/widgets/common_card.dart';
import 'package:booking_new_hotel/widgets/remove_focus.dart';
import 'package:flutter/material.dart';

import '../../models/setting_list_data.dart';
import '../../utils/text_styles.dart';
import '../../utils/themes.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  List<SettingsListData> userSettingsList = SettingsListData.userSettingsList;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: AppTheme.scaffoldBackgroundColor,
        body: RemoveFocus(
          onClick: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonAppBarView(
                iconData: Icons.arrow_back,
                titleText: AppLocalizations(context).of("edit_profile"),
                onBackClick: () {
                  Navigator.pop(context);
                },
                topPadding: AppBar().preferredSize.height + 10,
              ),
              Expanded(
                  child: ListView.builder(
                padding: EdgeInsets.only(
                    bottom: 16 + MediaQuery.of(context).padding.bottom),
                itemCount: userSettingsList.length,
                itemBuilder: (context, index) {
                  return index == 0
                      ? getProfileUI()
                      : InkWell(
                          onTap: () {},
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8, right: 16),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 16, bottom: 16, top: 16),
                                          child: Text(
                                            AppLocalizations(context).of(
                                                userSettingsList[index]
                                                    .titleTxt),
                                            style: TextStyles(context)
                                                .getDescriptionStyle()
                                                .copyWith(fontSize: 16),
                                          )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 16, bottom: 16, top: 16),
                                      child: Container(
                                        child: Text(
                                          userSettingsList[index].subTxt,
                                          style: TextStyles(context)
                                              .getDescriptionStyle()
                                              .copyWith(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                              ),
                                        ),
                                      ),
                                    ),
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
              ))
            ],
          ),
        ),
      ),
    );
  }

  getProfileUI() {
    return Padding(
        padding: EdgeInsets.only(bottom: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                width: 130,
                height: 130,
                child: Stack(alignment: Alignment.center, children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).dividerColor,
                          blurRadius: 8,
                          offset: const Offset(4, 4),
                        )
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(60.0)),
                      child: Image.asset(Localfiles.userImage),
                    ),
                  ),
                  Positioned(
                      bottom: 6,
                      right: 6,
                      child: CommonCard(
                          color: AppTheme.primaryColor,
                          radius: 36,
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(24.0)),
                              onTap: () {},
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.camera_alt,
                                  color:
                                      Theme.of(context).colorScheme.background,
                                  size: 18,
                                ),
                              ),
                            ),
                          )))
                ]))
          ],
        ));
  }
}
