import 'package:booking_new_hotel/models/hotel_list_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../global/global_var.dart';
import '../../models/room_data.dart';

class DatabaseService {
  late String uid;
  // DatabaseService({this.uid});

  // singleton object
  static final DatabaseService _singleton = DatabaseService._internal();
  factory DatabaseService({required String uid}) {
    _singleton.uid = uid;
    return _singleton;
  }
  DatabaseService._internal();

  // user collection reference
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future updateUserInfoData({
    required String name,
    required String address,
    required String phone,
  }) async {
    return await userCollection.doc(uid).collection("usersInfo").doc(uid).set({
      'name': name,
      'address': address,
      'phone': phone,
    });
  }

  Future<Stream<QuerySnapshot>> getUserInfoData() async {
    return userCollection.doc(uid).collection("usersInfo").snapshots();
  }

  Future<Stream<QuerySnapshot>> getFavoritesListData() async {
    return userCollection.doc(uid).collection("favorites").snapshots();
  }

  Future addFavoritListData(
      {required String title,
      required double rating,
      required String imagePath,
      required String subtitle,
      required String dist,
      required String price}) async {
    return await userCollection.doc(uid).collection("favorites").doc().set({
      'imagePath': imagePath,
      'title': title,
      'subtitle': subtitle,
      'dist': dist,
      'rating': rating,
      'price': price,
    });
  }

  Future<Stream<QuerySnapshot>> getUpcomingsListData() async {
    return userCollection.doc(uid).collection("upcomings").snapshots();
  }

  void getHotelListData() async {
    var value = await userCollection.doc(uid).collection("hotels").get();
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
