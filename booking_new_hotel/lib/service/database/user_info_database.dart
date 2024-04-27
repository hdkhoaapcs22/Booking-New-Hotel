import 'package:cloud_firestore/cloud_firestore.dart';

class UserInfo {
  String uid;
  UserInfo({required this.uid});

  // user collection reference
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  // update user data
  Future updateUserData(
      {required String name,
      required String email,
      required String address,
      required String phone}) async {
    return await userCollection.doc(uid).set({
      'name': name,
      'email': email,
      'address': address,
      'phone': phone,
    });
  }
}
