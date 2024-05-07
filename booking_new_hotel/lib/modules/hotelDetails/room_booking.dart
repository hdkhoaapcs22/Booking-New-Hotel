import 'package:booking_new_hotel/models/hotel.dart';
import 'package:booking_new_hotel/models/room.dart';
import 'package:booking_new_hotel/modules/hotelDetails/room_booking_view.dart';
import 'package:flutter/material.dart';

import '../../global/global_var.dart';
import '../../utils/text_styles.dart';

class RoomBookingScreen extends StatefulWidget {
  final Hotel hotel;
  const RoomBookingScreen({super.key, required this.hotel});

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
    fetchRoomList();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isFav = GlobalVar.databaseService!.favoriteHotelsDatabase
        .isFavoriteHotel(name: widget.hotel.name);
    print("It is in RoomBookingScreen");
    return roomList.isNotEmpty
        ? Scaffold(
            body: Column(
            children: [
              getAppBarUI(isFavoriteHotel: isFav),
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
                      roomData: roomList[index],
                      animationController: animationController,
                      animation: animation);
                },
              ))
            ],
          ))
        : const SizedBox();
  }

  Widget getAppBarUI({required bool isFavoriteHotel}) {
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
            Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: const BorderRadius.all(Radius.circular(32.0)),
                onTap: () {
                  if (isFavoriteHotel) {
                    GlobalVar.databaseService!.favoriteHotelsDatabase
                        .removeFavoriteHotel(name: widget.hotel.locationOfHotel);
                  } else {
                    GlobalVar.databaseService!.favoriteHotelsDatabase
                        .addFavoriteHotel(favoriteHotel: widget.hotel);
                  }
                  setState(() {
                    isFavoriteHotel = !isFavoriteHotel;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Icon(
                    isFavoriteHotel ? Icons.favorite : Icons.favorite_border,
                  ),
                ),
              ),
            ),
          ]),
    );
  }
}
