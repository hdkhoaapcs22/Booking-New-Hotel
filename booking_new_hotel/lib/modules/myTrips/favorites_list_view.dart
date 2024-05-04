import 'package:booking_new_hotel/global/global_var.dart';
import 'package:booking_new_hotel/models/hotel_list_data.dart';
import 'package:booking_new_hotel/modules/explore/hotel_list_view_page.dart';
import 'package:booking_new_hotel/routes/route_names.dart';
import 'package:flutter/material.dart';

import '../../models/room_data.dart';

class FavoritesListView extends StatefulWidget {
  final AnimationController animationController;
  const FavoritesListView({super.key, required this.animationController});

  @override
  State<FavoritesListView> createState() => _FavoritesListViewState();
}

class _FavoritesListViewState extends State<FavoritesListView> {
  Stream? favoritesStream;
  void fetchFavoritesListView() async {
    favoritesStream = await GlobalVar.databaseService!.favoriteHotelsDatabase
        .getFavoriteHotelsStream();
    setState(() {});
  }

  @override
  void initState() {
    fetchFavoritesListView();
    widget.animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: favoritesStream,
        builder: (context, AsyncSnapshot snapshot) {
          var hotelList = snapshot.hasData
              ? snapshot.data.docs
                  .map((doc) => HotelListData(
                        titleTxt: doc['title'],
                        subTxt: doc['subtitle'],
                        dist: doc['dist'],
                        reviews: doc['reviews'],
                        rating: doc['rating'],
                        perNight: doc['price'],
                        imagePath: doc['image'],
                        roomData: RoomData(doc['room'], doc['people']),
                      ))
                  .toList()
              : [];
          return ListView.builder(
            itemCount: hotelList.length,
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              int count = hotelList.length > 10 ? 10 : hotelList.length;
              var animation = Tween(begin: 0.0, end: 1.0).animate(
                  CurvedAnimation(
                      parent: widget.animationController,
                      curve: Interval((1 / count) * index, 1.0,
                          curve: Curves.fastOutSlowIn)));
              widget.animationController.forward();
              return HotelListViewPage(
                hotelData: hotelList[index],
                animationController: widget.animationController,
                animation: animation,
                callback: () {
                  NavigationServices(context)
                      .gotoRoomBookingScreen(hotelList[index].titleTxt);
                },
                rating: hotelList[index].rating,
              );
            },
          );
        });
  }
}
