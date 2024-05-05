import 'package:booking_new_hotel/routes/route_names.dart';
import 'package:flutter/material.dart';

import '../../global/global_var.dart';
import 'hotel_list_view.dart';

class UpcomingListView extends StatefulWidget {
  final AnimationController animationController;
  const UpcomingListView({super.key, required this.animationController});

  @override
  State<UpcomingListView> createState() => _UpcomingListViewState();
}

class _UpcomingListViewState extends State<UpcomingListView> {
  // var hotelList = HotelListData.hotelList;
  var hotelList = GlobalVar.hotelListData!;

  Stream? upcomingsStream;
  void fetchFavoritesListView() async {
    upcomingsStream = await GlobalVar.databaseService!.upcomingHotelsDatabase
        .getUpcomingHotelsStream();
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
        stream: upcomingsStream,
        builder: (context, AsyncSnapshot snapshot) {
          return ListView.builder(
            itemCount: hotelList.length,
            padding: const EdgeInsets.only(top: 8, bottom: 16),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              int count = hotelList.length > 10 ? 10 : hotelList.length;
              var animation = Tween(begin: 0.0, end: 1.0).animate(
                  CurvedAnimation(
                      parent: widget.animationController,
                      curve: Interval((1 / count) * index, 1.0,
                          curve: Curves.fastOutSlowIn)));
              widget.animationController.forward();
              return HotelListView(
                hotelData: hotelList[index],
                animationController: widget.animationController,
                animation: animation,
                callback: () {
                  NavigationServices(context)
                      .gotoRoomBookingScreen(hotelList[index]);
                },
                isShowDate: true,
                isShowFavIcon: false,
              );
            },
          );
        });
  }
}
