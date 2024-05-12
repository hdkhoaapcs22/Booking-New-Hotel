import 'package:booking_new_hotel/languages/appLocalizations.dart';
import 'package:booking_new_hotel/models/hotel.dart';
import 'package:booking_new_hotel/models/room_data.dart';
import 'package:booking_new_hotel/modules/myTrips/upcoming.dart';
import 'package:booking_new_hotel/modules/payScreen/show_amenities_of_hotel.dart';
import 'package:booking_new_hotel/widgets/common_button.dart';
import 'package:booking_new_hotel/widgets/list_cell_animation_view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../global/global_var.dart';
import '../../utils/helper.dart';
import '../../utils/text_styles.dart';

class UpcomingListView extends StatefulWidget {
  final AnimationController animationController;
  const UpcomingListView({super.key, required this.animationController});

  @override
  State<UpcomingListView> createState() => _UpcomingListViewState();
}

class _UpcomingListViewState extends State<UpcomingListView> {
  Stream? upcomingsStream;
  Animation<double>? _animation;

  void fetchUpcomingHotel() async {
    upcomingsStream = await GlobalVar.databaseService!.upcomingHotelsDatabase
        .getUpcomingRoomStream();
    setState(() {});
  }

  @override
  void initState() {
    fetchUpcomingHotel();
    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
        parent: widget.animationController, curve: Curves.easeInOut));
    widget.animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: upcomingsStream,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            var item = snapshot.data.docs
                .map((doc) => Upcoming(
                      nameHotelAndRoomType: doc.id,
                      image: doc['image'],
                      startDate: doc['startDate'],
                      endDate: doc['endDate'],
                      roomData: RoomData(
                        numberOfBed: doc['bed'],
                        numberOfPeople: doc['people'],
                      ),
                      totalPrice: doc['totalPrice'],
                    ))
                .toList();
            return ListCellAnimationView(
              animation: _animation!,
              child: Stack(
                children: [
                  Scrollbar(
                    thumbVisibility: true,
                    child: ListView.builder(
                      itemCount: item.length,
                      padding: const EdgeInsets.fromLTRB(14, 16, 13, 16),
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      itemBuilder: (context, index) => Container(
                          height: MediaQuery.of(context).size.width * 0.8,
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.only(top: 20),
                          padding: const EdgeInsets.fromLTRB(7, 8, 4, 5),
                          decoration: BoxDecoration(
                            color: const Color(0xfff7f7f7),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            border: Border.all(width: 1, color: Colors.black12),
                          ),
                          child: informationCard(item[index])),
                    ),
                  ),
                ],
              ),
            );
          }
          return const SizedBox();
        });
  }

  Widget informationCard(Upcoming item) {
    Hotel? hotel;
    for (int i = 0; i < GlobalVar.listAllHotels!.length; ++i) {
      if (GlobalVar.listAllHotels![i].name ==
          item.nameHotelAndRoomType.split(', ')[0]) {
        hotel = GlobalVar.listAllHotels![i];
        break;
      }
    }
    return hotel != null
        ? Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                        height: MediaQuery.of(context).size.width * 0.31,
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            item.image,
                            fit: BoxFit.cover,
                          ),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.42,
                            child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text(
                                hotel.name,
                                style:
                                    TextStyles(context).getBoldStyle().copyWith(
                                          fontSize: 20,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                              ),
                            ),
                          ),

                          // for rating
                          Padding(
                            padding: const EdgeInsets.only(top: 1),
                            child: Helper.ratingStar(hotel.rating),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.58,
                            height: 20,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                hotel.locationOfHotel,
                                style: TextStyles(context)
                                    .getRegularStyle()
                                    .copyWith(
                                      overflow: TextOverflow.ellipsis,
                                    ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 3, right: 10),
                            child: Row(
                              children: [
                                Text(item.nameHotelAndRoomType.split(', ')[1],
                                    style: TextStyles(context)
                                        .getBoldStyle()
                                        .copyWith(fontSize: 15)),
                                const SizedBox(width: 10),
                                showCapacityOfRoom(FontAwesomeIcons.bed,
                                    item.roomData.numberOfBed.toString()),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Text(
                                      '-',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    )),
                                showCapacityOfRoom(FontAwesomeIcons.person,
                                    item.roomData.numberOfPeople.toString()),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Divider(
                  color: Colors.grey.withOpacity(0.7),
                  thickness: 1.5,
                ),
                SizedBox(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: ShowAmenitiesOfHotel(
                            hotel: hotel,
                            numberOfColumn: 3,
                            numberOfAmenities: 5,
                            context: context)
                        .showAmenitiesOfHotel(),
                  ),
                ),
                const SizedBox(height: 5),
                Divider(
                  color: Colors.grey.withOpacity(0.7),
                  thickness: 1.5,
                ),
                Row(
                  children: [
                    Text(
                      AppLocalizations(context).of('total_price') + ': ',
                      style: TextStyles(context).getBoldStyle().copyWith(
                            fontSize: 17,
                          ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(
                      '${item.totalPrice}\$',
                      style: TextStyles(context).getBoldStyle().copyWith(
                            fontSize: 17,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Align(
                  alignment: Alignment.centerRight,
                  child: CommonButton(
                      height: 40,
                      width: 90,
                      fontSize: 10,
                      buttonTextWidget: Text(
                        AppLocalizations(context).of('cancel'),
                        style: TextStyles(context).getRegularStyle().copyWith(
                              color: Colors.white,
                            ),
                      ),
                      backgroundColor: Colors.red,
                      onTap: () {
                        dialogCancel(
                            hotelName: hotel!.name,
                            typeOfRoom:
                                item.nameHotelAndRoomType.split(', ')[1]);
                      }),
                )
              ],
            ),
          )
        : const SizedBox();
  }

  Widget showCapacityOfRoom(IconData icon, String text) {
    return Row(children: [
      Text(
        text,
        style: TextStyle(
          fontSize: 18,
          color: Theme.of(context).primaryColor,
        ),
      ),
      const SizedBox(width: 4),
      Icon(icon, color: Theme.of(context).primaryColor, size: 16),
    ]);
  }

  void dialogCancel(
      {required String hotelName, required String typeOfRoom}) async {
    bool isCancel = await Helper().showCommonPopup(
        "Cancel", "Do you want to cancel this room?", context,
        isYesOrNoPopup: true);
    if (isCancel) {
      await GlobalVar.databaseService!.upcomingHotelsDatabase
          .removeUpcomingRoom(hotelName: hotelName, typeOfRoom: typeOfRoom);
      setState(() {
        fetchUpcomingHotel();
      });
    }
  }
}
