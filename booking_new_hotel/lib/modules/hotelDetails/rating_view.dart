import 'package:booking_new_hotel/languages/appLocalizations.dart';
import 'package:booking_new_hotel/models/hotel.dart';
import 'package:booking_new_hotel/widgets/common_card.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import '../../utils/text_styles.dart';
import '../../utils/themes.dart';

class RatingView extends StatefulWidget {
  final Hotel hotelData;
  const RatingView({super.key, required this.hotelData});

  @override
  State<RatingView> createState() => _RatingViewState();
}

class _RatingViewState extends State<RatingView> {
  @override
  Widget build(BuildContext context) {
    var rating = widget.hotelData.rating;
    return CommonCard(
      radius: 16,
      color: AppTheme.backgroundColor,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 16, 3, 16),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 80,
                  child: Text(
                    rating.toStringAsFixed(1),
                    textAlign: TextAlign.left,
                    style: TextStyles(context).getBoldStyle().copyWith(
                          fontSize: 42,
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 3),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppLocalizations(context).of("Overall_rating"),
                            textAlign: TextAlign.left,
                            style:
                                TextStyles(context).getRegularStyle().copyWith(
                                      fontSize: 14,
                                      color: Theme.of(context).disabledColor,
                                    )),
                        SmoothStarRating(
                          allowHalfRating: false,
                          starCount: 5,
                          rating: rating,
                          size: 40.0,
                          color: Colors.green,
                          borderColor: Colors.green,
                          spacing: 0.0,
                          // onRatingChanged: (v) {
                          //   setState(() {
                          //     rating = v;
                          //   });
                          // },
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 4),
            getBarUI('room', 95.0, context),
            const SizedBox(height: 4),
            getBarUI('service', 80.0, context),
            const SizedBox(height: 4),
            getBarUI('location', 65.0, context),
            const SizedBox(height: 4),
            getBarUI('price', 85.0, context),
          ],
        ),
      ),
    );
  }

  getBarUI(String text, double percent, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 105,
          child: Text(
            AppLocalizations(context).of(text),
            textAlign: TextAlign.left,
            style: TextStyles(context).getRegularStyle().copyWith(
                  fontSize: 14,
                  color: Theme.of(context).disabledColor.withOpacity(0.8),
                ),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
            child: Row(
          children: [
            Expanded(
              flex: percent.toInt(),
              child: Padding(
                padding: const EdgeInsets.only(top: 2),
                child: SizedBox(
                    height: 4,
                    child: CommonCard(
                      color: AppTheme.primaryColor,
                      radius: 8,
                    )),
              ),
            ),
            Expanded(
              flex: 100 - percent.toInt(),
              child: const SizedBox(),
            )
          ],
        ))
      ],
    );
  }
}
