import 'package:booking_new_hotel/models/hotel_list_data.dart';
import 'package:booking_new_hotel/modules/explore/hotel_list_view_page.dart';
import 'package:booking_new_hotel/routes/route_names.dart';
import 'package:flutter/material.dart';


class FavoritesListView extends StatefulWidget {
  final AnimationController animationController;
  const FavoritesListView({super.key, required this.animationController});

  @override
  State<FavoritesListView> createState() => _FavoritesListViewState();
}

class _FavoritesListViewState extends State<FavoritesListView> {
  var hotelList = HotelListData.hotelList;
  @override
  void initState() {
    widget.animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: hotelList.length,
        padding: const EdgeInsets.only(top: 8, bottom: 8),
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          int count = hotelList.length > 10 ? 10 : hotelList.length;
          var animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
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
      ),
    );
  }
}
