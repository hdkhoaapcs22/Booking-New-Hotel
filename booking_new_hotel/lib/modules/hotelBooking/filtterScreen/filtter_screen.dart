import 'package:booking_new_hotel/languages/appLocalizations.dart';
import 'package:booking_new_hotel/widgets/common_app_bar_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../models/categories_filter_list.dart';
import '../../../utils/themes.dart';
import '../../../widgets/common_button.dart';
import 'range_slider_view.dart';
import 'slider_view.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  List<CategoriesFilterList> categoriesAmenityFilterList =
      CategoriesFilterList.amenityCategories;
  List<CategoriesFilterList> accomodationListData =
      CategoriesFilterList.accomodationCategories;

  final columnCount = 2;
  RangeValues _values = const RangeValues(100, 600);
  double distValue = 50;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.scaffoldBackgroundColor,
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: AppBar().preferredSize.height - 10,
            ),
            CommonAppBarView(
              topPadding: 0,
              iconData: Icons.close,
              onBackClick: () {
                Navigator.pop(context);
              },
              titleText: AppLocalizations(context).of("filtter"),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Column(
                    children: [
                      priceBarFilter(),
                      Divider(
                        height: 1,
                        color: Colors.grey.withOpacity(0.2),
                      ),
                      // facilititate filter in hotel
                      popularFilter(),
                      Divider(
                        height: 1,
                        color: Colors.grey.withOpacity(0.2),
                      ),
                      distanceViewUI(),
                      Divider(
                        height: 1,
                        color: Colors.grey.withOpacity(0.2),
                      ),
                      // allAccomodationUI(),
                      // const SizedBox(height: 30),
                      buttonApply(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget priceBarFilter() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          child: Text(
            AppLocalizations(context).of("price_text"),
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.grey,
              fontSize: MediaQuery.of(context).size.width > 360 ? 18 : 16,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        RangeSliderView(
          values: _values,
          onChangeRangeValue: (values) {
            _values = values;
          },
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }

  Widget popularFilter() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(
            AppLocalizations(context).of("popular filter"),
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.grey,
              fontSize: MediaQuery.of(context).size.width > 360 ? 18 : 16,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16, left: 16),
          child: Column(
            children: getList(),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }

  List<Widget> getList() {
    List<Widget> cateforiesFilter = [];
    int count = 0;
    for (int i = 0; i < categoriesAmenityFilterList.length / columnCount; ++i) {
      List<Widget> listUI = [];
      for (int j = 0; j < columnCount; ++j) {
        try {
          final data = categoriesAmenityFilterList[count];
          listUI.add(
            Expanded(
              child: Row(
                children: [
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(4.0)),
                      onTap: () {
                        setState(() {
                          data.isSelected = !data.isSelected;
                          switch (data.titleTxt) {
                            case "free_breakfast":
                              {
                                categoriesAmenityFilterList[0].isSelected =
                                    data.isSelected;
                                break;
                              }
                            case "free_parking":
                              {
                                categoriesAmenityFilterList[1].isSelected =
                                    data.isSelected;
                                break;
                              }
                            case "swimming_pool":
                              {
                                categoriesAmenityFilterList[2].isSelected =
                                    data.isSelected;
                                break;
                              }
                            case "pet_friendly":
                              {
                                categoriesAmenityFilterList[3].isSelected =
                                    data.isSelected;
                                break;
                              }
                            case "free_wifi":
                              {
                                categoriesAmenityFilterList[4].isSelected =
                                    data.isSelected;
                                break;
                              }
                          }
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
                        child: Row(
                          children: [
                            Icon(
                              data.isSelected
                                  ? Icons.check_box
                                  : Icons.check_box_outline_blank,
                              color: data.isSelected
                                  ? AppTheme.primaryColor
                                  : Colors.grey.withOpacity(0.6),
                            ),
                            const SizedBox(width: 4),
                            FittedBox(
                              fit: BoxFit.cover,
                              child: Text(
                                AppLocalizations(context).of(data.titleTxt),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
          ++count;
        } catch (e) {}
      }
      cateforiesFilter.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: listUI,
      ));
    }
    return cateforiesFilter;
  }

  Widget distanceViewUI() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              AppLocalizations(context).of("distance from city"),
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.grey,
                fontSize: MediaQuery.of(context).size.width > 360 ? 18 : 16,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          SliderView(
            distValue: distValue,
            onChangedDistValue: (double value) {
              distValue = value;
            },
          ),
        ]);
  }

  // Widget allAccomodationUI() {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Padding(
  //           padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
  //           child: Text(
  //             AppLocalizations(context).of("type of accommodation"),
  //             textAlign: TextAlign.left,
  //             style: TextStyle(
  //               color: Colors.grey,
  //               fontSize: MediaQuery.of(context).size.width > 360 ? 18 : 16,
  //               fontWeight: FontWeight.normal,
  //             ),
  //           )),
  //       Padding(
  //           padding: const EdgeInsets.only(left: 16, right: 16),
  //           child: Column(children: getAccomodationListUI())),
  //       const SizedBox(
  //         height: 8,
  //       ),
  //     ],
  //   );
  // }

  // List<Widget> getAccomodationListUI() {
  //   List<Widget> noList = [];
  //   for (int i = 0; i < accomodationListData.length; ++i) {
  //     var data = accomodationListData[i];
  //     noList.add(
  //       Material(
  //         color: Colors.transparent,
  //         child: InkWell(
  //           borderRadius: const BorderRadius.all(Radius.circular(4.0)),
  //           child: Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: Row(
  //               children: [
  //                 Expanded(
  //                   child: Text(AppLocalizations(context).of(data.titleTxt)),
  //                 ),
  //                 CupertinoSwitch(
  //                   activeColor: data.isSelected
  //                       ? Theme.of(context).primaryColor
  //                       : Colors.grey.withOpacity(0.6),
  //                   value: data.isSelected,
  //                   onChanged: (value) {
  //                     setState(() {
  //                       controlSwitchAccomodationButton(i);
  //                     });
  //                   },
  //                 )
  //               ],
  //             ),
  //           ),
  //         ),
  //       ),
  //     );
  //     if (i == 0) {
  //       noList.add(
  //         Divider(
  //           height: 1,
  //           color: Colors.grey.withOpacity(0.2),
  //         ),
  //       );
  //     }
  //   }
  //   return noList;
  // }

  // void controlSwitchAccomodationButton(int index) {
  //   if (index == 0) {
  //     // index = 0 is all
  //     if (accomodationListData[0].isSelected) {
  //       for (int i = 0; i < accomodationListData.length; ++i) {
  //         accomodationListData[i].isSelected = false;
  //       }
  //     } else {
  //       for (int i = 0; i < accomodationListData.length; ++i) {
  //         accomodationListData[i].isSelected = true;
  //       }
  //     }
  //   } else {
  //     accomodationListData[index].isSelected =
  //         !accomodationListData[index].isSelected;
  //     int count = 0;
  //     for (int i = 0; i < accomodationListData.length; ++i) {
  //       if (i != 0) {
  //         var data = accomodationListData[i];
  //         if (data.isSelected) {
  //           ++count;
  //         }
  //       }
  //     }
  //     // check all selected
  //     if (count == accomodationListData.length - 1) {
  //       accomodationListData[0].isSelected = true;
  //     } else {
  //       accomodationListData[0].isSelected = false;
  //     }
  //   }
  // }

  Widget buttonApply() {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 5),
      child: CommonButton(
          buttonTextWidget: Text(
            AppLocalizations(context).of("apply_text"),
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          onTap: () {
            Navigator.pop(context, {
              "minimumPrice": _values.start,
              "maximumPrice": _values.end,
              "distance": distValue / 10,
              "amenity": categoriesAmenityFilterList,
            });
          }),
    );
  }
}
