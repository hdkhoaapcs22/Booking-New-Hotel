import 'package:cloud_firestore/cloud_firestore.dart';

import '../../global/global_var.dart';
import '../../models/hotel.dart';

class FavoriteHotelsDatabase {
  late String uid;
  List<String> _favoriteListData = [];

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
    _favoriteListData.add(favoriteHotel.name);
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
      'discountRate': favoriteHotel.discountRate,
    });
  }

  void getFavoriteListData() async {
    var value = await GlobalVar.userInfoCollection
        .doc(uid)
        .collection("favorites")
        .get();
    _favoriteListData = value.docs.map((e) => e.id).toList();
  }

  bool isFavoriteHotel({required String name}) {
    if (_favoriteListData.isEmpty) {
      return false;
    }

    for (int i = 0; i < _favoriteListData.length; ++i) {
      if (_favoriteListData[i] == name) {
        return true;
      }
    }
    return false;
  }

  void removeFavoriteHotel({required String name}) async {
    if (_favoriteListData.isEmpty) {
      return;
    }
    await GlobalVar.userInfoCollection
        .doc(uid)
        .collection("favorites")
        .doc(name)
        .delete();
    _favoriteListData.removeWhere((element) => element == name);
  }
}
