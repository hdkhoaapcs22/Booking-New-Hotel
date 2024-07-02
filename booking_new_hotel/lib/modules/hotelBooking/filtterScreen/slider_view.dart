import 'package:booking_new_hotel/languages/appLocalizations.dart';
import 'package:flutter/material.dart';

class SliderView extends StatefulWidget {
  final Function(double) onChangedDistValue;
  final double distValue;

  const SliderView(
      {super.key, required this.onChangedDistValue, required this.distValue});

  @override
  State<SliderView> createState() => _SliderViewState();
}

class _SliderViewState extends State<SliderView> {
  double distValue = 50.0;

  @override
  void initState() {
    distValue = widget.distValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Row(
          children: [
            const Expanded(
              flex: 100,
              child: SizedBox(),
            ),
            Container(
              width: 170,
              child: Row(
                children: [
                  Text(
                    AppLocalizations(context).of("less_than"),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 4.0, right: 4.0),
                    child: Text(
                      "${(distValue / 10).toStringAsFixed(1)}",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Text(
                    AppLocalizations(context).of("km_text"),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const Expanded(
              flex: 60,
              child: SizedBox(),
            ),
          ],
        ),
        Slider(
          onChanged: (value) {
            setState(() {
              distValue = value;
            });
            try {
              widget.onChangedDistValue(distValue);
            } catch (e) {}
          },
          min: 0.0,
          max: 100.0,
          activeColor: Theme.of(context).primaryColor,
          inactiveColor: Colors.grey.withOpacity(0.4),
          value: distValue,
        ),
      ]),
    );
  }
}
