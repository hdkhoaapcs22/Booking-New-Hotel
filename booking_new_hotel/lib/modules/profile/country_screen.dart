import 'dart:convert';

import 'package:booking_new_hotel/models/setting_list_data.dart';
import 'package:booking_new_hotel/widgets/common_app_bar_view.dart';
import 'package:flutter/material.dart';

import '../../utils/text_styles.dart';
import '../../widgets/remove_focus.dart';

class CountryScreen extends StatefulWidget {
  const CountryScreen({super.key});

  @override
  State<CountryScreen> createState() => _CountryScreenState();
}

class _CountryScreenState extends State<CountryScreen> {
  List<SettingsListData> countryList = [];

  @override
  void initState() {
    _getCountryList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: RemoveFocus(
          onClick: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonAppBarView(
                iconData: Icons.arrow_back,
                titleText: "Country",
                onBackClick: () {
                  Navigator.pop(context);
                },
              ),
              Expanded(
                child: countryList.isEmpty
                    ? const Center(
                        child: SizedBox(
                          width: 40,
                          height: 40,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        ),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.only(
                            bottom: 16 + MediaQuery.of(context).padding.bottom),
                        itemCount: countryList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.pop(
                                  context, "${countryList[index].titleTxt} ");
                            },
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 8, right: 16),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Text(
                                            countryList[index].titleTxt,
                                            style: TextStyles(context)
                                                .getRegularStyle()
                                                .copyWith(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16,
                                                ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Container(
                                          child: Text(
                                            countryList[index].subTxt,
                                            style: TextStyles(context)
                                                .getRegularStyle()
                                                .copyWith(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16, right: 16),
                                  child: Divider(
                                    height: 1,
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _getCountryList() async {
    countryList = SettingsListData().getCountryListFromJson(json.decode(
        await DefaultAssetBundle.of(context)
            .loadString("assets/json/countryList.json")));
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {});
  }
}
