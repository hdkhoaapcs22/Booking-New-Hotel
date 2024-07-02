import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SettingsListData {
  String titleTxt;
  String subTxt;
  IconData iconData;
  bool isSelected;

  SettingsListData({
    this.titleTxt = '',
    this.isSelected = false,
    this.subTxt = '',
    this.iconData = Icons.supervised_user_circle,
  });

  static List<SettingsListData> userSettingsList = [
    SettingsListData(
      titleTxt: "change_password",
      isSelected: false,
      iconData: FontAwesomeIcons.lock,
    ),
  ];
  static List<SettingsListData> settingsList = [
    SettingsListData(
      titleTxt: "Theme Mode",
      isSelected: false,
      iconData: FontAwesomeIcons.skyatlas,
    ),
    SettingsListData(
      titleTxt: "Fonts",
      isSelected: false,
      iconData: FontAwesomeIcons.font,
    ),
    SettingsListData(
      titleTxt: "Color",
      isSelected: false,
      iconData: Icons.color_lens,
    ),
    SettingsListData(
      titleTxt: "Language",
      isSelected: false,
      iconData: Icons.translate_outlined,
    ),
    SettingsListData(
      titleTxt: 'Log out',
      isSelected: false,
      iconData: Icons.keyboard_arrow_right,
    )
  ];
}
