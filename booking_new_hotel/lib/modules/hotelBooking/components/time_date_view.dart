import 'package:booking_new_hotel/languages/appLocalizations.dart';
import 'package:booking_new_hotel/motel_app.dart';
import 'package:booking_new_hotel/providers/theme_provider.dart';
import 'package:booking_new_hotel/utils/enum.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../models/room_data.dart';
import '../../../utils/helper.dart';
import '../../../utils/text_styles.dart';
import '../../../utils/themes.dart';
import 'calendar_pop_view.dart';
import 'room_pop_up_view.dart';

// ignore: must_be_immutable
class TimeDateView extends StatefulWidget {
  Function(DateTime, DateTime, RoomData) callback;
  TimeDateView(this.callback, {Key? key}) : super(key: key);

  @override
  State<TimeDateView> createState() => _TimeDateViewState();
}

class _TimeDateViewState extends State<TimeDateView> {
  RoomData _roomData = RoomData(numberOfBed: 0, numberOfPeople: 0);
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 5));
  LanguageType _languageType = applicationcontext == null
      ? LanguageType.en
      : applicationcontext!.read<ThemeProvider>().languageType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 16, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _getRoomDateUI(
            AppLocalizations(context).of("choose_date"),
            "${DateFormat("dd, MMM", _languageType.toString().split(".")[1]).format(startDate)} - ${DateFormat("dd, MMM", _languageType.toString().split(".")[1]).format(endDate)} ",
            () {
              ///add date picker
              _showDialog(context);
            },
          ),
          Container(
            width: 1,
            height: 42,
            color: Colors.grey.withOpacity(0.8),
          ),
          _getRoomDateUI(
            AppLocalizations(context).of("number_room"),
            Helper.getRoomText(_roomData),
            () {
              ///add date picker
              _showPopUp();
            },
          )
        ],
      ),
    );
  }

  Widget _getRoomDateUI(String title, String subTitle, VoidCallback onTap) {
    return Expanded(
        child: Row(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(4)),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyles(context)
                        .getDescriptionStyle()
                        .copyWith(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    subTitle,
                    style: TextStyles(context).getDescriptionStyle().copyWith(
                        fontSize: 16, color: AppTheme.primaryTextColor),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ));
  }

  void _showDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => CalendarPopView(
              barrierDismissible: true,
              miniumDate: DateTime.now(),
              maximumDate: DateTime(DateTime.now().year, DateTime.now().month,
                  DateTime.now().day + 10),
              initialStartDate: startDate,
              initialEndDate: endDate,
              onApplyClick: (DateTime startData, DateTime endData) {
                setState(() {
                  startDate = startData;
                  endDate = endData;
                  widget.callback(startDate, endDate, _roomData);
                });
              },
              onCancelClick: () {},
            ));
  }

  void _showPopUp() {
    showDialog(
        context: context,
        builder: (BuildContext context) => RoomPopupView(
              barrierDismissible: true,
              roomData: _roomData,
              onChange: (data) {
                setState(() {
                  _roomData = data;
                  widget.callback(startDate, endDate, _roomData);
                });
              },
            ));
  }
}
