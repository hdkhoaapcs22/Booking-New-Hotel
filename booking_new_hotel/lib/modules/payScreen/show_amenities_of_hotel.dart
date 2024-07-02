import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../languages/appLocalizations.dart';
import '../../models/hotel.dart';

class ShowAmenitiesOfHotel {
  int numberOfColumn, numberOfAmenities;
  Hotel hotel;
  BuildContext context;
  ShowAmenitiesOfHotel({
    required this.hotel,
    required this.numberOfColumn,
    required this.numberOfAmenities,
    required this.context,
  });

  Widget showAmenitiesOfHotel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: arrangeAmenities(),
    );
  }

  List<Widget> arrangeAmenities() {
    List<Widget> result = [];
    int index = 0;
    for (int i = 0;
        i < (hotel.amenity!.numberOfAmenities / numberOfColumn).ceil();
        ++i) {
      List<Widget> amenitiesUI = [];
      for (int j = 0; j < numberOfColumn; ++j) {
        if (index >= hotel.amenity!.numberOfAmenities) {
          break;
        }
        amenitiesUI.add(Padding(
          padding: const EdgeInsets.all(6),
          child: chooseIcon(index),
        ));
        ++index;
      }
      if (amenitiesUI.isNotEmpty) {
        result.add(Row(
            mainAxisAlignment: MainAxisAlignment.start, children: amenitiesUI));
      }
    }
    return result;
  }

  Widget chooseIcon(int index) {
    late IconData iconData;
    late bool isAvailable;
    late String title;
    switch (index) {
      case 0:
        {
          iconData = FontAwesomeIcons.utensils;
          isAvailable = hotel.amenity!.isFreeBreakfast;
          title = 'free_breakfast';
          break;
        }
      case 1:
        {
          iconData = FontAwesomeIcons.squareParking;
          isAvailable = hotel.amenity!.isFreeParking;
          title = 'free_parking';
          break;
        }
      case 2:
        {
          iconData = FontAwesomeIcons.dog;
          isAvailable = hotel.amenity!.isPetFriendly;
          title = 'pet_friendly';
          break;
        }
      case 3:
        {
          iconData = FontAwesomeIcons.wifi;
          isAvailable = hotel.amenity!.isFreeWifi;
          title = 'free_wifi';
          break;
        }
      case 4:
        {
          iconData = FontAwesomeIcons.waterLadder;
          isAvailable = hotel.amenity!.isPool;
          title = 'swimming_pool';
          break;
        }
    }
    return Row(
      children: [
        Icon(
          iconData,
          color: isAvailable
              ? Theme.of(context).primaryColor
              : Colors.black.withOpacity(0.6),
          size: 13,
        ),
        const SizedBox(width: 3),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            AppLocalizations(context).of(title),
            style: TextStyle(
              fontSize: 14,
              color:
                  isAvailable ? Theme.of(context).primaryColor : Colors.black,
            ),
          ),
        )
      ],
    );
  }
}
