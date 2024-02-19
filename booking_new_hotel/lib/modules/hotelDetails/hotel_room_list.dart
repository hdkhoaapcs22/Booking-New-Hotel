import 'package:flutter/material.dart';

import '../../utils/localfiles.dart';
import '../../utils/themes.dart';
import '../../widgets/common_card.dart';

class HotelRoomList extends StatefulWidget {
  const HotelRoomList({super.key});

  @override
  State<HotelRoomList> createState() => _HotelRoomListState();
}

class _HotelRoomListState extends State<HotelRoomList> {
  List<String> photoList = [
    Localfiles.hotel_room_1,
    Localfiles.hotel_room_2,
    Localfiles.hotel_room_3,
    Localfiles.hotel_room_4,
    Localfiles.hotel_room_5,
    Localfiles.hotel_room_6,
    Localfiles.hotel_room_7,
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 120,
        child: ListView.builder(
          itemCount: photoList.length,
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
                        photoList[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ));
          },
        ));
  }
}
