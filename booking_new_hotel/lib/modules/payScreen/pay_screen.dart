import 'package:booking_new_hotel/languages/appLocalizations.dart';
import 'package:booking_new_hotel/modules/payScreen/show_amenities_of_hotel.dart';
import 'package:booking_new_hotel/widgets/list_cell_animation_view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../global/global_var.dart';
import '../../models/hotel.dart';
import '../../models/room.dart';
import '../../motel_app.dart';
import '../../providers/theme_provider.dart';
import '../../utils/enum.dart';
import '../../utils/helper.dart';
import '../../utils/text_styles.dart';

// ignore: must_be_immutable
class PayScreen extends StatefulWidget {
  Hotel hotel;
  Room room;
  DateTime startDateBooking, endDateBooking;
  PayScreen(
      {super.key,
      required this.hotel,
      required this.room,
      required this.startDateBooking,
      required this.endDateBooking});

  @override
  State<PayScreen> createState() => _PayScreenState();
}

class _PayScreenState extends State<PayScreen> with TickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _animation;
  LanguageType _languageType = applicationcontext == null
      ? LanguageType.en
      : applicationcontext!.read<ThemeProvider>().languageType;
  int numberOfColumn = 3, numberOfNight = 0, totalPrice = 0;
  String stringOfStartDateBooking = '', stringOfEndDateBooking = '';
  Stream? userStream;

  void fetchUserInfoData() async {
    userStream =
        await GlobalVar.databaseService!.userInfoDatabase.getUserInfoStream();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchUserInfoData();
    numberOfNight =
        widget.endDateBooking.difference(widget.startDateBooking).inDays;
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
        parent: _animationController!, curve: Curves.easeInOut));
    _animationController!.forward();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: userStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            var userInfoData = snapshot.data!.docs[0];
            return Scaffold(
              appBar: AppBar(
                toolbarHeight: 60,
                backgroundColor: Colors.transparent,
                centerTitle: true,
                title: Text(AppLocalizations(context).of('payment_details'),
                    style: TextStyles(context).getTitleStyle()),
                leading: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: InkWell(
                    child: const Icon(
                      FontAwesomeIcons.arrowLeft,
                    ),
                    onTap: () {
                      Navigator.pop(context, true);
                    },
                  ),
                ),
              ),
              body: ListCellAnimationView(
                animation: _animation!,
                child: Stack(
                  children: [
                    Scrollbar(
                      thumbVisibility: true,
                      child: ListView.builder(
                        itemCount: 4,
                        padding: const EdgeInsets.fromLTRB(10, 16, 13, 16),
                        physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        itemBuilder: (context, index) => Container(
                          height: index == 0
                              ? MediaQuery.of(context).size.width * 0.74
                              : MediaQuery.of(context).size.width * 0.52,
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.only(top: 20),
                          padding: const EdgeInsets.fromLTRB(5, 8, 4, 5),
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
                          child: showInformationInEachCard(index, userInfoData),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              bottomNavigationBar: Container(
                height: 55,
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                      splashColor: Colors.white.withOpacity(0.7),
                      child: Center(
                        child: Text(
                          AppLocalizations(context).of('pay_now'),
                          style: TextStyles(context).getTitleStyle().copyWith(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                        ),
                      ),
                      onTap: () {
                        checkValidInformation(userInfoData);
                      }),
                ),
              ),
            );
          }
          return const SizedBox();
        });
  }

  void checkValidInformation(userInfoData) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
    await Future.delayed(const Duration(seconds: 2), () {
      if (userInfoData['name'] == '' || userInfoData['phone'] == '') {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (context) => SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: AlertDialog(
                    title: Text(
                      AppLocalizations(context).of('error'),
                      style: TextStyles(context)
                          .getTitleStyle()
                          .copyWith(fontSize: 20, color: Colors.redAccent),
                    ),
                    content: Text(
                        AppLocalizations(context).of('fill_information'),
                        style: TextStyles(context).getRegularStyle().copyWith(
                              fontSize: 18,
                            )),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(AppLocalizations(context).of('got_it')))
                    ],
                  ),
                ));
      } else {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (context) => SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: AlertDialog(
                    title: Text(AppLocalizations(context).of('success')),
                    content:
                        Text(AppLocalizations(context).of('call_next_hours')),
                    actions: [
                      TextButton(
                          onPressed: () async {
                            await GlobalVar
                                .databaseService!.upcomingHotelsDatabase
                                .addUpcomingRoom(
                                    hotel: widget.hotel,
                                    room: widget.room,
                                    totalPrice: totalPrice,
                                    startDate: stringOfStartDateBooking,
                                    endDate: stringOfEndDateBooking);
                            Navigator.pop(context);
                            Navigator.pop(context, true);
                          },
                          child: Text(AppLocalizations(context).of('got_it')))
                    ],
                  ),
                ));
      }
    });
  }

  Widget showInformationInEachCard(int index, userInfoData) {
    Widget result = const SizedBox();
    switch (index) {
      case 0:
        {
          result = hotelInfoCard();
          break;
        }
      case 1:
        {
          result = roomInfoCard();
        }
      case 2:
        {
          result = calculateBillCard();
        }
      case 3:
        {
          result = informationOfUserCard(userInfoData);
        }
    }
    return result;
  }

  Widget informationOfUserCard(userInfoData) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(10, 12, 5, 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            AppLocalizations(context).of('your_information'),
            style: TextStyles(context).getTitleStyle(),
          ),
          const SizedBox(height: 15),
          showInformation('name', userInfoData['name']),
          const SizedBox(height: 10),
          showInformation('mail', userInfoData['mail']),
          const SizedBox(height: 10),
          showInformation('phone', userInfoData['phone']),
        ]));
  }

  Widget showInformation(String title, String information) {
    return Row(
      children: [
        Text(
          AppLocalizations(context).of(title) + ':',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 10),
        information != ''
            ? FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  information,
                  style: TextStyles(context).getRegularStyle().copyWith(
                        fontSize: 16,
                      ),
                ),
              )
            : const SizedBox(),
      ],
    );
  }

  Widget calculateBillCard() {
    int currentPrice = widget.room.price -
        (widget.room.price * widget.hotel.discountRate ~/ 100);
    totalPrice = currentPrice * numberOfNight * 105 ~/ 100;
    return Stack(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(5, 10, 10, 5),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          showItem(text: 'initial_price', num: widget.room.price),
          const SizedBox(height: 10),
          showItem(text: 'current_price', num: currentPrice),
          const SizedBox(height: 10),
          showItem(text: 'night'),
          const SizedBox(height: 5),
          Divider(
            color: Colors.grey.withOpacity(0.7),
            thickness: 1.5,
          ),
          showItem(text: 'total_price', num: totalPrice),
          const SizedBox(height: 5),
          Row(
            children: [
              const Icon(FontAwesomeIcons.moneyCheckDollar, size: 15),
              const SizedBox(width: 4),
              Text(
                AppLocalizations(context).of('pay_at_hotel'),
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.redAccent,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ]),
      ),
      Positioned(
          right: 1,
          child: Container(
              height: 30,
              width: 80,
              decoration: const BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                  )),
              child: Center(
                child: Text(
                  widget.hotel.discountRate.toString() +
                      '%' +
                      AppLocalizations(context).of('off'),
                  style: TextStyles(context).getRegularStyle().copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                  textAlign: TextAlign.center,
                ),
              )))
    ]);
  }

  Widget showItem({required String text, int? num}) {
    String tmp = num != null ? num.toString() + '\$' : numberOfNight.toString();
    return Row(
      children: [
        Container(
          width: 200,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              AppLocalizations(context).of(text),
              style: TextStyles(context).getBoldStyle().copyWith(
                    fontSize: 17,
                  ),
            ),
          ),
        ),
        const SizedBox(
          width: 40,
        ),
        Text(
          tmp,
          style: TextStyles(context).getBoldStyle().copyWith(
                fontSize: 17,
              ),
        ),
      ],
    );
  }

  Widget roomInfoCard() {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                  height: MediaQuery.of(context).size.width * 0.25,
                  width: MediaQuery.of(context).size.width * 0.35,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      widget.room.imageRooms.split(' ')[0],
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
                          widget.room.typeOfRoom,
                          style: TextStyles(context).getBoldStyle().copyWith(
                                fontSize: 20,
                                overflow: TextOverflow.ellipsis,
                              ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        showCapacityOfRoom(FontAwesomeIcons.bed,
                            widget.room.roomData.numberOfBed.toString()),
                        Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Text(
                              '-',
                              style: TextStyle(
                                fontSize: 15,
                                color: Theme.of(context).primaryColor,
                              ),
                            )),
                        showCapacityOfRoom(FontAwesomeIcons.person,
                            widget.room.roomData.numberOfPeople.toString()),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 3),
          Divider(
            color: Colors.grey.withOpacity(0.7),
            thickness: 1.5,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                children: [
                  const Icon(FontAwesomeIcons.bell,
                      color: Colors.redAccent, size: 15),
                  const SizedBox(width: 4),
                  Text(
                    AppLocalizations(context).of('booked_soon'),
                    style: const TextStyle(
                      color: Colors.redAccent,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(width: 19),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        widget.hotel.discountRate == 0
                            ? Text("${widget.room.price}\$",
                                textAlign: TextAlign.left,
                                style: TextStyles(context)
                                    .getBoldStyle()
                                    .copyWith(fontSize: 18))
                            : Row(children: [
                                Text("${widget.room.price}",
                                    style: TextStyle(
                                      color: Colors.grey.withOpacity(0.4),
                                      fontSize: 16,
                                      decoration: TextDecoration.lineThrough,
                                    )),
                                const SizedBox(
                                  width: 4,
                                ),
                                Text(
                                    "${widget.room.price - (widget.room.price * widget.hotel.discountRate ~/ 100)}\$",
                                    textAlign: TextAlign.left,
                                    style: TextStyles(context)
                                        .getBoldStyle()
                                        .copyWith(fontSize: 20)),
                              ]),
                        Padding(
                          padding: EdgeInsets.only(
                              top: context.read<ThemeProvider>().languageType ==
                                      LanguageType.ar
                                  ? 2.0
                                  : 0.0),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              AppLocalizations(context).of("per_night"),
                              style: TextStyles(context)
                                  .getRegularStyle()
                                  .copyWith(fontSize: 15),
                            ),
                          ),
                        )
                      ]),
                ],
              ),
            ),
          )
        ],
      ),
    );
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

  Widget hotelInfoCard() {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                  height: MediaQuery.of(context).size.width * 0.31,
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      widget.hotel.imageHotel,
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
                          widget.hotel.name,
                          style: TextStyles(context).getBoldStyle().copyWith(
                                fontSize: 20,
                                overflow: TextOverflow.ellipsis,
                              ),
                        ),
                      ),
                    ),

                    // for rating
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Helper.ratingStar(widget.hotel.rating),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.58,
                      height: 20,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          widget.hotel.locationOfHotel,
                          style: TextStyles(context).getRegularStyle().copyWith(
                                overflow: TextOverflow.ellipsis,
                              ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 3),
          Divider(
            color: Colors.grey.withOpacity(0.7),
            thickness: 1.5,
          ),
          // for booking date
          Row(
            children: [
              Column(
                children: [
                  Text(
                      stringOfStartDateBooking = DateFormat("EEE, dd MMM yyyy",
                              _languageType.toString().split(".")[1])
                          .format(widget.startDateBooking),
                      style: TextStyles(context).getRegularStyle().copyWith(
                            fontSize: 15,
                          )),
                  Text(
                    AppLocalizations(context).of('check_in'),
                    style: TextStyles(context).getDescriptionStyle().copyWith(
                          fontSize: 13,
                        ),
                  )
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(left: 9, right: 9),
                child: Icon(FontAwesomeIcons.arrowRight,
                    color: Colors.grey, size: 15),
              ),
              Column(
                children: [
                  Text(
                      stringOfEndDateBooking = DateFormat("EEE, dd MMM yyyy",
                              _languageType.toString().split(".")[1])
                          .format(widget.endDateBooking),
                      style: TextStyles(context).getRegularStyle().copyWith(
                            fontSize: 15,
                          )),
                  Text(
                    AppLocalizations(context).of('check_out'),
                    style: TextStyles(context).getDescriptionStyle().copyWith(
                          fontSize: 13,
                        ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.5),
                child: Column(
                  children: [
                    Text(
                      numberOfNight.toString(),
                      style: TextStyles(context).getBoldStyle().copyWith(
                            fontSize: 15,
                          ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      AppLocalizations(context).of('night'),
                      style: TextStyles(context).getDescriptionStyle().copyWith(
                            fontSize: 14,
                          ),
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 3),
          Divider(
            color: Colors.grey.withOpacity(0.7),
            thickness: 1.5,
          ),
          // for amenities, if true -> it is bright
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: ShowAmenitiesOfHotel(
                      hotel: widget.hotel,
                      numberOfColumn: 3,
                      numberOfAmenities: 6,
                      context: context)
                  .showAmenitiesOfHotel(),
            ),
          ),
        ],
      ),
    );
  }
}
