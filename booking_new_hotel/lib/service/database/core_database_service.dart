import 'dart:math';

import '../../global/global_var.dart';
import '../../models/room.dart';
import '../../models/room_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:booking_new_hotel/models/hotel.dart';

class CoreDatabaseService {
  void getHotel() async {
    var value = await FirebaseFirestore.instance.collection("hotels").get();
    GlobalVar.listAllHotels = value.docs
        .map((doc) => Hotel(
              name: doc['title'],
              locationOfHotel: doc['subtitle'],
              dist: doc['dist'].toDouble(),
              reviews: doc['reviews'],
              rating: doc['rating'].toDouble(),
              averagePrice: doc['price'],
              imageHotel: doc['image'],
              date: DateText(DateTime.now().day,
                  DateTime.now().day + Random().nextInt(5) + 1),
              discountRate: Random().nextInt(20),
              amenity: Amenity(
                  isFreeBreakfast: doc['amenity'][0],
                  isFreeParking: doc['amenity'][1],
                  isFreeWifi: doc['amenity'][2],
                  isPetFriendly: doc['amenity'][3],
                  isPool: doc['amenity'][4]),
              listOfRooms: loadFromSubCollection(doc.reference.id),
            ))
        .toList();
  }

  Future<List<Room>> loadFromSubCollection(String id) async {
    var value = await FirebaseFirestore.instance
        .collection("hotels")
        .doc(id)
        .collection("rooms")
        .get();
    // we will load data from this subcollection and return it as a list.
    return value.docs
        .map((doc) => Room(
              typeOfRoom: doc['title'],
              price: doc['price'],
              imageRooms: doc['image'],
              roomData: RoomData(
                  numberOfBed: doc['roomData'][0],
                  numberOfPeople: doc['roomData'][1]),
              isBooked: doc['isBooked'],
            ))
        .toList();
  }
}
