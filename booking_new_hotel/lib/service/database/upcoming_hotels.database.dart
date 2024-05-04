import 'package:cloud_firestore/cloud_firestore.dart';

import '../../global/global_var.dart';

class UpcomingHotelsDatabase{
  late String uid;
  // UserInfoDatabase({this.uid});

  // singleton object
  static final UpcomingHotelsDatabase _singleton = UpcomingHotelsDatabase._internal();
  factory UpcomingHotelsDatabase({required String uid}) {
    _singleton.uid = uid;
    return _singleton;
  }
  UpcomingHotelsDatabase._internal();

  Future<Stream<QuerySnapshot>> getUpcomingHotelsStream() async {
    return GlobalVar.userInfoCollection.doc(uid).collection("upcoming").snapshots();
  }
}