import 'package:booking_new_hotel/languages/appLocalizations.dart';
import 'package:booking_new_hotel/motel_app.dart';
import 'package:booking_new_hotel/providers/theme_provider.dart';
import 'package:booking_new_hotel/utils/enum.dart';
import 'package:booking_new_hotel/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../models/room_data.dart';
import '../widgets/custom_dialog.dart';
import '../widgets/custom_dialog_action_button.dart';

class Helper {
  static Widget ratingStar(double rating) {
    return RatingBarIndicator(
      rating: rating,
      itemBuilder: (context, index) => Icon(
        Icons.star,
        color: AppTheme.primaryColor,
      ),
      itemCount: 5,
      unratedColor: AppTheme.secondaryTextColor,
      itemSize: 18,
      direction: Axis.horizontal,
    );
  }

  static String getRoomText(RoomData roomData) {
    return "${roomData.numberOfBed} ${AppLocalizations(applicationcontext!).of("room")} ${roomData.numberOfPeople} ${AppLocalizations(applicationcontext!).of("people_data")}";
  }

  static String getListSearchDate(DateText dateText) {
    LanguageType languageType = applicationcontext == null
        ? LanguageType.en
        : applicationcontext!.read<ThemeProvider>().languageType;
    return "${dateText.startDate} - ${dateText.endDate} ${DateFormat('MMM', languageType.toString().split('.')[1]).format(DateTime.now().add(const Duration(days: 2)))}";
  }

  static String getDateText(DateText dateText) {
    LanguageType languageType = applicationcontext == null
        ? LanguageType.en
        : applicationcontext!.read<ThemeProvider>().languageType;
    return "${dateText.startDate} ${DateFormat('MMM', languageType.toString().split('.')[1]).format(DateTime.now().add(const Duration(days: 2)))} - ${dateText.endDate} ${DateFormat('MMM', languageType.toString().split('.')[1]).format(DateTime.now().add(const Duration(days: 2)))}";
  }

  static String getPeopleAndChildren(RoomData roomData) {
    return "${AppLocalizations(applicationcontext!).of("sleeps")} ${roomData.numberOfPeople}}";
  }

  Future<bool> showCommonPopup(
      String title, String description, BuildContext context,
      {bool isYesOrNoPopup = false, bool barrierDismissible = true}) async {
    bool isOkClick = false;
    return await showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) => CustomDialog(
        title: title,
        description: description,
        onCloseClick: () {
          Navigator.pop(context);
        },
        actionButtonList: isYesOrNoPopup
            ? <Widget>[
                CustomDialogActionButton(
                    buttonText: "NO",
                    color: Colors.green,
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
                CustomDialogActionButton(
                    buttonText: "YES",
                    color: Colors.red,
                    onPressed: () {
                      isOkClick = true;
                      Navigator.of(context).pop();
                    }),
              ]
            : <Widget>[
                CustomDialogActionButton(
                    buttonText: "OK",
                    color: Colors.green,
                    onPressed: () {
                      isOkClick = true;
                      Navigator.of(context).pop();
                    }),
              ],
      ),
    ).then((value) => isOkClick);
  }
}
