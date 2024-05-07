import 'package:cloud_firestore/cloud_firestore.dart';

import '../../global/global_var.dart';
import '../../models/hotel.dart';

class FavoriteHotelsDatabase {
  late String uid;
  List<Hotel> favoriteListData = [];

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

  Future addFavoriteHotel({required Hotel favoriteHotel}) async {
    favoriteListData.add(favoriteHotel);
    return await GlobalVar.userInfoCollection
        .doc(uid)
        .collection("favorites")
        .doc(favoriteHotel.name)
        .set({
      'image': favoriteHotel.imageHotel,
      'title': favoriteHotel.name,
      'subtitle': favoriteHotel.locationOfHotel,
      'dist': favoriteHotel.dist,
      'rating': favoriteHotel.rating,
      'price': favoriteHotel.averagePrice,
      'reviews': favoriteHotel.reviews,
    });
  }

  void getFavoriteListData() async {
    var value = await GlobalVar.userInfoCollection
        .doc(uid)
        .collection("favorites")
        .get();
    favoriteListData = value.docs
        .map((doc) => Hotel(
              name: doc['title'],
              locationOfHotel: doc['subtitle'],
              dist: doc['dist'],
              reviews: doc['reviews'],
              rating: doc['rating'],
              averagePrice: doc['price'],
              imageHotel: doc['image'],
            ))
        .toList();
    print(favoriteListData.length);
  }

  bool isFavoriteHotel({required String name}) {
    if (favoriteListData.isEmpty) {
      return false;
    }

    for (int i = 0; i < favoriteListData.length; ++i) {
      if (favoriteListData[i].name == name) {
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
    favoriteListData.removeWhere((element) => element.name == name);
  }
}
