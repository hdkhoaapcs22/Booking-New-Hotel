import 'dart:async';

import 'package:booking_new_hotel/languages/appLocalizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../providers/theme_provider.dart';
import '../../utils/enum.dart';
import '../../utils/localfiles.dart';
import '../../utils/text_styles.dart';
import '../../utils/themes.dart';
import '../splash/components/page_popview.dart';

class HomeExploreSliderView extends StatefulWidget {
  final double opValue;
  final VoidCallback click;

  const HomeExploreSliderView(
      {super.key, required this.opValue, required this.click});

  @override
  State<HomeExploreSliderView> createState() => _HomeExploreSliderViewState();
}

class _HomeExploreSliderViewState extends State<HomeExploreSliderView> {
  var pageController = PageController(initialPage: 0);
  List<PageViewData> pageViewData = [];
  late Timer sliderTimer;
  var currentShowIndex = 0;

  @override
  void initState() {
    pageViewData.add(PageViewData(
        titleText: "cape Town",
        subText: "five_star",
        assetImage: Localfiles.explore_2));
    pageViewData.add(PageViewData(
        titleText: "turkey",
        subText: "five_star",
        assetImage: Localfiles.explore_1));
    pageViewData.add(PageViewData(
        titleText: "egypt",
        subText: "five_star",
        assetImage: Localfiles.explore_3));
    sliderTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (mounted) {
        // check because it is possible that the widget is disposed
        if (currentShowIndex == 0) {
          pageController.animateTo(MediaQuery.of(context).size.width,
              duration: const Duration(seconds: 1),
              curve: Curves.fastOutSlowIn);
        } else if (currentShowIndex == 1) {
          pageController.animateTo(MediaQuery.of(context).size.width * 2,
              duration: const Duration(seconds: 1),
              curve: Curves.fastOutSlowIn);
        } else if (currentShowIndex == 2) {
          pageController.animateTo(0,
              duration: const Duration(seconds: 1),
              curve: Curves
                  .fastOutSlowIn); // offset value = 0 because we want to go to the first page
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    sliderTimer.cancel();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(children: [
        PageView.builder(
            controller: pageController,
            pageSnapping:
                true, // it helps to scroll page by page and doesn't stop in middle of page
            onPageChanged: (index) {
              // it is called when the page is changed
              currentShowIndex = index;
            },
            scrollDirection: Axis.horizontal,
            itemCount: pageViewData.length,
            itemBuilder: (BuildContext context, int index) {
              return PagePopup(
                imageData: pageViewData[index],
                opValue: widget.opValue,
              );
            }),
        Positioned(
            bottom: 32,
            right: context.read<ThemeProvider>().languageType == LanguageType.ar
                ? null
                : 32,
            left: context.read<ThemeProvider>().languageType == LanguageType.ar
                ? 32
                : null,
            child: SmoothPageIndicator(
              controller: pageController,
              count: pageViewData.length,
              effect: WormEffect(
                activeDotColor: Theme.of(context).primaryColor,
                dotColor: Colors.white,
                dotHeight: 7.0,
                dotWidth: 7.0,
                spacing: 5.0,
              ),
              onDotClicked: (index) {},
            ))
      ]),
    );
  }
}

class PagePopup extends StatelessWidget {
  final PageViewData imageData;
  final double opValue;
  const PagePopup({super.key, required this.imageData, required this.opValue});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        height: MediaQuery.of(context).size.width * 1.3,
        width: MediaQuery.of(context).size.width,
        child: Image.asset(
          imageData.assetImage,
          fit: BoxFit.cover,
        ),
      ),
      Positioned(
          // it positions the text at the bottom of the image
          // It is usually used to position child widgets in Stack widget or similar
          bottom: 80,
          left: 24,
          right: 24,
          child: Opacity(
              opacity: opValue,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        child: Text(
                      AppLocalizations(context).of(imageData.titleText),
                      textAlign: TextAlign.left,
                      style: TextStyles(context)
                          .getTitleStyle()
                          .copyWith(color: AppTheme.whiteColor),
                    )),
                    const SizedBox(height: 8),
                    Container(
                        child: Text(
                      AppLocalizations(context).of(imageData.subText),
                      textAlign: TextAlign.left,
                      style: TextStyles(context).getRegularStyle().copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.whiteColor),
                    )),
                    const SizedBox(height: 16),
                  ])))
    ]);
  }
}
