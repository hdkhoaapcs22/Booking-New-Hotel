import 'package:booking_new_hotel/languages/appLocalizations.dart';
import 'package:booking_new_hotel/utils/enum.dart';
import 'package:booking_new_hotel/widgets/common_button.dart';
import 'package:booking_new_hotel/widgets/common_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/room_data.dart';
import '../../../providers/theme_provider.dart';
import '../../../utils/text_styles.dart';
import '../../../utils/themes.dart';

class RoomPopupView extends StatefulWidget {
  final Function(RoomData) onChange;
  final bool barrierDismissible;
  final RoomData roomData;
  const RoomPopupView(
      {super.key,
      required this.onChange,
      required this.barrierDismissible,
      required this.roomData});

  @override
  State<RoomPopupView> createState() => _RoomPopupViewState();
}

class _RoomPopupViewState extends State<RoomPopupView>
    with TickerProviderStateMixin {
  PopupTextType popupTextType = PopupTextType.no;
  late AnimationController animationController;

  DateTime? startDate;
  DateTime? endDate;

  RoomData? _roomData;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 400), vsync: this);
    animationController.forward();
    _roomData = RoomData(numberOfBed: widget.roomData.numberOfBed, numberOfPeople: widget.roomData.numberOfPeople);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeProvider>(
        context); //  the syntax Provider.of<ThemeProvider> helps to get the current theme data
    return Center(
        child: Scaffold(
            backgroundColor: appTheme.isLightMode
                ? Colors.transparent
                : Theme.of(context).colorScheme.background.withOpacity(0.6),
            body: AnimatedBuilder(
                animation: animationController,
                builder: (BuildContext context, Widget? child) {
                  return AnimatedOpacity(
                    duration: Duration(milliseconds: 100),
                    opacity: animationController.value,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(24),
                        child: CommonCard(
                          color: AppTheme.backgroundColor,
                          radius: 24,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  AppLocalizations(context).of("room_selected"),
                                  style: TextStyles(context)
                                      .getBoldStyle()
                                      .copyWith(fontSize: 16),
                                ),
                              ),
                              const Divider(height: 1),
                              getRowView(
                                  AppLocalizations(context).of("number_room"),
                                  _roomData!.numberOfBed,
                                  PopupTextType.no),
                              getRowView(
                                  AppLocalizations(context).of("people_data"),
                                  _roomData!.numberOfPeople,
                                  PopupTextType.ad),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16, right: 16, top: 24, bottom: 16),
                                  child: CommonButton(
                                      buttonText: AppLocalizations(context)
                                          .of("apply_text"),
                                      onTap: () {
                                        try {
                                          widget.onChange(_roomData!);
                                          Navigator.pop(context);
                                        } catch (e) {}
                                      })),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                })));
  }

  Widget getRowView(String text, int count, PopupTextType popupTextType) {
    return Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: Column(children: [
          Row(children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Divider(
                          height: 1,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              children: [
                                Text(
                                  text,
                                  textAlign: TextAlign.left,
                                  style: TextStyles(context)
                                      .getBoldStyle()
                                      .copyWith(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(32.0),
                            onTap: () {
                              setState(() {
                                if (popupTextType == PopupTextType.no) {
                                  ++_roomData!.numberOfBed;
                                } else if (popupTextType == PopupTextType.ad) {
                                  ++_roomData!.numberOfPeople;
                                }
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Icon(
                                Icons.add_circle_outline,
                                size: 28,
                                color: Theme.of(context).disabledColor,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          "$count",
                          style: TextStyles(context)
                              .getRegularStyle()
                              .copyWith(fontSize: 16),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(32.0),
                            onTap: () {
                              setState(() {
                                if (popupTextType == PopupTextType.no) {
                                  --_roomData!.numberOfBed;
                                  if (_roomData!.numberOfBed < 0) {
                                    _roomData!.numberOfBed = 0;
                                  }
                                } else if (popupTextType == PopupTextType.ad) {
                                  --_roomData!.numberOfPeople;
                                  if (_roomData!.numberOfPeople < 0) {
                                    _roomData!.numberOfPeople = 0;
                                  }
                                }
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Icon(
                                Icons.remove_circle_outline,
                                size: 28,
                                color: Theme.of(context).disabledColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ])
        ]));
  }
}
