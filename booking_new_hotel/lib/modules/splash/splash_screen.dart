import 'dart:async';

import 'package:booking_new_hotel/routes/route_names.dart';
import 'package:geolocator/geolocator.dart';

import '../../languages/appLocalizations.dart';

import '../../service/location/location_service.dart';
import '../../utils/localfiles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/theme_provider.dart';
import '../../utils/text_styles.dart';
import '../../utils/themes.dart';
import '../../widgets/common_button.dart';
import '../../global/global_var.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoadText = false;

  @override
  void initState() {
    StreamSubscription<ServiceStatus> _ =
        Geolocator.getServiceStatusStream().listen((status) async {
      if (status == ServiceStatus.disabled) {
        GlobalVar.locationOfUser = await Geolocator.getLastKnownPosition();
      }
    });
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _loadingApplicationLocalization());
    super.initState();
  }

  Future<void> _loadingApplicationLocalization() async {
    try {
      // loading all text json file to all the languageTextData
      setState(() {
        isLoadText = true;
      });
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // stack helps overload widgets
          Container(
              foregroundDecoration: !appTheme.isLightMode
                  ? BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .background
                          .withOpacity(0.4))
                  : null,
              width: MediaQuery.of(context)
                  .size
                  .width, // it helps to get the width of the screen
              height: MediaQuery.of(context)
                  .size
                  .height, // it helps to get the height of the screen
              child: Image.asset(
                Localfiles.introduction,
                fit: BoxFit.cover,
              )),
          Column(children: <Widget>[
            const Expanded(
              flex: 1,
              child: SizedBox(),
            ),
            Center(child: GlobalVar.iconic.appIcon(context)),
            const SizedBox(height: 13),
            GlobalVar.iconic.nameOfApp(context),
            const SizedBox(height: 8.0),
            AnimatedOpacity(
              opacity: isLoadText ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 420),
              child: Text(
                AppLocalizations(context).of("best_hotel_deals"),
                textAlign: TextAlign.left,
                style: TextStyles(context).getRegularStyle().copyWith(),
              ),
            ),
            const Expanded(
              flex: 4, // it helps to take 4/6 part of the screen
              child: SizedBox(),
            ),
            AnimatedOpacity(
                opacity: isLoadText ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 680),
                child: CommonButton(
                  padding: const EdgeInsets.only(left: 48, right: 48),
                  buttonText: AppLocalizations(context).of("get_started"),
                  onTap: () async {
                    if (await LocationService().getLocation(context)) {
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => const Center(
                                child: CircularProgressIndicator(),
                              ));
                      GlobalVar.locationOfUser =
                          await Geolocator.getCurrentPosition(
                              desiredAccuracy: LocationAccuracy.high);
                      print(
                          "After turn on again: ${GlobalVar.locationOfUser!.latitude}");
                      print(
                          "After turn on again: ${GlobalVar.locationOfUser!.longitude}");
                      Navigator.of(context).pop();
                      NavigationServices(context).gotoIntroductionScreen();
                    }
                    setState(() {});
                  },
                )),
            AnimatedOpacity(
                opacity: isLoadText ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 680),
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: 24.0 + MediaQuery.of(context).padding.bottom,
                    top: 16.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations(context).of("already_have_account"),
                        textAlign: TextAlign.left,
                        style: TextStyles(context)
                            .getDescriptionStyle()
                            .copyWith(color: AppTheme.whiteColor),
                      ),
                      const SizedBox(width: 5),
                      GestureDetector(
                        onTap: () async {
                          if (await LocationService().getLocation(context)) {
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) => const Center(
                                      child: CircularProgressIndicator(),
                                    ));
                            GlobalVar.locationOfUser =
                                await Geolocator.getCurrentPosition(
                                    desiredAccuracy: LocationAccuracy.high);
                            Navigator.of(context).pop();
                            NavigationServices(context)
                                .gotoLoginOrSignUpScreen(true);
                          }
                        },
                        child: Text(AppLocalizations(context).of("login"),
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              color: Colors.blue,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    ],
                  ),
                )),
            const SizedBox(
              height: 30,
            )
          ])
        ],
      ),
    );
  }
}
