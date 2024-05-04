import '../../global/global_var.dart';
import '../../models/room_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:booking_new_hotel/models/hotel_list_data.dart';

class CoreDatabaseService {
  void getHotelListData() async {
    var value = await FirebaseFirestore.instance.collection("hotels").get();
    GlobalVar.hotelListData = value.docs
        .map((doc) => HotelListData(
              titleTxt: doc['title'],
              subTxt: doc['subtitle'],
              dist: doc['dist'].toDouble(),
              reviews: doc['reviews'],
              rating: doc['rating'].toDouble(),
              perNight: doc['price'],
              imagePath: doc['image'],
              roomData: RoomData(doc['room'], doc['people']),
              date: DateText(DateTime.now().day, DateTime.now().day + 6),
            ))
        .toList();
  }
}
