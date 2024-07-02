import 'package:booking_new_hotel/global/global_var.dart';
import 'package:booking_new_hotel/languages/appLocalizations.dart';
import 'package:booking_new_hotel/models/room.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../models/hotel.dart';
import '../../utils/text_styles.dart';
import '../../widgets/common_button.dart';
import '../payScreen/pay_screen.dart';
import '../payScreen/show_amenities_of_hotel.dart';

// ignore: must_be_immutable
class RoomBookingView extends StatefulWidget {
  final Hotel hotel;
  final Room room;
  DateTime startDateBooking, endDateBooking;
  final AnimationController animationController;
  final Animation<double> animation;
  RoomBookingView(
      {super.key,
      required this.hotel,
      required this.room,
      required this.animationController,
      required this.animation,
      required this.startDateBooking,
      required this.endDateBooking});

  @override
  State<RoomBookingView> createState() => _RoomBookingViewState();
}

class _RoomBookingViewState extends State<RoomBookingView> {
  var pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    bool isBooked = GlobalVar.databaseService!.upcomingHotelsDatabase
        .isUpcomingRoomExist(
            hotelName: widget.hotel.name, typeOfRoom: widget.room.typeOfRoom);
    List<String> images = widget.room.imageRooms.split(" ");
    return AnimatedBuilder(
      animation: widget.animationController,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: widget.animation,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 40 * (1.0 - widget.animation.value), 0.0),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    AspectRatio(
                      aspectRatio: 1.5,
                      child: PageView(
                        controller: pageController,
                        pageSnapping: true,
                        scrollDirection: Axis.horizontal,
                        children: [
                          for (var image in images)
                            Image.asset(image, fit: BoxFit.cover),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SmoothPageIndicator(
                        controller: pageController,
                        count: 3,
                        effect: WormEffect(
                          activeDotColor: Theme.of(context).primaryColor,
                          dotColor: Theme.of(context).colorScheme.background,
                          dotHeight: 10.0,
                          dotWidth: 10.0,
                          spacing: 5.0,
                        ),
                        onDotClicked: (index) {},
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.room.typeOfRoom,
                            maxLines: 2,
                            textAlign: TextAlign.left,
                            style: TextStyles(context).getBoldStyle().copyWith(
                                  fontSize: 24.0,
                                ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const Expanded(child: SizedBox()),
                          SizedBox(
                            height: 38,
                            child: CommonButton(
                                width: 125,
                                height: 60,
                                isClickable: !isBooked,
                                backgroundColor: !isBooked
                                    ? Theme.of(context).primaryColor
                                    : Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.5),
                                buttonTextWidget: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16.0,
                                      right: 16.0,
                                      top: 4,
                                      bottom: 4),
                                  child: Text(
                                    AppLocalizations(context).of("book_now"),
                                    textAlign: TextAlign.center,
                                    style:
                                        TextStyles(context).getRegularStyle(),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.of(context)
                                      .push(
                                    MaterialPageRoute(
                                        builder: (context) => PayScreen(
                                              hotel: widget.hotel,
                                              room: widget.room,
                                              startDateBooking:
                                                  widget.startDateBooking,
                                              endDateBooking:
                                                  widget.endDateBooking,
                                            )),
                                  )
                                      .then(
                                    (value) {
                                      if (value) {
                                        //refresh here
                                        setState(() {});
                                      }
                                    },
                                  );
                                }),
                          ),
                        ],
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            widget.hotel.discountRate == 0
                                ? Text("${widget.room.price}\$",
                                    textAlign: TextAlign.left,
                                    style: TextStyles(context)
                                        .getBoldStyle()
                                        .copyWith(fontSize: 24))
                                : Row(children: [
                                    Text("${widget.room.price}",
                                        style: TextStyle(
                                          color: Colors.grey.withOpacity(0.4),
                                          fontSize: 19,
                                          decoration:
                                              TextDecoration.lineThrough,
                                        )),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                        "${widget.room.price - (widget.room.price * widget.hotel.discountRate ~/ 100)}\$",
                                        textAlign: TextAlign.left,
                                        style: TextStyles(context)
                                            .getBoldStyle()
                                            .copyWith(fontSize: 24)),
                                  ]),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 0),
                              child: Text(
                                AppLocalizations(context).of("per_night"),
                                style: TextStyles(context)
                                    .getRegularStyle()
                                    .copyWith(fontSize: 14),
                              ),
                            ),
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(4.0)),
                              onTap: () {
                                dialogForDetailInformation(context);
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 8, right: 4),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      AppLocalizations(context)
                                          .of("more_details"),
                                      style: TextStyles(context).getBoldStyle(),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(top: 2),
                                      child: Icon(Icons.keyboard_arrow_down,
                                          size: 24),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ]),
                    ],
                  ),
                ),
                const Divider(height: 1),
              ],
            ),
          ),
        );
      },
    );
  }

  void dialogForDetailInformation(BuildContext context) async {
    showGeneralDialog(
        context: context,
        barrierLabel: "",
        barrierDismissible: true,
        transitionDuration: const Duration(milliseconds: 600),
        pageBuilder: (context, _, __) {
          return Align(
            alignment: const Alignment(0, 1),
            child: Container(
                clipBehavior: Clip.antiAlias,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(18.0),
                      topRight: Radius.circular(18.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Theme.of(context).dividerColor.withOpacity(0.2),
                        offset: const Offset(0, -2),
                        blurRadius: 8.0),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, left: 16, right: 10),
                  child: Column(
                    children: [
                      Text(
                        AppLocalizations(context).of("detail_title"),
                        style: TextStyles(context).getTitleStyle(),
                      ),
                      const SizedBox(height: 15),
                      Divider(
                        height: 1,
                        color: Colors.grey.withOpacity(0.6),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 8),
                        child: Text(AppLocalizations(context).of("room_detail"),
                            style: TextStyles(context).getTitleStyle().copyWith(
                                  fontSize: 20,
                                )),
                      ),
                      Row(children: [
                        const Icon(FontAwesomeIcons.bed),
                        const SizedBox(width: 10),
                        Text(
                          widget.room.roomData.numberOfBed.toString(),
                          style: TextStyles(context).getRegularStyle(),
                        ),
                        const SizedBox(width: 30),
                        const Icon(FontAwesomeIcons.person),
                        const SizedBox(width: 10),
                        Text(
                          widget.room.roomData.numberOfPeople.toString(),
                          style: TextStyles(context).getRegularStyle(),
                        ),
                      ]),
                      const SizedBox(height: 10),
                      Row(children: [
                        Text(
                          AppLocalizations(context).of('check_in_time'),
                          style: TextStyles(context).getBoldStyle(),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          AppLocalizations(context).of("14:00 PM"),
                          style: TextStyles(context).getRegularStyle(),
                        ),
                      ]),
                      const SizedBox(height: 10),
                      Row(children: [
                        Text(
                          AppLocalizations(context).of('check_out_time'),
                          style: TextStyles(context).getBoldStyle(),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          AppLocalizations(context).of("12:00 PM"),
                          style: TextStyles(context).getRegularStyle(),
                        ),
                      ]),
                      Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 8),
                        child: Divider(
                          height: 1,
                          color: Colors.grey.withOpacity(0.6),
                        ),
                      ),
                      Text(
                        AppLocalizations(context).of("amenity"),
                        style: TextStyles(context).getTitleStyle().copyWith(
                              fontSize: 20,
                            ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: ShowAmenitiesOfHotel(
                            context: context,
                            hotel: widget.hotel,
                            numberOfAmenities: 5,
                            numberOfColumn: 3,
                          ).showAmenitiesOfHotel(),
                        ),
                      )
                    ],
                  ),
                )),
          );
        },
        transitionBuilder: (context, animation1, animation2, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 1),
              end: const Offset(0, 0),
            ).animate(animation1),
            child: child,
          );
        });
  }

  // Widget showAmenity(
  //     {required IconData icon,
  //     required bool isAvailable,
  //     required String nameOfItem}) {
  //   Color color = isAvailable ? Theme.of(context).primaryColor : Colors.black12;
  //   return Row(
  //     children: [
  //       Icon(icon, color: color),
  //       const SizedBox(width: 5),
  //       Text(
  //         AppLocalizations(context).of(nameOfItem),
  //         style: TextStyles(context).getRegularStyle().copyWith(
  //               color: color,
  //             ),
  //       ),
  //     ],
  //   );
  // }
}
