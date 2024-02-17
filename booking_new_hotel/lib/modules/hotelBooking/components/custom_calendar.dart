import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../motel_app.dart';
import '../../../providers/theme_provider.dart';
import '../../../utils/enum.dart';
import '../../../utils/text_styles.dart';
import '../../../utils/themes.dart';

class CustomCalendarView extends StatefulWidget {
  final DateTime minimumDate;
  final DateTime maximumDate;
  final DateTime initialStartDate;
  final DateTime initialEndDate;
  final Function(DateTime, DateTime) startEndDateChange;

  const CustomCalendarView(
      {super.key,
      required this.minimumDate,
      required this.maximumDate,
      required this.initialStartDate,
      required this.initialEndDate,
      required this.startEndDateChange});

  @override
  State<CustomCalendarView> createState() => _CustomCalendarViewState();
}

class _CustomCalendarViewState extends State<CustomCalendarView> {
  List<DateTime> dateList = [];
  var currentMonthDate = DateTime.now();
  DateTime? startDate;
  DateTime? endDate;
  LanguageType _languageType = applicationcontext == null
      ? LanguageType.en
      : applicationcontext!.read<ThemeProvider>().languageType;

  @override
  void initState() {
    setListOfDate(currentMonthDate);
    startDate = widget.initialStartDate;
    endDate = widget.initialEndDate;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
          child: Row(
            children: [
              _getCircleUI(
                () {
                  setState(() {
                    currentMonthDate = DateTime(
                        currentMonthDate.year, currentMonthDate.month, 0);
                    setListOfDate(currentMonthDate);
                  });
                },
                Icons.keyboard_arrow_left,
              ),
              Expanded(
                  child: Center(
                      child: Text(
                DateFormat("MMMM, yyyy", _languageType.toString().split(".")[1])
                    .format(currentMonthDate),
                style: TextStyles(context).getRegularStyle().copyWith(
                      fontSize: 16,
                    ),
              ))),
              _getCircleUI(
                () {
                  setState(() {
                    currentMonthDate = DateTime(
                        currentMonthDate.year, currentMonthDate.month + 2, 0);
                    setListOfDate(currentMonthDate);
                  });
                },
                Icons.keyboard_arrow_right,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            right: 8,
            left: 8,
            bottom: 4,
          ),
          child: Row(
            children: getDaysNameUI(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            right: 8,
            left: 8,
            bottom: 4,
          ),
          child: Column(
            children: getDaysNoUI(),
          ),
        ),
      ]),
    );
  }

  void setListOfDate(DateTime monthDate) {
    dateList.clear();
    var newDate = DateTime(monthDate.year, monthDate.month, 0);
    int previousMonthDay = 0;
    if (newDate.weekday < 7) {
      previousMonthDay = newDate.weekday;
      for (int i = 1; i <= previousMonthDay; ++i) {
        dateList.add(newDate.subtract(Duration(days: previousMonthDay - i)));
      }
    }
    for (int i = 0; i < (42 - previousMonthDay); ++i) {
      dateList.add(newDate.add(Duration(days: i + 1)));
    }
  }

  _getCircleUI(VoidCallback onTap, IconData icon) {
    return Padding(
      padding: const EdgeInsets.all(9),
      child: Container(
          height: 38,
          width: 38,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(24)),
            border: Border.all(color: Colors.transparent),
          ),
          child: Material(
              color: Colors.transparent,
              child: InkWell(
                  borderRadius: const BorderRadius.all(Radius.circular(24)),
                  onTap: onTap,
                  child: Icon(icon, color: Colors.grey)))),
    );
  }

  List<Widget> getDaysNameUI() {
    List<Widget> listUI = [];
    for (int i = 0; i < 7; ++i) {
      listUI.add(context.read<ThemeProvider>().languageType == LanguageType.ar
          ? Padding(
              padding: const EdgeInsets.only(left: 0.0, right: 6.0),
              child: Center(
                child: Text(
                  DateFormat("EEE", _languageType.toString().split(".")[1])
                      .format(dateList[i]),
                  textAlign: TextAlign.justify,
                  style: TextStyles(context)
                      .getRegularStyle()
                      .copyWith(color: Theme.of(context).primaryColor),
                ),
              ))
          : Expanded(
              child: Center(
                  child: Text(
              DateFormat("EEE", _languageType.toString().split(".")[1])
                  .format(dateList[i]),
              textAlign: TextAlign.justify,
              style: TextStyles(context)
                  .getRegularStyle()
                  .copyWith(color: Theme.of(context).primaryColor),
            ))));
    }
    return listUI;
  }

  List<Widget> getDaysNoUI() {
    List<Widget> noList = [];
    int count = 0;
    for (int i = 0; i < dateList.length / 7; ++i) {
      List<Widget> listUI = [];
      for (int j = 0; j < 7; ++j) {
        final date = dateList[count];
        listUI.add(Expanded(
          child: AspectRatio(
            aspectRatio: 1.0,
            child: Container(
              child: Stack(children: [
                Padding(
                  padding: const EdgeInsets.only(top: 3, bottom: 3),
                  child: Material(
                    color: Colors.transparent,
                    child: Padding(
                        padding: EdgeInsets.only(
                          top: 2,
                          bottom: 2,
                          left: isStartDateRadius(date)
                              ? context.read<ThemeProvider>().languageType ==
                                      LanguageType.ar
                                  ? 0
                                  : 4
                              : 0,
                          right: isEndDateRadius(date)
                              ? context.read<ThemeProvider>().languageType ==
                                      LanguageType.ar
                                  ? 0
                                  : 4
                              : 0,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                              color: startDate != null && endDate != null
                                  ? getIsItStartAndEndDate(date) ||
                                          getIsInRange(date)
                                      ? Theme.of(context)
                                          .primaryColor
                                          .withOpacity(0.4)
                                      : Colors.transparent
                                  : Colors.transparent,
                              borderRadius: BorderRadius.only(
                                bottomLeft: context
                                            .read<ThemeProvider>()
                                            .languageType ==
                                        LanguageType.ar
                                    ? isEndDateRadius(date)
                                        ? const Radius.circular(24)
                                        : const Radius.circular(0)
                                    : isStartDateRadius(date)
                                        ? const Radius.circular(24)
                                        : const Radius.circular(0),
                                topLeft: context
                                            .read<ThemeProvider>()
                                            .languageType ==
                                        LanguageType.ar
                                    ? isEndDateRadius(date)
                                        ? const Radius.circular(24)
                                        : const Radius.circular(0)
                                    : isStartDateRadius(date)
                                        ? const Radius.circular(24)
                                        : const Radius.circular(0),
                                bottomRight: context
                                            .read<ThemeProvider>()
                                            .languageType ==
                                        LanguageType.ar
                                    ? isStartDateRadius(date)
                                        ? const Radius.circular(24)
                                        : const Radius.circular(0)
                                    : isEndDateRadius(date)
                                        ? const Radius.circular(24)
                                        : const Radius.circular(0),
                                topRight: context
                                            .read<ThemeProvider>()
                                            .languageType ==
                                        LanguageType.ar
                                    ? isStartDateRadius(date)
                                        ? const Radius.circular(24)
                                        : const Radius.circular(0)
                                    : isEndDateRadius(date)
                                        ? const Radius.circular(24)
                                        : const Radius.circular(0),
                              )),
                        )),
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.all(Radius.circular(32)),
                    onTap: () {
                      if (currentMonthDate.month == date.month) {
                        var newMinimumDate = DateTime(
                            widget.minimumDate.year,
                            widget.minimumDate.month,
                            widget.minimumDate.day - 1);
                        var newMaximumDate = DateTime(
                            widget.maximumDate.year,
                            widget.maximumDate.month,
                            widget.maximumDate.day + 1);

                        if (date.isAfter(newMinimumDate) &&
                            date.isBefore(newMaximumDate)) {
                          onDateClick(date);
                        }
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.all(2),
                      child: Container(
                        decoration: BoxDecoration(
                            color: getIsItStartAndEndDate(date)
                                ? Theme.of(context).primaryColor
                                : Colors.transparent,
                            borderRadius: BorderRadius.all(Radius.circular(32)),
                            border: Border.all(
                              color: getIsItStartAndEndDate(date)
                                  ? Colors.white
                                  : Colors.transparent,
                              width: 2,
                            ),
                            boxShadow: getIsItStartAndEndDate(date)
                                ? <BoxShadow>[
                                    BoxShadow(
                                        color: Theme.of(context).disabledColor,
                                        blurRadius: 4,
                                        offset: const Offset(0, 0))
                                  ]
                                : null),
                        child: Center(
                          child: Text(
                            "${date.day}",
                            style: TextStyles(context)
                                .getDescriptionStyle()
                                .copyWith(
                                  color: getIsItStartAndEndDate(date)
                                      ? AppTheme.primaryTextColor
                                      : currentMonthDate.month == date.month
                                          ? AppTheme.primaryTextColor
                                          : AppTheme.secondaryTextColor,
                                  fontSize:
                                      MediaQuery.of(context).size.width > 360
                                          ? 18
                                          : 16,
                                  fontWeight: getIsItStartAndEndDate(date)
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 9,
                  right: 0,
                  left: 0,
                  child: Container(
                    height: 6,
                    width: 6,
                    decoration: BoxDecoration(
                      color: DateTime.now().day == date.day &&
                              DateTime.now().month == date.month &&
                              DateTime.now().year == date.year
                          ? getIsInRange(date)
                              ? Colors.white
                              : Theme.of(context).primaryColor
                          : Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ));
        ++count;
      }
      noList.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: listUI,
      ));
    }
    return noList;
  }

  bool getIsInRange(DateTime date) {
    if (startDate != null && endDate != null) {
      if (date.isAfter(startDate!) && date.isBefore(endDate!)) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  bool getIsItStartAndEndDate(DateTime date) {
    if (startDate != null &&
        startDate!.day == date.day &&
        startDate!.month == date.month &&
        startDate!.year == date.year) {
      return true;
    } else if (endDate != null &&
        endDate!.day == date.day &&
        endDate!.month == date.month &&
        endDate!.year == date.year) {
      return true;
    } else {
      return false;
    }
  }

  bool isStartDateRadius(DateTime date) {
    if (startDate != null &&
        startDate!.day == date.day &&
        startDate!.month == date.month) {
      return true;
    } else if (date.weekday == 1) {
      return true;
    } else {
      return false;
    }
  }

  bool isEndDateRadius(DateTime date) {
    if (endDate != null &&
        endDate!.day == date.day &&
        endDate!.month == date.month) {
      return true;
    } else if (date.weekday == 7) {
      return true;
    } else {
      return false;
    }
  }

  void onDateClick(DateTime date) {
    if (startDate == null) {
      startDate = date;
    } else if (startDate != date && endDate == null) {
      endDate = date;
    } else if (startDate!.day == date.day && startDate!.month == date.month) {
      startDate = null;
    } else if (endDate!.day == date.day && endDate!.month == date.month) {
      endDate = null;
    }

    if (startDate == null && endDate != null) {
      startDate = endDate;
      endDate = null;
    }

    if (startDate != null && endDate != null) {
      if (!endDate!.isAfter(startDate!)) {
        var tmp = startDate;
        startDate = endDate;
        endDate = tmp;
      }
      if (date.isBefore(startDate!)) {
        startDate = date;
      }
      if (date.isAfter(endDate!)) {
        endDate = date;
      }
    }
    setState(() {
      try {
        widget.startEndDateChange(startDate!, endDate!);
      } catch (e) {}
    });
  }
}
