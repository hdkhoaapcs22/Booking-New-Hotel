import 'package:booking_new_hotel/global/global_var.dart';
import 'package:booking_new_hotel/languages/appLocalizations.dart';
import 'package:booking_new_hotel/widgets/common_app_bar_view.dart';
import 'package:booking_new_hotel/widgets/common_textfield_view.dart';
import 'package:booking_new_hotel/widgets/remove_focus.dart';
import 'package:flutter/material.dart';
import '../../models/setting_list_data.dart';
import '../../utils/localfiles.dart';
import '../../utils/themes.dart';
import '../../widgets/common_button.dart';
import '../../widgets/got_it_dialog.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  List<SettingsListData> userSettingsList = SettingsListData.userSettingsList;
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    nameController.dispose();
    addressController.dispose();
    phoneController.dispose();
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
        child: ListView(
          children: [
            CommonAppBarView(
              iconData: Icons.arrow_back,
              titleText: AppLocalizations(context).of("edit_profile"),
              onBackClick: () {
                Navigator.pop(context);
              },
              topPadding: AppBar().preferredSize.height + 10,
            ),
            const SizedBox(height: 20),
            const Center(
              child: CircleAvatar(
                radius: 65,
                backgroundImage: AssetImage(Localfiles.userImage),
              ),
            ),
            CommonTextFieldView(
              padding: const EdgeInsets.only(left: 24, right: 24),
              titleText: AppLocalizations(context).of("name"),
              hintText: AppLocalizations(context).of("enter_name"),
              controller: nameController,
            ),
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
                buttonTextWidget: Text(
                  AppLocalizations(context).of("update_profile"),
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  String name = nameController.text.trim();
                  String address = addressController.text.trim();
                  String phone = phoneController.text.trim();
                  GlobalVar.user!
                      .setUserInfo(name: name, address: address, phone: phone);
                  GlobalVar.databaseService!.userInfoDatabase.updateUserInfoData(
                      name: name, address: address, phone: phone);
                  // show the dialog to show the success message
                  GotItDialog successDialog = GotItDialog(
                    context: context,
                    title: "updated",
                    description: "profile_updated",
                  );
                  successDialog.gotItDialog();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
