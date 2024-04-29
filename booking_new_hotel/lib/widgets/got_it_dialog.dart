import 'package:booking_new_hotel/utils/text_styles.dart';
import 'package:flutter/material.dart';

import '../languages/appLocalizations.dart';

// ignore: must_be_immutable
class GotItDialog {
  late BuildContext context;
  late String title;
  String? description;
  GotItDialog({required this.context, required this.title, this.description});
  Future gotItDialog() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: SizedBox(
          height: MediaQuery.of(context).size.height * 0.08,
          width: MediaQuery.of(context).size.width * 0.6,
          child: Column(children: [
            Text(
              AppLocalizations(context).of(title),
              style: TextStyles(context).getTitleStyle().copyWith(
                    fontSize: 20,
                  ),
            ),
            description != null
                ? Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Text(
                      AppLocalizations(context).of(description!),
                      style: TextStyles(context).getRegularStyle().copyWith(
                            fontSize: 16,
                            wordSpacing: 1.5,
                          ),
                    ),
                  )
                : Container(),
          ]),
        ),
        actions: [
          Container(
              height: 45,
              decoration: BoxDecoration(
                color: Colors.grey[200],
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  AppLocalizations(context).of("got_it"),
                  style: TextStyles(context).getRegularStyle().copyWith(
                        fontSize: 16,
                        wordSpacing: 1.5,
                      ),
                ),
              )),
        ],
      ),
    );
  }
}
