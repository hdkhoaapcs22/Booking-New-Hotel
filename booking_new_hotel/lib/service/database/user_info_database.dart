import 'package:cloud_firestore/cloud_firestore.dart';

import '../../global/global_var.dart';

class UserInfoDatabase {
  late String uid;
  // UserInfoDatabase({this.uid});

  // singleton object
  static final UserInfoDatabase _singleton = UserInfoDatabase._internal();
  factory UserInfoDatabase({required String uid}) {
    _singleton.uid = uid;
    return _singleton;
  }
  UserInfoDatabase._internal();

  Future updateUserInfoData({
    required String name,
    required String address,
    required String phone,
  }) async {
    return await GlobalVar.userInfoCollection
        .doc(uid)
        .collection("usersInfo")
        .doc(uid)
        .set({
      'name': name,
      'address': address,
      'phone': phone,
    });
  }

  Future<Stream<QuerySnapshot>> getUserInfoStream() async {
    return GlobalVar.userInfoCollection
        .doc(uid)
        .collection("usersInfo")
        .snapshots();
  }
}
