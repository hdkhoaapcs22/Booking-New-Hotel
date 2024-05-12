import 'package:booking_new_hotel/languages/appLocalizations.dart';
import 'package:booking_new_hotel/models/hotel.dart';
import 'package:booking_new_hotel/widgets/list_cell_animation_view.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

import '../../utils/text_styles.dart';
import '../../utils/themes.dart';
import '../../widgets/common_card.dart';

class ReviewsView extends StatelessWidget {
  final VoidCallback callback;
  final Hotel reviewsList;
  final AnimationController animationController;
  final Animation<double> animation;
  const ReviewsView(
      {super.key,
      required this.callback,
      required this.reviewsList,
      required this.animationController,
      required this.animation});

  @override
  Widget build(BuildContext context) {
    return ListCellAnimationView(
      animation: animation,
      yTranslation: 40,
      child: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, top: 16),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 48,
                    child: CommonCard(
                      radius: 8,
                      color: AppTheme.whiteColor,
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Image.asset(reviewsList.imageHotel,
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      reviewsList.name,
                      style: TextStyles(context)
                          .getBoldStyle()
                          .copyWith(fontSize: 14),
                    ),
                    Row(
                      children: [
                        Text(
                          AppLocalizations(context).of("last_update"),
                          style: TextStyles(context)
                              .getDescriptionStyle()
                              .copyWith(
                                  fontWeight: FontWeight.w100,
                                  color: Theme.of(context).disabledColor,
                                  fontSize: 15),
                        ),
                        Text(
                          " " + reviewsList.dateTxt,
                          style: TextStyles(context)
                              .getDescriptionStyle()
                              .copyWith(
                                  fontWeight: FontWeight.w100,
                                  color: Theme.of(context).disabledColor,
                                  fontSize: 15),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "(${reviewsList.rating})",
                          style: TextStyles(context).getBoldStyle().copyWith(
                              fontWeight: FontWeight.w100,
                              color: Theme.of(context).disabledColor,
                              fontSize: 15),
                        ),
                        SmoothStarRating(
                          allowHalfRating: false,
                          starCount: 5,
                          rating: reviewsList.rating,
                          size: 16.0,
                          color: Theme.of(context).primaryColor,
                          borderColor: Theme.of(context).primaryColor,
                          spacing: 0.0,
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                reviewsList.locationOfHotel,
                style: TextStyles(context).getDescriptionStyle().copyWith(
                      fontWeight: FontWeight.w100,
                      color: Theme.of(context).disabledColor,
                    ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Row(
                        children: [
                          Text(
                            AppLocalizations(context).of("reply"),
                            textAlign: TextAlign.left,
                            style: TextStyles(context)
                                .getRegularStyle()
                                .copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: Theme.of(context).primaryColor),
                          ),
                          SizedBox(
                            height: 38,
                            width: 26,
                            child: Icon(
                              Icons.arrow_forward,
                              size: 14,
                              color: Theme.of(context).primaryColor,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Divider(
              height: 1,
              color: Theme.of(context).dividerColor,
            ),
          ],
        ),
      ),
    );
  }
}
