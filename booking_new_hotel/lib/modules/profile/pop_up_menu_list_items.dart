import 'package:flutter/material.dart';
import '../../utils/enum.dart';

class PopupMenuListItems {
  List<PopupMenuEntry<PopupListItems>> getPopupListItems() => [
        const PopupMenuItem(
            value: PopupListItems.Settings,
            child: Row(
              children: [
                Icon(Icons.settings),
                SizedBox(width: 10),
                Text('Settings'),
              ],
            )),
        const PopupMenuItem(
            value: PopupListItems.ChangePassword,
            child: Row(
              children: [
                Icon(Icons.lock),
                SizedBox(width: 10),
                Text('Change Password'),
              ],
            )),
      ];
}
