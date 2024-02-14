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
    return "${roomData.numberRoom} ${AppLocalizations(applicationcontext!).of("room_data")} ${roomData.people} ${AppLocalizations(applicationcontext!).of("people_data")}";
  }

  static String getListSearchDate(DateText dateText) {
    LanguageType languageType = applicationcontext == null
        ? LanguageType.en
        : applicationcontext!.read<ThemeProvider>().languageType;
    return "${dateText.startDate} - ${dateText.endDate} ${DateFormat('MMM', languageType.toString().split('.')[1]).format(DateTime.now().add(const Duration(days: 2)))}";
  }
}
