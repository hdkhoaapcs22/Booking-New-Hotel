import 'package:booking_new_hotel/modules/bottomTap/bottom_tap_screen.dart';
import 'package:booking_new_hotel/modules/hotelDetails/room_booking.dart';
import 'package:booking_new_hotel/modules/profile/change_password.dart';
import 'package:booking_new_hotel/modules/profile/edit_profile.dart';
import 'package:flutter/material.dart';
import '../models/hotel.dart';
import '../models/room.dart';
import '../modules/hotelBooking/filtterScreen/filtter_screen.dart';
import '../modules/hotelBooking/hotel_home_screen.dart';
import '../modules/hotelDetails/hotel_details.dart';
import '../modules/hotelDetails/reviews_list_screen.dart';
import '../modules/login/authenticaltion_wrapper.dart';
import '../modules/login/login_or_signup_screen.dart';
import '../modules/login/send_email_to_verify_screen.dart';
import '../modules/payScreen/pay_screen.dart';
import '../modules/profile/settings_screen.dart';
import '../modules/splash/splash_screen.dart';
import 'routes.dart';

class NavigationServices {
  final BuildContext context;
  NavigationServices(this.context);

  Future<dynamic> _pushMaterialPageRoute(Widget widget,
      {bool fullscreenDialog = false}) async {
    return Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => widget, fullscreenDialog: fullscreenDialog));
  }

  void gotoIntroductionScreen() {
    Navigator.pushNamedAndRemoveUntil(
        context, RoutesName.Introduction, (Route<dynamic> route) => false);
  }

  Future<dynamic> gotoLoginOrSignUpScreen(bool showLoginScreen) async {
    return _pushMaterialPageRoute(
      LoginOrSignUpScreen(gobalState: showLoginScreen),
    );
  }

  void gotoBottomTapScreen() async {
    return _pushMaterialPageRoute(const BottomTapScreen());
  }

  void gotoVerifyEmailScreen(String email) async {
    return _pushMaterialPageRoute(SendEmailToVerify(email: email));
  }

  void gotoHotelHomeScreen() async {
    return _pushMaterialPageRoute(const HotelHomeScreen());
  }

  void gotoFilterScreen() async {
    return _pushMaterialPageRoute(const FilterScreen());
  }

  void gotoRoomBookingScreen(
      {required Hotel hotel,
      required DateTime startDateBooking,
      required DateTime endDateBooking}) async {
    return _pushMaterialPageRoute(RoomBookingScreen(
      hotel: hotel,
      startDateBooking: startDateBooking,
      endDateBooking: endDateBooking,
    ));
  }

  Future<dynamic> gotoHotelDetails(Hotel Hotel) async {
    return await _pushMaterialPageRoute(HotelDetails(
      hotelData: Hotel,
    ));
  }

  Future<dynamic> gotoReviewsListScreen() async {
    return await _pushMaterialPageRoute(const ReviewsListScreen());
  }

  Future<dynamic> gotoEditProfileScreen() async {
    return await _pushMaterialPageRoute(const EditProfile());
  }

  Future<dynamic> gotoChangePasswordScreen(
      {required String previousPassword}) async {
    return await _pushMaterialPageRoute(ChangePassword(
      previousPassword: previousPassword,
    ));
  }

  Future<dynamic> gotoSettingsScreen() async {
    return await _pushMaterialPageRoute(const SettingsScreen());
  }

  Future<dynamic> gotoSplashScreen() async {
    return Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const SplashScreen()),
        (Route<dynamic> route) => false);
  }

  Future<dynamic> gotoPayScreen({
    required Hotel hotel,
    required Room room,
    required DateTime startDateBooking,
    required DateTime endDateBooking,
  }) async {
    return await _pushMaterialPageRoute(PayScreen(
      hotel: hotel,
      room: room,
      startDateBooking: startDateBooking,
      endDateBooking: endDateBooking,
    ));
  }
}
