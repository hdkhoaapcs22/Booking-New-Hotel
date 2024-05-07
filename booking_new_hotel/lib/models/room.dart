import 'room_data.dart';

class Room {
  String imageRooms;
  String typeOfRoom;
  int price;
  bool isBooked;
  RoomData roomData;
  Room({
    required this.imageRooms,
    required this.typeOfRoom,
    required this.price,
    required this.isBooked,
    required this.roomData,
  });
}
