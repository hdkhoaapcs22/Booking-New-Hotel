import 'package:booking_new_hotel/routes/route_names.dart';
import 'package:booking_new_hotel/widgets/common_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../languages/appLocalizations.dart';
import '../../models/setting_list_data.dart';
import '../../utils/text_styles.dart';
import '../../utils/themes.dart';
import '../../widgets/common_app_bar_view.dart';
import '../../widgets/common_card.dart';
import '../../widgets/remove_focus.dart';

class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({super.key});

  @override
  State<HelpCenterScreen> createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  List<SettingsListData> helpSearchList = SettingsListData.helpSearchList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RemoveFocus(
        onClick: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Theme.of(context).primaryColor,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: appBar(),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).padding.bottom),
                itemCount: helpSearchList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: helpSearchList[index].subTxt != ""
                        ? () {
                            NavigationServices(context).gotoHowDoScreen();
                          }
                        : null,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 8,
                            right: 16,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Text(
                                    helpSearchList[index].titleTxt != ""
                                        ? AppLocalizations(context)
                                            .of(helpSearchList[index].titleTxt)
                                        : AppLocalizations(context)
                                            .of(helpSearchList[index].subTxt),
                                    style: TextStyles(context)
                                        .getRegularStyle()
                                        .copyWith(
                                          fontWeight:
                                              helpSearchList[index].titleTxt !=
                                                      ""
                                                  ? FontWeight.bold
                                                  : FontWeight.normal,
                                          fontSize:
                                              helpSearchList[index].titleTxt !=
                                                      ""
                                                  ? 18
                                                  : 14,
                                        ),
                                  ),
                                ),
                              ),
                              helpSearchList[index].subTxt != ""
                                  ? Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Icon(
                                        Icons.keyboard_arrow_right,
                                        color: Theme.of(context)
                                            .disabledColor
                                            .withOpacity(0.3),
                                      ),
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(left: 16, right: 16),
                            child: Divider(
                              height: 1,
                              color: Colors.grey.withOpacity(0.3),
                            ))
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  appBar() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonAppBarView(
          iconData: Icons.arrow_back,
          titleText: AppLocalizations(context).of("how_can_help_you"),
          onBackClick: () {
            Navigator.pop(context);
          },
          topPadding: AppBar().preferredSize.height + 10,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 24,
            right: 24,
            top: 16,
          ),
          child: CommonCard(
            color: AppTheme.backgroundColor,
            radius: 36,
            child: CommonSearchBar(
              // ignore: deprecated_member_use
              iconData: FontAwesomeIcons.search,
              text: AppLocalizations(context).of("search_help_artical"),
            ),
          ),
        )
      ],
    );
  }
}
