import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/hotel.dart';
import '../../models/room.dart';

class UpcomingRoomDatabase {
  late String uid;
  List<String> _upcomingRoomList = [];

  // singleton object
  static final UpcomingRoomDatabase _singleton =
      UpcomingRoomDatabase._internal();
  factory UpcomingRoomDatabase({required String uid}) {
    _singleton.uid = uid;
    return _singleton;
  }
  UpcomingRoomDatabase._internal();

  Future<Stream<QuerySnapshot>> getUpcomingRoomStream() async {
    return FirebaseFirestore.instance
        .collection("upcoming")
        .doc(uid)
        .collection("userUpcoming")
        .snapshots();
  }

  Future<void> addUpcomingRoom(
      {required Hotel hotel,
      required Room room,
      required int totalPrice,
      required String startDate,
      required String endDate}) async {
    String result = hotel.name + ', ' + room.typeOfRoom;
    _upcomingRoomList.add(result);
    await FirebaseFirestore.instance
        .collection("upcoming")
        .doc(uid)
        .collection("userUpcoming")
        .doc(result)
        .set({
      'nameHotelAndRoomType': result,
      'totalPrice': totalPrice,
      'image': room.imageRooms.split(' ')[0],
      'bed': room.roomData.numberOfBed,
      'people': room.roomData.numberOfPeople,
      'startDate': startDate,
      'endDate': endDate,
    });
  }

  Future<void> removeUpcomingRoom(
      {required String hotelName, required String typeOfRoom}) async {
    String result = hotelName + ', ' + typeOfRoom;
    await FirebaseFirestore.instance
        .collection("upcoming")
        .doc(uid)
        .collection("userUpcoming")
        .doc(result)
        .delete();
    _upcomingRoomList.removeWhere((element) => element == result);
  }

  void getUpcomingListData() async {
    List<String> listUID = [];
    var tmp = FirebaseFirestore.instance.collection("upcoming");
    var querySnapshots = await tmp.get();
    for (var snapshot in querySnapshots.docs) {
      listUID.add(snapshot.id);
    }
    for (int i = 0; i < listUID.length; ++i) {
      var value = await FirebaseFirestore.instance
          .collection("upcoming")
          .doc(listUID[i])
          .collection("userUpcoming")
          .get();
      _upcomingRoomList = value.docs
          .map((doc) => doc['nameHotelAndRoomType'] as String)
          .toList();
    }
    print(_upcomingRoomList.length);
  }

  bool isUpcomingRoomExist(
      {required String hotelName, required String typeOfRoom}) {
    if (_upcomingRoomList.isEmpty) return false;
    for (int i = 0; i < _upcomingRoomList.length; ++i) {
      List<String> hotelNameAndRoomType = _upcomingRoomList[i].split(', ');
      if (hotelNameAndRoomType[0] == hotelName &&
          hotelNameAndRoomType[1] == typeOfRoom) return true;
    }
    return false;
  }
}
