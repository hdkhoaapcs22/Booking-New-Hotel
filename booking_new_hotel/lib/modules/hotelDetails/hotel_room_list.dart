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

  Future<List<Room>> fetchRoomList() async {
    return await widget.hotel.listOfRooms!;
  }

  void loadPhotos() async {
    List<Room> tmp = await fetchRoomList();
    for (int i = 0; i < 2; ++i) {
      List<String> res = tmp[i].imageRooms.split(" ");
      listOfPhots.addAll(res);
    }
    setState(() {
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    loadPhotos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 120,
        child: ListView.builder(
          itemCount: listOfPhots.length,
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Padding(
                padding: const EdgeInsets.all(8.0),
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
