import 'package:booking_new_hotel/modules/bottomTap/bottomTapScreen.dart';
import 'package:booking_new_hotel/modules/hotelDetails/room_booking.dart';
import 'package:booking_new_hotel/modules/hotelDetails/search_screen.dart';
import 'package:flutter/material.dart';
import '../modules/hotelBooking/filtterScreen/filtter_screen.dart';
import '../modules/hotelBooking/hotel_home_screen.dart';
import '../modules/login/login_or_signup_screen.dart';
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

  void gotoSearchScreen() async {
    return _pushMaterialPageRoute(const SearchScreen());
  }

  void gotoHotelHomeScreen() async {
    return _pushMaterialPageRoute(const HotelHomeScreen());
  }

  void gotoFilterScreen() async {
    return _pushMaterialPageRoute(const FilterScreen());
  }

  void gotoRoomBookingScreen(String name) async {
    return _pushMaterialPageRoute(RoomBookingScreen(
      hotelName: name,
    ));
  }
}
