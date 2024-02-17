import 'package:booking_new_hotel/languages/appLocalizations.dart';
import 'package:booking_new_hotel/utils/text_styles.dart';
import 'package:flutter/material.dart';

import '../../../routes/routes.dart';
import '../../../utils/themes.dart';

// ignore: must_be_immutable
class FilterBarUI extends StatelessWidget {
  Function(Map) onFilterCallback;
  FilterBarUI(this.onFilterCallback, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: AppTheme.scaffoldBackgroundColor,
        child: Stack(children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 4),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    "530",
                    style: TextStyles(context).getRegularStyle(),
                  ),
                ),
                Expanded(
                    child: Padding(
                        padding: const EdgeInsets.only(left: 0.0),
                        child: Text(
                          AppLocalizations(context).of("hotel_found"),
                          style: TextStyles(context).getRegularStyle(),
                        ))),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                    onTap: () async {
                      // NavigationServices(context).gotoFilterScreen();
                      dynamic result = await Navigator.pushNamed(
                          context, RoutesName.FilterScreen);
                          onFilterCallback(result);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Row(
                        children: [
                          Text(
                            AppLocalizations(context).of("filtter"),
                            style: TextStyles(context).getRegularStyle(),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Icon(
                              Icons.sort,
                              color: Theme.of(context).primaryColor,
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
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Divider(
              height: 1,
              color: Colors.grey.withOpacity(0.4),
            ),
          )
        ]));
  }
}
