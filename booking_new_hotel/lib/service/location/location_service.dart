import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../../utils/text_styles.dart';

class LocationService {
  bool serviceEnabled = false;
  Future<bool> getLocation(BuildContext context) async {
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await showDialogForAskLocation(context);
      return false;
    }
    //
    return true;
  }

  Future showDialogForAskLocation(context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Location Permission',
                style:
                    TextStyles(context).getTitleStyle().copyWith(fontSize: 20)),
            content: Text('Please enable location service to continue',
                style: TextStyles(context)
                    .getRegularStyle()
                    .copyWith(fontSize: 16)),
            actions: <Widget>[
              TextButton(
                child: Text('Settings',
                    style: TextStyles(context).getRegularStyle()),
                onPressed: () async {
                  Navigator.of(context).pop();
                  await Geolocator.openLocationSettings();
                },
              ),
              TextButton(
                child: Text(
                  'Cancel',
                  style: TextStyles(context).getRegularStyle(),
                ),
                onPressed: () {
                  serviceEnabled = false;
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}
