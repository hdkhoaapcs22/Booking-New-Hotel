
import 'package:booking_new_hotel/models/hotel.dart';
import 'package:booking_new_hotel/service/auth/auth_service.dart';
import 'package:booking_new_hotel/service/database/database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

import '../modules/profile/user.dart';
import '../modules/splash/components/iconic_of_app.dart';

class GlobalVar {
  static Iconic iconic = Iconic();
  static AuthService authService = AuthService();
  static List<Hotel>? listAllHotels;
  static MyUser? user;
  static final CollectionReference userInfoCollection =
      FirebaseFirestore.instance.collection('users');
  static DatabaseService? databaseService;
  static Position? locationOfUser;
  // static StreamSubscription<ServiceStatus> statusStream =
  //     Geolocator.getServiceStatusStream().listen((status) {
  //   if (status == ServiceStatus.disabled) {
  //     Geolocator.getLastKnownPosition().then((value) {
  //       locationOfUser = value;
  //       print(locationOfUser!.latitude);
  //     });
  //   } else {
  //     Geolocator.getCurrentPosition().then((value) {
  //       locationOfUser = value;
  //       print("After turn on again: ${locationOfUser!.latitude}");
  //     });
  //   }
  // });
}
