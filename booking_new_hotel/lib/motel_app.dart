import 'dart:io';

import 'package:booking_new_hotel/languages/appLocalizations.dart';
import 'package:booking_new_hotel/modules/splash/introductionScreen.dart';
import 'package:booking_new_hotel/modules/splash/splashScreen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import 'common/common.dart';
import 'modules/next_page.dart';
import 'utils/enum.dart';
import '../routes/routes.dart';

BuildContext? applicationcontext;

class MotelApp extends StatefulWidget {
  @override
  _MotelAppState createState() => _MotelAppState();
}

class _MotelAppState extends State<MotelApp> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (_, provider, child) {
      applicationcontext = context;
      final ThemeData _theme = provider.themeData;
      return MaterialApp(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate
          ],
          supportedLocales: const [
            Locale('en'),
            Locale('fr'),
            Locale('ja'),
            Locale('ar'),
          ],
          navigatorKey: navigatorKey,
          title: 'Motel App',
          debugShowCheckedModeBanner: false,
          theme: _theme,
          routes: _buildRoutes(),
          builder: (BuildContext context, Widget? child) {
            _setFirstTimeSomeData(context, _theme);
            return Directionality(
                textDirection: context.read<ThemeProvider>().languageType ==
                        LanguageType.ar
                    ? TextDirection.rtl
                    : TextDirection.ltr,
                child: Builder(
                  builder: (BuildContext context) {
                    return MediaQuery(
                      data: MediaQuery.of(context).copyWith(
                        textScaler: TextScaler.linear(
                            MediaQuery.of(context).size.width > 360
                                ? 1.0
                                : (MediaQuery.of(context).size.width >= 340
                                    ? 0.9
                                    : 0.8)),
                      ),
                      child: child ?? const SizedBox(),
                    );
                  },
                ));
          });
    });
  }

  void _setFirstTimeSomeData(BuildContext context, ThemeData theme) {
    applicationcontext = context;
    _setStatusBarNavigationBarTheme(theme);
    // we call some theme basic data set in the app like color, font, theme mode, language
    context
        .read<ThemeProvider>()
        .checkAndSetThemeMode(MediaQuery.of(context).platformBrightness);

    context
        .read<ThemeProvider>()
        .checkAndSetLanguage(); // it helps to set the previous language
    context.read<ThemeProvider>().checkAndSetFonType();
    context.read<ThemeProvider>().checkAndSetColorType();
  }

  Map<String, WidgetBuilder> _buildRoutes() {
    return {
      RoutesName.Splash: (BuildContext context) => const SplashScreen(),
      RoutesName.Introduction: (BuildContext context) =>
          const IntroductionScreen(),
      RoutesName.NextPage: (BuildContext context) => const NextPage(),
    };
  }

  void _setStatusBarNavigationBarTheme(ThemeData themeData) {
    final brightness = !kIsWeb && Platform.isAndroid
        ? (themeData.brightness == Brightness.light
            ? Brightness.dark
            : Brightness.light)
        : themeData.brightness;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: brightness,
      systemNavigationBarColor: themeData.scaffoldBackgroundColor,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: brightness,
    ));
  }
}
