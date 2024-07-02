import 'package:flutter/material.dart';

class RangeSliderView extends StatefulWidget {
  final Function(RangeValues) onChangeRangeValue;
  final RangeValues values;

  const RangeSliderView(
      {super.key, required this.onChangeRangeValue, required this.values});

  @override
  State<RangeSliderView> createState() => _RangeSliderViewState();
}

class _RangeSliderViewState extends State<RangeSliderView> {
  late RangeValues _values;

  @override
  void initState() {
    _values = widget.values;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Row(
              children: [
                Expanded(
                  flex: _values.start.round(),
                  child: const SizedBox(),
                ),
                SizedBox(
                  width: 54,
                  child: Text(
                    "${_values.start.round()}\$", // \$ is used to show the dollar sign, and ${_values.start.round()} is used to show the value of the start range
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  flex: 2000 - _values.start.round(),
                  child: const SizedBox(),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: _values.end.round(),
                  child: const SizedBox(),
                ),
                SizedBox(
                  width: 54,
                  child: Text(
                    "${_values.end.round()}\$",
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  flex: 2000 - _values.end.round(),
                  child: const SizedBox(),
                ),
              ],
            )
          ],
        ),
        SliderTheme(
            data: const SliderThemeData(),
            child: RangeSlider(
              values: _values,
              min: 10.0,
              max: 2000.0,
              activeColor: Theme.of(context).primaryColor,
              inactiveColor: Colors.grey.withOpacity(0.4),
              divisions: 1000,
              onChanged: (values) {
                try {
                  setState(() {
                    _values = values;
                  });
                  widget.onChangeRangeValue(
                      _values); // This will pass the value of the range slider to the parent widget. We need to do this because the state of the parent widget is not accessible from the child widget.
                } catch (e) {}
              },
            ))
      ],
    );
  }
}
