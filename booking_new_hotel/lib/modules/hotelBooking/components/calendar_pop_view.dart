import 'package:booking_new_hotel/modules/hotelBooking/components/custom_calendar.dart';
import 'package:booking_new_hotel/widgets/common_button.dart';
import 'package:booking_new_hotel/widgets/common_card.dart';
import 'package:booking_new_hotel/widgets/remove_focus.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../languages/appLocalizations.dart';
import '../../../motel_app.dart';
import '../../../providers/theme_provider.dart';
import '../../../utils/enum.dart';
import '../../../utils/text_styles.dart';
import '../../../utils/themes.dart';

class CalendarPopView extends StatefulWidget {
  final DateTime miniumDate;
  final DateTime maximumDate;
  final bool barrierDismissible;
  final DateTime initialStartDate;
  final DateTime initialEndDate;
  final Function(DateTime, DateTime) onApplyClick;
  final Function onCancelClick;

  const CalendarPopView(
      {super.key,
      required this.miniumDate,
      required this.maximumDate,
      this.barrierDismissible = true,
      required this.initialStartDate,
      required this.initialEndDate,
      required this.onApplyClick,
      required this.onCancelClick});

  @override
  State<CalendarPopView> createState() => _CalendarPopViewState();
}

class _CalendarPopViewState extends State<CalendarPopView>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  DateTime? startDate;
  DateTime? endDate;
  LanguageType _languageType = applicationcontext == null
      ? LanguageType.en
      : applicationcontext!.read<ThemeProvider>().languageType;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 400), vsync: this);
    startDate = widget.initialStartDate;
    endDate = widget.initialEndDate;
    animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: AnimatedBuilder(
            animation: animationController,
            builder: (BuildContext context, Widget? child) {
              return AnimatedOpacity(
                duration: const Duration(milliseconds: 100),
                opacity: animationController.value,
                child: RemoveFocus(
                  onClick: () {
                    if (widget.barrierDismissible) {
                      Navigator.pop(context);
                    }
                  },
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: CommonCard(
                        color: AppTheme.backgroundColor,
                        radius: 24,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                _getFromToUI(
                                    AppLocalizations(context).of("From_text"),
                                    startDate != null
                                        ? DateFormat(
                                                "EEE, dd MMM",
                                                _languageType
                                                    .toString()
                                                    .split(".")[1])
                                            .format(startDate!)
                                        : "---/---"),
                                Container(
                                  height: 74,
                                  width: 1,
                                  color: Colors.grey.withOpacity(0.2),
                                ),
                                _getFromToUI(
                                    AppLocalizations(context).of("to_text"),
                                    endDate != null
                                        ? DateFormat(
                                                "EEE, dd MMM",
                                                _languageType
                                                    .toString()
                                                    .split(".")[1])
                                            .format(endDate!)
                                        : "---/---"),
                              ],
                            ),
                            Divider(
                              height: 1,
                              color: Colors.grey.withOpacity(0.2),
                            ),
                            CustomCalendarView(
                              minimumDate: widget.miniumDate,
                              maximumDate: widget.maximumDate,
                              initialStartDate: widget.initialStartDate,
                              initialEndDate: widget.initialEndDate,
                              startEndDateChange: (DateTime startDateDate,
                                  DateTime endDateData) {
                                setState(() {
                                  startDate = startDateDate;
                                  endDate = endDateData;
                                });
                              },
                            ),
                            Padding(
                                padding: const EdgeInsets.only(
                                    left: 16, right: 16, top: 10, bottom: 15),
                                child: CommonButton(
                                    buttonText: AppLocalizations(context)
                                        .of("Apply_date"),
                                    onTap: () {
                                      try {
                                        widget.onApplyClick(
                                            startDate!, endDate!);
                                        Navigator.pop(context);
                                      } catch (e) {}
                                    }))
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }));
  }

  _getFromToUI(String title, String subTitle) {
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          textAlign: TextAlign.left,
          style:
              TextStyles(context).getDescriptionStyle().copyWith(fontSize: 16),
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          subTitle,
          textAlign: TextAlign.left,
          style: TextStyles(context).getDescriptionStyle().copyWith(
              fontSize: 16, color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ],
    ));
  }
}
