import 'package:booking_new_hotel/models/hotel.dart';
import 'package:booking_new_hotel/models/room.dart';
import 'package:booking_new_hotel/modules/hotelDetails/room_booking_view.dart';
import 'package:flutter/material.dart';

import '../../utils/text_styles.dart';

// ignore: must_be_immutable
class RoomBookingScreen extends StatefulWidget {
  final Hotel hotel;
  DateTime startDateBooking, endDateBooking;
  RoomBookingScreen(
      {super.key,
      required this.hotel,
      required this.startDateBooking,
      required this.endDateBooking});

  @override
  State<RoomBookingScreen> createState() => _RoomBookingScreenState();
}

class _RoomBookingScreenState extends State<RoomBookingScreen>
    with TickerProviderStateMixin {
  // List<Hotel> roomList = Hotel.romeList;
  List<Room> roomList = [];
  late AnimationController animationController;

  void fetchRoomList() async {
    roomList = await widget.hotel.listOfRooms!;
    setState(() {});
  }

  @override
  void initState() {
    print("it is in initState of room_booking");
    fetchRoomList();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1500), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("It is in RoomBookingScreen");
    return roomList.isNotEmpty
        ? Scaffold(
            body: Column(
            children: [
              getAppBarUI(),
              Expanded(
                  child: ListView.builder(
                padding: const EdgeInsets.all(0.0),
                itemCount: roomList.length,
                itemBuilder: (context, index) {
                  int count = roomList.length > 10 ? 10 : roomList.length;
                  var animation = Tween(begin: 0.0, end: 1.0).animate(
                      CurvedAnimation(
                          parent: animationController,
                          curve: Interval((1 / count) * index, 1.0,
                              curve: Curves.fastOutSlowIn)));
                  animationController.forward();
                  return RoomBookingView(
                      hotel: widget.hotel,
                      room: roomList[index],
                      animationController: animationController,
                      animation: animation,
                      startDateBooking: widget.startDateBooking,
                      endDateBooking: widget.endDateBooking);
                },
              ))
            ],
          ))
        : const SizedBox();
  }

  Widget getAppBarUI() {
    return Padding(
      padding: EdgeInsets.only(
          top: AppBar().preferredSize.height, left: 16, right: 16, bottom: 16),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Material(
              color: Colors.transparent,
              child: InkWell(
                  borderRadius: const BorderRadius.all(Radius.circular(32.0)),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8),
                    child: Icon(Icons.arrow_back),
                  )),
            ),
            Expanded(
              child: Center(
                child: Text(widget.hotel.name,
                    style: TextStyles(context).getTitleStyle(),
                    overflow: TextOverflow.ellipsis),
              ),
            ),
          ]),
    );
  }
}
