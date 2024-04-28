import 'package:booking_new_hotel/models/hotel_list_data.dart';
import 'package:booking_new_hotel/service/Database/database_service.dart';
import 'package:booking_new_hotel/service/auth/auth_service.dart';

import '../modules/profile/user.dart';
import '../modules/splash/components/iconic_of_app.dart';

class GlobalVar {
  static Iconic iconic = Iconic();
  static AuthService authService = AuthService();
  static DatabaseService? databaseService;
  static List<HotelListData>? hotelListData;
  static MyUser? user;
}
