import 'package:booking_new_hotel/utils/themes.dart';
import 'package:booking_new_hotel/widgets/list_cell_animation_view.dart';
import 'package:flutter/material.dart';

import '../../models/hotel_list_data.dart';
import '../../utils/helper.dart';
import '../../utils/text_styles.dart';
import '../../widgets/common_card.dart';

class SearchView extends StatelessWidget {
  final HotelListData hotelInfo;
  final AnimationController animationController;
  final Animation<double> animation;

  const SearchView(
      {super.key,
      required this.hotelInfo,
      required this.animationController,
      required this.animation});

  @override
  Widget build(BuildContext context) {
    return ListCellAnimationView(
      animation: animation,
      animationController: animationController,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: AspectRatio(
          aspectRatio: 1,
          child: CommonCard(
            color: AppTheme.backgroundColor,
            radius: 16,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              child: Column(
                children: [
                  AspectRatio(
                    aspectRatio: 1.75,
                    child: Image.asset(
                      hotelInfo.imagePath,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                      child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  hotelInfo.titleTxt,
                                  style: TextStyles(context).getBoldStyle(),
                                ),
                                Text(Helper.getRoomText(hotelInfo.roomData!),
                                    style: TextStyles(context)
                                        .getRegularStyle()
                                        .copyWith(
                                          fontWeight: FontWeight.w100,
                                          fontSize: 12,
                                          color: Theme.of(context)
                                              .disabledColor
                                              .withOpacity(0.6),
                                        )),
                                Text(Helper.getListSearchDate(hotelInfo.date!),
                                    style: TextStyles(context)
                                        .getRegularStyle()
                                        .copyWith(
                                          fontWeight: FontWeight.w100,
                                          fontSize: 12,
                                          color: Theme.of(context)
                                              .disabledColor
                                              .withOpacity(0.6),
                                        ))
                              ])))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
