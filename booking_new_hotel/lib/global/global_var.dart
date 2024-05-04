import 'package:booking_new_hotel/models/hotel_list_data.dart';
import 'package:booking_new_hotel/service/auth/auth_service.dart';
import 'package:booking_new_hotel/service/database/database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../modules/profile/user.dart';
import '../modules/splash/components/iconic_of_app.dart';

class GlobalVar {
  static Iconic iconic = Iconic();
  static AuthService authService = AuthService();
  static List<HotelListData>? hotelListData;
  static MyUser? user;
  static final CollectionReference userInfoCollection =
      FirebaseFirestore.instance.collection('users');
  static DatabaseService? databaseService;
}
