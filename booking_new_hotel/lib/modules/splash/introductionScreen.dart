import 'dart:async';
import '../../widgets/common_button.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../languages/appLocalizations.dart';
import '../../utils/localfiles.dart';
import '../../utils/themes.dart';
import 'components/page_popview.dart';
import '../../routes/route_names.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({super.key});

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  var pageController = PageController(initialPage: 0);
  List<PageViewData> pageViewModelData = [];
  late Timer sliderTime;

  var currentShowIndex = 0;

  @override
  void initState() {
    pageViewModelData.add(PageViewData(
      titleText: 'plan_your_trips',
      subText: 'book_one_of_your',
      assetImage: Localfiles.introduction1,
    ));
    pageViewModelData.add(PageViewData(
      titleText: 'find_best_deals',
      subText: 'find_deals_for_any',
      assetImage: Localfiles.introduction2,
    ));
    pageViewModelData.add(PageViewData(
      titleText: 'best_travelling_all_time',
      subText: 'find_deals_for_any',
      assetImage: Localfiles.introduction3,
    ));

    sliderTime = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (currentShowIndex == 0) {
        pageController.animateTo(MediaQuery.of(context).size.width,
            duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
      } else if (currentShowIndex == 1) {
        pageController.animateTo(MediaQuery.of(context).size.width * 2,
            duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
      } else if (currentShowIndex == 2) {
        pageController.animateTo(0,
            duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    sliderTime.cancel();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      SizedBox(
        height: MediaQuery.of(context).padding.top,
      ),
      Expanded(
          child: PageView(
              controller: pageController,
              pageSnapping:
                  true, // it helps to scroll page by page and doesn't stop in middle of page
              onPageChanged: (index) {
                // it helps to change the page indicator
                currentShowIndex = index;
              },
              scrollDirection: Axis.horizontal,
              children: [
            PagePopup(imageData: pageViewModelData[0]),
            PagePopup(imageData: pageViewModelData[1]),
            PagePopup(imageData: pageViewModelData[2]),
          ])),
      SmoothPageIndicator(
        controller: pageController,
        count: pageViewModelData.length,
        effect: WormEffect(
          activeDotColor: Theme.of(context).primaryColor,
          dotColor: Theme.of(context).dividerColor,
          dotHeight: 10.0,
          dotWidth: 10.0,
          spacing: 5.0,
        ),
        onDotClicked: (index) => {},
      ),
      const SizedBox(height: 8),
      CommonButton(
        padding: const EdgeInsets.only(left: 48, right: 48, bottom: 8, top: 8),
        buttonText: AppLocalizations(context).of("login"),
        onTap: () {
          NavigationServices(context).gotoLoginScreen();
        },
      ),
      CommonButton(
        padding: const EdgeInsets.only(left: 48, right: 48, bottom: 8, top: 8),
        backgroundColor: AppTheme.backgroundColor,
        textColor: const Color.fromARGB(255, 0, 0, 0),
        buttonText: AppLocalizations(context).of("create_account"),
        onTap: () {},
      ),
      SizedBox(height: 50) // it helps create space for bottom
    ]));
  }
}
