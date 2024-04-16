import 'package:booking_new_hotel/providers/theme_provider.dart';
import 'package:booking_new_hotel/routes/route_names.dart';
import 'package:booking_new_hotel/utils/enum.dart';
import 'package:booking_new_hotel/utils/text_styles.dart';
import 'package:booking_new_hotel/widgets/remove_focus.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../languages/appLocalizations.dart';
import '../../models/setting_list_data.dart';
import '../../utils/themes.dart';
import '../../widgets/common_app_bar_view.dart';
import '../../widgets/common_card.dart';
import '../../utils/helper.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  List<SettingsListData> settingsList = SettingsListData.settingsList;
  String country = "Indian";
  String currency = "₹ Rupee";
  int selectedRadioTile = 0;
  List<String> data = ["English", "French", "Arabic", "Japanese"];
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, value, child) {
      return Scaffold(
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
                titleText: AppLocalizations(context).of("setting_text"),
                onBackClick: () {
                  Navigator.pop(context);
                },
                topPadding: AppBar().preferredSize.height + 10,
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: 16),
                  itemCount: settingsList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                        onTap: () {
                          switch (index) {
                            case 1:
                              {
                                break;
                              }
                            case 2:
                              {
                                _getFontPopUI();
                                break;
                              }
                            case 3:
                              {
                                _getColorPopUI();
                                break;
                              }
                            case 4:
                              {
                                _getLanguageUI();
                                break;
                              }
                            case 5:
                              {
                                NavigationServices(context)
                                    .gotoCountryScreen()
                                    .then((value) {
                                  if (value is String && value != "") {
                                    setState(() {
                                      country = value;
                                    });
                                  }
                                });
                              }
                            case 6:
                              {
                                NavigationServices(context)
                                    .gotoCurrencyScreen()
                                    .then((value) {
                                  if (value is String && value != "") {
                                    setState(() {
                                      currency = value;
                                    });
                                  }
                                });
                              }
                            case 10:
                              {
                                _logout();
                                break;
                              }
                          }
                        },
                        child: Column(
                          children: [
                            Padding(
                              padding:const EdgeInsets.only(left: 8, right: 16),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Text(
                                        AppLocalizations(context)
                                            .of(settingsList[index].titleTxt),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                  index == 5
                                      ? Padding(
                                          padding: const EdgeInsets.all(16),
                                          child: getTextUI(country),
                                        )
                                      : index == 6
                                          ? Padding(
                                              padding: const EdgeInsets.all(16),
                                              child: getTextUI(currency),
                                            )
                                          : index == 1
                                              ? _themeUI()
                                              : Padding(
                                                  padding:
                                                      const EdgeInsets.all(16),
                                                  child: Container(
                                                    child: Icon(
                                                      settingsList[index]
                                                          .iconData,
                                                      color: AppTheme
                                                          .secondaryTextColor,
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
                        ));
                  },
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  _themeUI() {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(right: 4.0),
      child: PopupMenuButton<ThemeModeType>(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        onSelected: (type) {
          type == ThemeModeType.system
              ? themeProvider.updateThemeMode(ThemeModeType.system)
              : type == ThemeModeType.light
                  ? themeProvider.updateThemeMode(ThemeModeType.light)
                  : themeProvider.updateThemeMode(ThemeModeType.dark);
          setState(() {});
        },
        // ignore: deprecated_member_use
        icon: Icon(
          themeProvider.themeModeType == ThemeModeType.system
              // ignore: deprecated_member_use
              ? FontAwesomeIcons.adjust
              : themeProvider.themeModeType == ThemeModeType.light
                  ? FontAwesomeIcons.cloudSun
                  : FontAwesomeIcons.cloudMoon,
          color: AppTheme.secondaryTextColor,
        ),
        offset: const Offset(10, 18),
        itemBuilder: (context) => [
          ...ThemeModeType.values.toList().map(
                (e) => PopupMenuItem(
                  value: e,
                  child: _getSelectedUI(
                    e == ThemeModeType.system
                        ?
                        // ignore: deprecated_member_use
                        FontAwesomeIcons.adjust
                        : e == ThemeModeType.light
                            ? FontAwesomeIcons.cloudSun
                            : FontAwesomeIcons.cloudMoon,
                    AppLocalizations(context).of(e.toString().split('.')[1]),
                    e == themeProvider.themeModeType,
                  ),
                ),
              ),
        ],
      ),
    );
  }

  getTextUI(String text) {
    return Container(
        child: Text(
      text,
      style: TextStyles(context).getDescriptionStyle().copyWith(fontSize: 16),
    ));
  }

  _getSelectedUI(IconData icon, String text, bool isCurrent) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Icon(
            icon,
            color: isCurrent ? AppTheme.primaryColor : AppTheme.primaryColor,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Text(
              text,
              style: TextStyles(context).getRegularStyle().copyWith(
                  color: isCurrent
                      ? AppTheme.primaryColor
                      : AppTheme.primaryTextColor),
            ),
          ),
        ],
      ),
    );
  }

  _getFontPopUI() {
    final List<Widget> fontArray = [];
    FontFamilyType.values.toList().forEach((element) {
      fontArray.add(
        Expanded(
          child: InkWell(
            splashColor: Colors.transparent,
            borderRadius: BorderRadius.circular(8.0),
            onTap: () {
              context.read<ThemeProvider>().updateFontType(element);
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations(context).of("Hello"),
                    style: AppTheme.getTextStyle(
                      element,
                      TextStyles(context).getRegularStyle().copyWith(
                          color:
                              context.read<ThemeProvider>().fontType == element
                                  ? AppTheme.primaryColor
                                  : AppTheme.fontcolor),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: FontFamilyType.WorkSans == element ? 3 : 0,
                    ),
                    child: Text(
                      element.toString().split('.')[1],
                      style: AppTheme.getTextStyle(
                        element,
                        TextStyles(context).getRegularStyle().copyWith(
                            color: context.read<ThemeProvider>().fontType ==
                                    element
                                ? AppTheme.primaryColor
                                : AppTheme.fontcolor),
                      ).copyWith(fontSize: 10),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
    return showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(48.0),
            child: CommonCard(
              color: AppTheme.backgroundColor,
              radius: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                          AppLocalizations(context).of("selected_fonts"),
                          style: TextStyles(context)
                              .getBoldStyle()
                              .copyWith(fontSize: 22))),
                  Divider(
                    height: 1,
                    color: Colors.grey.withOpacity(0.25),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            fontArray[0],
                            fontArray[1],
                            fontArray[2],
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            fontArray[3],
                            fontArray[4],
                            fontArray[5],
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _getColorPopUI() {
    final List<Widget> colorArray = [];
    ColorType.values.toList().forEach((element) {
      colorArray.add(
        Expanded(
          child: InkWell(
            splashColor: Colors.transparent,
            borderRadius: BorderRadius.circular(8.0),
            onTap: () {
              context.read<ThemeProvider>().updateColorType(element);
              Navigator.pop(context);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    height: 48,
                    width: 48,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color:
                            context.read<ThemeProvider>().colorType == element
                                ? AppTheme.getColor(element)
                                : Colors.transparent,
                      ),
                    ),
                    child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                            decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppTheme.getColor(element),
                        ))),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
    return showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(48.0),
            child: CommonCard(
              color: AppTheme.backgroundColor,
              radius: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                          AppLocalizations(context).of("selected_color"),
                          style: TextStyles(context)
                              .getBoldStyle()
                              .copyWith(fontSize: 22))),
                  Divider(
                    height: 1,
                    color: Colors.grey.withOpacity(0.25),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            colorArray[0],
                            colorArray[1],
                            colorArray[2],
                            colorArray[3],
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _getLanguageUI() {
    final List<Widget> languageArray = [];
    LanguageType.values.toList().forEach((element) {
      languageArray.add(
        InkWell(
          splashColor: Colors.transparent,
          borderRadius: BorderRadius.circular(8.0),
          onTap: () {
            context.read<ThemeProvider>().updateLanguage(element);
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                context.read<ThemeProvider>().languageType == element
                    ? const Icon(
                        Icons.radio_button_checked,
                      )
                    : const Icon(
                        Icons.radio_button_off,
                      ),
                Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Text(data[element.index]))
              ],
            ),
          ),
        ),
      );
    });
    return showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 240,
            child: CommonCard(
              color: AppTheme.backgroundColor,
              radius: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(top: 16.0, bottom: 8),
                      child: Text(
                          AppLocalizations(context).of("Selected language"),
                          style: TextStyles(context)
                              .getBoldStyle()
                              .copyWith(fontSize: 22))),
                  Divider(
                    height: 1,
                    color: Colors.grey.withOpacity(0.25),
                  ),
                  for (var item in languageArray) item,
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _logout() async {
    bool isOk = await Helper().showCommonPopup(
      "Are you sure?",
      "Do you want to logout?",
      context,
      isYesOrNoPopup: true,
      barrierDismissible: true,
    );

    if (isOk) {
      NavigationServices(context).gotoSplashScreen();
    }
  }
}
