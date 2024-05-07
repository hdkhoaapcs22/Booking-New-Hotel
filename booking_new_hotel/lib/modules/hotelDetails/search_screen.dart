import 'package:booking_new_hotel/languages/appLocalizations.dart';
import 'package:booking_new_hotel/widgets/common_card.dart';
import 'package:booking_new_hotel/widgets/common_search_bar.dart';
import 'package:booking_new_hotel/widgets/remove_focus.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../models/hotel.dart';
import '../../utils/themes.dart';
import '../../widgets/common_app_bar_view.dart';
import 'search_type_list_view.dart';
import 'search_view.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with TickerProviderStateMixin {
  List<Hotel> lastSearchList = Hotel.lastsSearchesList;

  late AnimationController animationController;

  final myController = TextEditingController();

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000));
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.scaffoldBackgroundColor,
      body: RemoveFocus(
        onClick: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonAppBarView(
              topPadding: AppBar().preferredSize.height - 10,
              iconData: Icons.close_rounded,
              onBackClick: () {
                Navigator.pop(context);
              },
              titleText: AppLocalizations(context).of("search_hotel"),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                    children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 24, right: 24, top: 16, bottom: 16),
                            child: CommonCard(
                              color: AppTheme.backgroundColor,
                              radius: 36,
                              child: CommonSearchBar(
                                textEditingController: myController,
                                // ignore: deprecated_member_use
                                iconData: FontAwesomeIcons.search,
                                enabled: true,
                                text: AppLocalizations(context)
                                    .of("where_are_you_going"),
                              ),
                            ),
                          ),
                          const SearchTypeListView(),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 24, right: 24, top: 8),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Text(
                                        AppLocalizations(context)
                                            .of("Last_search"),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          letterSpacing: 0.5,
                                        ))),
                                Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(4.0)),
                                    onTap: () {
                                      setState(() {
                                        myController.text = '';
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Row(
                                        children: [
                                          Text(
                                            AppLocalizations(context)
                                                .of("clear_all"),
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ] +
                        getList(myController.text.toString()) +
                        [
                          SizedBox(
                              height:
                                  MediaQuery.of(context).padding.bottom + 16),
                        ]),
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> getList(String searchValue) {
    List<Widget> noList = [];
    var count = 0;
    final columnCount = 2;
    List<Hotel> curList = Hotel.lastsSearchesList
        .where((element) =>
            element.name.toLowerCase().contains(searchValue.toLowerCase()))
        .toList();
    for (int i = 0; i < curList.length / columnCount; ++i) {
      List<Widget> listUI = [];
      for (int j = 0; j < columnCount; ++j) {
        try {
          final data = curList[count];
          var animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
              parent: animationController,
              curve: Interval((1 / curList.length) * count, 1.0,
                  curve: Curves.fastOutSlowIn)));
          animationController.forward();
          listUI.add(Expanded(
              child: SearchView(
            hotel: data,
            animation: animation,
            animationController: animationController,
          )));
          ++count;
        } catch (e) {}
      }
      noList.add(Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Row(mainAxisSize: MainAxisSize.max, children: listUI)));
    }
    return noList;
  }
}
