import 'package:booking_new_hotel/widgets/common_app_bar_view.dart';
import 'package:booking_new_hotel/widgets/remove_focus.dart';
import 'package:flutter/material.dart';

import '../../models/setting_list_data.dart';
import '../../utils/text_styles.dart';
import '../../utils/themes.dart';

class HowDoScreen extends StatefulWidget {
  final String title;
  const HowDoScreen({super.key, this.title = ""});

  @override
  State<HowDoScreen> createState() => _HowDoScreenState();
}

class _HowDoScreenState extends State<HowDoScreen> {
  List<SettingsListData> subHelpList = SettingsListData.subHelpList;

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
                iconData: Icons.arrow_back_ios_new,
                titleText: "How do I cancel my rooms ?",
                onBackClick: () {
                  Navigator.pop(context);
                },
                topPadding: AppBar().preferredSize.height + 10,
              ),
              Expanded(
                  child: ListView.builder(
                padding: EdgeInsets.only(
                    bottom: 16 + MediaQuery.of(context).padding.bottom),
                itemCount: subHelpList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: subHelpList[index].isSelected ? () {} : null,
                    child: Column(
                      children: [
                        Text(subHelpList[index].titleTxt),
                        Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: Row(
                            children: [
                              Expanded(
                                child: subHelpList[index].titleTxt != ""
                                    ? Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: Text(
                                          subHelpList[index].titleTxt,
                                          style: TextStyles(context)
                                              .getBoldStyle()
                                              .copyWith(fontSize: 18),
                                        ),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.only(
                                            right: 12,
                                            bottom: 16,
                                            top: 8,
                                            left: 16),
                                        child: Text(
                                          subHelpList[index].subTxt,
                                          style: TextStyles(context)
                                              .getRegularStyle()
                                              .copyWith(
                                                fontSize: 16,
                                                color: subHelpList[index]
                                                        .isSelected
                                                    ? AppTheme.primaryColor
                                                    : AppTheme
                                                        .secondaryTextColor,
                                              ),
                                        ),
                                      ),
                              ),
                            ],
                          ),
                        ),
                        subHelpList[index].isSelected
                            ? Padding(
                                padding:
                                    const EdgeInsets.only(left: 16, right: 16),
                                child: Divider(
                                  height: 1,
                                  color: Colors.grey.withOpacity(0.1),
                                ),
                              )
                            : const SizedBox(),
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
}
