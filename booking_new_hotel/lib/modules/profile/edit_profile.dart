import 'package:booking_new_hotel/languages/appLocalizations.dart';
import 'package:booking_new_hotel/widgets/common_app_bar_view.dart';
import 'package:booking_new_hotel/widgets/common_textfield_view.dart';
import 'package:booking_new_hotel/widgets/remove_focus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/setting_list_data.dart';
import '../../service/Database/database_service.dart';
import '../../utils/localfiles.dart';
import '../../utils/themes.dart';
import '../../widgets/common_button.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  List<SettingsListData> userSettingsList = SettingsListData.userSettingsList;
  DatabaseService databaseService =
      DatabaseService(uid: "jWslizNXKfZbYtZ3X897jYZ6wC43");
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.scaffoldBackgroundColor,
      body: RemoveFocus(
        onClick: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: ListView(
          children: [
            CommonAppBarView(
              iconData: Icons.arrow_back,
              titleText: AppLocalizations(context).of("edit_profile"),
              onBackClick: () {
                Navigator.pop(context);
              },
              topPadding: AppBar().preferredSize.height,
            ),
            const SizedBox(height: 20),
            const Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage(Localfiles.userImage),
              ),
            ),
            CommonTextFieldView(
              padding: const EdgeInsets.only(left: 24, right: 24),
              titleText: AppLocalizations(context).of("name"),
              hintText: AppLocalizations(context).of("enter_name"),
              controller: nameController,
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 25, 24, 2),
                child: Text(
                  "email",
                  style: TextStyle(color: Theme.of(context).disabledColor),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24, top: 5),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        shadowColor: Colors.black12.withOpacity(
                            Theme.of(context).brightness == Brightness.dark
                                ? 0.6
                                : 0.2),
                        child: const Padding(
                          padding: EdgeInsets.all(14),
                          child: Text("haha"),
                        )),
                  ))
            ]),
            CommonTextFieldView(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 5),
              titleText: AppLocalizations(context).of("phone"),
              hintText: AppLocalizations(context).of("enter_phone_number"),
              controller: phoneController,
            ),
            CommonTextFieldView(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 5),
              titleText: AppLocalizations(context).of("address_text"),
              hintText: AppLocalizations(context).of("enter_address"),
              controller: addressController,
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 5),
              child: CommonButton(
                buttonText: AppLocalizations(context).of("update_profile"),
                buttonTextWidget: Text(
                  AppLocalizations(context).of("update_profile"),
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  databaseService.updateUserInfoData(
                      name: nameController.text,
                      email: "haha",
                      address: addressController.text,
                      phone: phoneController.text);
                  final information = Provider.of<QuerySnapshot>(context);

                  if (information != null) {
                    for (var doc in information.docs) {
                      print(doc.data());
                    }
                  }
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
