import 'package:booking_new_hotel/languages/appLocalizations.dart';
import 'package:booking_new_hotel/providers/theme_provider.dart';
import 'package:booking_new_hotel/routes/route_names.dart';
import 'package:booking_new_hotel/utils/enum.dart';
import 'package:booking_new_hotel/widgets/common_card.dart';
import 'package:booking_new_hotel/widgets/remove_focus.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../global/global_var.dart';
import '../../models/categories_filter_list.dart';
import '../../models/hotel.dart';
import '../../models/room.dart';
import '../../models/room_data.dart';
import '../../utils/text_styles.dart';
import '../../utils/themes.dart';
import '../myTrips/hotel_list_view.dart';
import 'components/filter_bar_UI.dart';
import 'components/time_date_view.dart';

class HotelHomeScreen extends StatefulWidget {
  const HotelHomeScreen({super.key});

  @override
  State<HotelHomeScreen> createState() => _HotelHomeScreenState();
}

class _HotelHomeScreenState extends State<HotelHomeScreen>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late AnimationController _animationController;
  List<Hotel> filterHotelList = GlobalVar.listAllHotels!;
  ScrollController scrollController = ScrollController();
  IconData favoriteIcon = Icons.favorite_border;
  late Map categoriesFilter;
  int room = 1;
  int add = 2;

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 5));

  bool _isShowMap = false;

  final searchBarHeight = 158.0;
  final filterBarHeight = 52.0;

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));

    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 0));

    scrollController.addListener(() {
      if (mounted) {
        // check if the state is 'mounted'
        if (scrollController.offset <= 0) {
          // set a static value below half scrolling values
          _animationController.animateTo(0.0);
        } else if (scrollController.offset > 0.0 &&
            scrollController.offset < searchBarHeight) {
          //we need around half scrolling values
          _animationController
              .animateTo((scrollController.offset / searchBarHeight));
        } else {
          _animationController.animateTo(1.0);
        }
      }
    });
    super.initState();
  }

  Future<bool> getData() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return true;
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          RemoveFocus(
            onClick: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Column(
              children: [
                _getAppBarUI(),
                _isShowMap
                    ? _getSearchBarUI()
                    : Expanded(
                        child: Stack(children: [
                        filterHotelList.isNotEmpty
                            ? Container(
                                color: AppTheme.scaffoldBackgroundColor,
                                child: ListView.builder(
                                  itemExtent: 304,
                                  controller: scrollController,
                                  itemCount: filterHotelList.length,
                                  padding: const EdgeInsets.only(
                                    top: 158 + 52.0,
                                  ),
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) {
                                    var count = filterHotelList.length > 10
                                        ? 10
                                        : filterHotelList.length;
                                    var animation =
                                        Tween(begin: 0.0, end: 1.0).animate(
                                      CurvedAnimation(
                                        parent: animationController,
                                        curve: Interval(
                                            (1 / count) * index, 1.0,
                                            curve: Curves.fastOutSlowIn),
                                      ),
                                    );
                                    animationController.forward();
                                    return HotelListView(
                                      callback: () {
                                        NavigationServices(context)
                                            .gotoRoomBookingScreen(
                                                filterHotelList[index]);
                                      },
                                      hotelData: filterHotelList[index],
                                      animation: animation,
                                      animationController: animationController,
                                    );
                                  },
                                ),
                              )
                            : emptyPage(),
                        AnimatedBuilder(
                          animation: _animationController,
                          builder: (BuildContext context, Widget? child) {
                            return Positioned(
                                top: -searchBarHeight *
                                    (_animationController.value),
                                left: 0,
                                right: 0,
                                child: Column(
                                  children: [
                                    Container(
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      child: Column(
                                        children: [
                                          Container(
                                            color: Theme.of(context)
                                                .scaffoldBackgroundColor,
                                            child: Column(
                                              children: [
                                                // hotel search view
                                                _getSearchBarUI(),

                                                // time date and no of rooms view
                                                TimeDateView((
                                                  DateTime start,
                                                  DateTime end,
                                                  RoomData roomData,
                                                ) {
                                                  setState(() {
                                                    // searchByDateAndRoomData(
                                                    //     start, end, roomData, type: 'search by date and room data');
                                                    searchWithAllCriteria(
                                                        typeSearching:
                                                            'Search by date and room data',
                                                        start: start,
                                                        end: end,
                                                        roomData: roomData);
                                                  });
                                                }),
                                              ],
                                            ),
                                          ),
                                          FilterBarUI(filterHotelList.length,
                                              (value) {
                                            if (value != null) {
                                              // searchByPriceAmenityDistance(
                                              //     value);
                                              categoriesFilter = value;
                                              searchWithAllCriteria(
                                                typeSearching:
                                                    'Search by price, amenity, distance and type',
                                              );
                                            }
                                          }),
                                        ],
                                      ),
                                    ),
                                  ],
                                ));
                          },
                        )
                      ]))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _getAppBarUI() {
    return Padding(
      padding: EdgeInsets.only(
          top: AppBar().preferredSize.height + 10, left: 8, right: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            alignment:
                context.read<ThemeProvider>().languageType == LanguageType.ar
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
            width: AppBar().preferredSize.height + 40,
            height: AppBar().preferredSize.height,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                  borderRadius: const BorderRadius.all(Radius.circular(32.0)),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8),
                    child: Icon(Icons.arrow_back),
                  )),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                AppLocalizations(context).of("explore"),
                style: TextStyles(context).getTitleStyle(),
              ),
            ),
          ),
          SizedBox(
            width: AppBar().preferredSize.height + 40,
            height: AppBar().preferredSize.height,
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(32.0)),
                      onTap: () {},
                      child: const Padding(
                        padding: EdgeInsets.all(8),
                        child: Icon(
                          Icons.favorite_border,
                        ),
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(32.0)),
                      onTap: () {
                        _isShowMap = !_isShowMap;
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Icon(
                          _isShowMap
                              ? Icons.sort
                              // ignore: deprecated_member_use
                              : FontAwesomeIcons.mapMarkedAlt,
                        ),
                      ),
                    ),
                  ),
                ]),
          )
        ],
      ),
    );
  }

  Widget _getSearchBarUI() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 16, top: 8, bottom: 8),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CommonCard(
                color: AppTheme.backgroundColor,
                radius: 36,
                child: Row(children: [
                  Expanded(
                    child: TextField(
                      maxLines: 1,
                      enabled: true,
                      onChanged: (String text) => searchWithAllCriteria(
                          typeSearching: 'Search by location', text: text),
                      cursorColor: Theme.of(context).primaryColor,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10),
                        errorText: null,
                        border: InputBorder.none,
                        hintStyle:
                            TextStyles(context).getDescriptionStyle().copyWith(
                                  color: AppTheme.secondaryTextColor,
                                  fontSize: 18,
                                ),
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          ),
          CommonCard(
            color: AppTheme.primaryColor,
            radius: 36,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  // ignore: deprecated_member_use
                  child: Icon(FontAwesomeIcons.search,
                      size: 20, color: AppTheme.backgroundColor),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  List<Hotel> searchByLocation(String text, List<Hotel> traverseList) {
    List<Hotel> tmp = [];
    if (text.isEmpty) {
      tmp = GlobalVar.listAllHotels!;
    } else {
      RegExp exp = RegExp(' .+');
      for (int i = 0; i < GlobalVar.listAllHotels!.length; i++) {
        RegExpMatch? match =
            exp.firstMatch(GlobalVar.listAllHotels![i].locationOfHotel);
        if (match![0].toString().trim() == text) {
          tmp.add(GlobalVar.listAllHotels![i]);
        }
      }
    }
    return tmp;
  }

  bool checkByDestination(
      Hotel currentHotel, List<CategoriesFilterList> destination) {
    if (destination[0].isSelected) {
      return true;
    }
    for (int i = 1; i < destination.length; ++i) {
      if (currentHotel.locationOfHotel.split(', ')[0] == destination[i].destination) {
        return true;
      }
    }
    return false;
  }

  Future<List<Room>> getListOfRooms(Hotel currentHotel) async {
    return await currentHotel.listOfRooms!;
  }

  Future<bool> checkByRoomData(Hotel currentHotel, RoomData roomData) async {
    List<Room> listOfRooms = await getListOfRooms(currentHotel);
    for (int i = 0; i < listOfRooms.length; ++i) {
      if (listOfRooms[i].roomData.numberOfBed == roomData.numberOfBed &&
          listOfRooms[i].roomData.numberOfPeople == roomData.numberOfPeople) {
        return true;
      }
    }
    return false;
  }

  bool checkByDate(DateTime start, DateTime end, DateText? date) {
    if (start.day == 0 && end.day == 0) return true;
    return (date!.startDate == start.day || date.startDate - 1 >= start.day) &&
        (date.endDate == end.day || date.endDate + 1 <= end.day);
  }

  Future<List<Hotel>> searchByDateAndRoomData(DateTime start, DateTime end,
      RoomData roomData, List<Hotel> traverseList) async {
    List<Hotel> tmp = [];
    for (int i = 0; i < traverseList.length; i++) {
      if (checkByDate(start, end, traverseList[i].date!) &&
          await checkByRoomData(traverseList[i], roomData)) {
        tmp.add(traverseList[i]);
      }
    }
    return tmp;
  }

  bool checkPrice(Hotel currentHotel, int minPrice, int maxPrice) {
    int bias = (currentHotel.averagePrice * currentHotel.discountRate ~/ 100);
    return currentHotel.averagePrice - bias >= minPrice &&
        currentHotel.averagePrice - bias <= maxPrice;
  }

  bool checkAmenity(Hotel currentHotel, List<CategoriesFilterList> amenity) {
    return currentHotel.amenity!.isFreeBreakfast == amenity[0].isSelected &&
        currentHotel.amenity!.isFreeParking == amenity[1].isSelected &&
        currentHotel.amenity!.isPool == amenity[2].isSelected &&
        currentHotel.amenity!.isPetFriendly == amenity[3].isSelected &&
        currentHotel.amenity!.isFreeWifi == amenity[4].isSelected;
  }

  bool checkDistance(Hotel currentHotel, int distance) {
    return currentHotel.dist >= distance - 2 &&
        currentHotel.dist <= distance + 2;
  }

  List<Hotel> searchByPriceAmenityDistance(List<Hotel> traverseList) {
    List<Hotel> tmp = [];
    for (int i = 0; i < traverseList.length; ++i) {
      if (checkPrice(traverseList[i], categoriesFilter['minimumPrice'].toInt(),
              categoriesFilter['maximumPrice'].toInt()) &&
          checkAmenity(traverseList[i], categoriesFilter['amenity']) &&
          checkDistance(
              traverseList[i], categoriesFilter['distance'].toInt()) &&
          checkByDestination(
              traverseList[i], categoriesFilter['destination'])) {
        tmp.add(traverseList[i]);
      }
    }
    return tmp;
  }

  Widget emptyPage() {
    return Center(
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Icon(FontAwesomeIcons.magnifyingGlass),
      const SizedBox(width: 10),
      Text(
        AppLocalizations(context).of("no_hotel_found"),
        style: TextStyles(context).getDescriptionStyle().copyWith(
              color: AppTheme.primaryColor,
              fontSize: 20,
            ),
      ),
    ]));
  }

  // we have to use this function to search with all criteria because:
  // 1. If we only independent searching function, we cannot cover all the cases
  // for example: If we use searchByPriceAmenityDistanceAndType() to search by price, amenity, distance and type
  // What if the result is empty while we use other citeria, it gives us a specified result? It is incorrect.
  // 2. If we just use filterHotelList to search, it is also incorrect because when it is empty in just a case,
  // and after that, we control to match a hotel, the result is still empty.
  void searchWithAllCriteria(
      {DateTime? start,
      DateTime? end,
      RoomData? roomData,
      String text = '',
      required String typeSearching}) async {
    List<Hotel> tmp = [];
    if (filterHotelList.isEmpty) {
      tmp = searchByLocation(text, GlobalVar.listAllHotels!);
      tmp = await searchByDateAndRoomData(start!, end!, roomData!, tmp);
      tmp = searchByPriceAmenityDistance(tmp);
    } else {
      switch (typeSearching) {
        case 'Search by location':
          {
            tmp = searchByLocation(text, filterHotelList);
            break;
          }
        case 'Search by date and room data':
          {
            tmp = await searchByDateAndRoomData(
                start!, end!, roomData!, filterHotelList);
            break;
          }
        case 'Search by price, amenity, distance and type':
          {
            tmp = searchByPriceAmenityDistance(filterHotelList);
            break;
          }
      }
    }
    setState(() {
      filterHotelList = tmp;
    });
  }
}
