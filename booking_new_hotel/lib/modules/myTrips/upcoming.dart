import '../../models/room_data.dart';

class Upcoming {
  String nameHotelAndRoomType, image, startDate, endDate;
  RoomData roomData;
  int totalPrice;

  Upcoming({
    required this.nameHotelAndRoomType,
    required this.image,
    required this.roomData,
    required this.totalPrice,
    required this.startDate,
    required this.endDate,
  });
}
