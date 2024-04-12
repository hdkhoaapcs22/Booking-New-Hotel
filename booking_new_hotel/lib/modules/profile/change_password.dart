import 'package:booking_new_hotel/widgets/common_app_bar_view.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        CommonAppBarView(
          topPadding: AppBar().preferredSize.height + 20,
          iconData: Icons.arrow_back,
          titleText: "Change Password",
          onBackClick: () {
            Navigator.pop(context);
          },
        ),
      ],
    ));
  }
}
