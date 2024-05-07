import 'package:booking_new_hotel/models/hotel.dart';
import 'package:booking_new_hotel/models/room.dart';
import 'package:flutter/material.dart';

import '../../utils/themes.dart';
import '../../widgets/common_card.dart';

// ignore: must_be_immutable
class HotelRoomList extends StatefulWidget {
  Hotel hotel;
  HotelRoomList({super.key, required this.hotel});

  @override
  State<HotelRoomList> createState() => _HotelRoomListState();
}

class _HotelRoomListState extends State<HotelRoomList> {
  List<String> listOfPhots = [];

  void fetchRoomList() async {
    List<Room> tmp = await widget.hotel.listOfRooms!;
    for (int i = 0; i < 2; ++i) {
      List<String> res = tmp[i].imageRooms.split(" ");
      listOfPhots.addAll(res);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchRoomList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 120,
        child: ListView.builder(
          itemCount: listOfPhots.length,
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Padding(
                padding: EdgeInsets.all(8.0),
                child: CommonCard(
                  color: AppTheme.backgroundColor,
                  radius: 8,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Image.asset(
                        listOfPhots[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ));
          },
        ));
  }
}
