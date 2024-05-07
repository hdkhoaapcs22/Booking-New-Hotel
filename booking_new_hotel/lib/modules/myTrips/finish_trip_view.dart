import 'package:booking_new_hotel/global/global_var.dart';
import 'package:booking_new_hotel/routes/route_names.dart';
import 'package:flutter/material.dart';

import 'hotel_list_view_data.dart';

class FinishTripView extends StatefulWidget {
  final AnimationController animationController;
  const FinishTripView({super.key, required this.animationController});

  @override
  State<FinishTripView> createState() => _FinishTripViewState();
}

class _FinishTripViewState extends State<FinishTripView> {
  // var hotelList = Hotel.hotelList;
  var hotelList = GlobalVar.listAllHotels!;
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
        padding: const EdgeInsets.only(top: 8, bottom: 16),
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          int count = hotelList.length > 10 ? 10 : hotelList.length;
          var animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
              parent: widget.animationController,
              curve: Interval((1 / count) * index, 1.0,
                  curve: Curves.fastOutSlowIn)));
          widget.animationController.forward();
          return HotelListViewData(
            hotelData: hotelList[index],
            animationController: widget.animationController,
            animation: animation,
            callback: () {
              NavigationServices(context)
                  .gotoRoomBookingScreen(hotelList[index]);
            },
            ratingOfHotel: hotelList[index].rating,
            isShowDate: (index % 2) != 0,
          );
        },
      ),
    );
  }
}
