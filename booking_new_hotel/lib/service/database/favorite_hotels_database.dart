import 'package:cloud_firestore/cloud_firestore.dart';

import '../../global/global_var.dart';
import '../../models/hotel_list_data.dart';
import '../../models/room_data.dart';

class FavoriteHotelsDatabase {
  late String uid;
  List<HotelListData> favoriteListData = [];

  // singleton object
  static final FavoriteHotelsDatabase _singleton =
      FavoriteHotelsDatabase._internal();
  factory FavoriteHotelsDatabase({required String uid}) {
    _singleton.uid = uid;
    return _singleton;
  }
  FavoriteHotelsDatabase._internal();

  Future<Stream<QuerySnapshot>> getFavoriteHotelsStream() async {
    return GlobalVar.userInfoCollection
        .doc(uid)
        .collection("favorites")
        .snapshots();
  }

  Future addFavoriteHotel({required HotelListData favoriteHotel}) async {
    favoriteListData.add(favoriteHotel);
    return await GlobalVar.userInfoCollection
        .doc(uid)
        .collection("favorites")
        .doc(favoriteHotel.titleTxt)
        .set({
      'image': favoriteHotel.imagePath,
      'title': favoriteHotel.titleTxt,
      'subtitle': favoriteHotel.subTxt,
      'dist': favoriteHotel.dist,
      'rating': favoriteHotel.rating,
      'price': favoriteHotel.perNight,
      'reviews': favoriteHotel.reviews,
      'room': favoriteHotel.roomData!.numberRoom,
      'people': favoriteHotel.roomData!.people,
    });
  }

  void getFavoriteListData() async {
    var value = await GlobalVar.userInfoCollection
        .doc(uid)
        .collection("favorites")
        .get();
    favoriteListData = value.docs
        .map((doc) => HotelListData(
              titleTxt: doc['title'],
              subTxt: doc['subtitle'],
              dist: doc['dist'],
              reviews: doc['reviews'],
              rating: doc['rating'],
              perNight: doc['price'],
              imagePath: doc['image'],
              roomData: RoomData(doc['room'], doc['people']),
            ))
        .toList();
    print(favoriteListData.length);
  }

  bool isFavoriteHotel({required String name}) {
    if (favoriteListData.isEmpty) {
      return false;
    }

    for (int i = 0; i < favoriteListData.length; ++i) {
      if (favoriteListData[i].titleTxt == name) {
        return true;
      }
    }
    return false;
  }

  void removeFavoriteHotel({required String name}) async {
    if (favoriteListData.isEmpty) {
      return;
    }
    await GlobalVar.userInfoCollection
        .doc(uid)
        .collection("favorites")
        .doc(name)
        .delete();
    favoriteListData.removeWhere((element) => element.titleTxt == name);
  }
}
