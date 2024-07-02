import 'package:booking_new_hotel/models/hotel.dart';
import 'package:booking_new_hotel/service/auth/auth_service.dart';
import 'package:booking_new_hotel/service/database/database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

import '../modules/splash/components/iconic_of_app.dart';

class GlobalVar {
  static Iconic iconic = Iconic();
  static AuthService authService = AuthService();
  static List<Hotel>? listAllHotels;
  static final CollectionReference userInfoCollection =
      FirebaseFirestore.instance.collection('users');
  static DatabaseService? databaseService;
  static Position? locationOfUser;
  static String? userPassword;
  static String? userEmail;
}
