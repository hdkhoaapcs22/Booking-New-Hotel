import 'package:flutter/material.dart';

import '../utils/themes.dart';

class CommonCard extends StatefulWidget {
  final Color? color;
  final double radius;
  final Widget? child;
  final double? elevation;
  const CommonCard({super.key, this.color, required this.radius, this.child, this.elevation});

  @override
  State<CommonCard> createState() => _CommonCardState();
}

class _CommonCardState extends State<CommonCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: widget.elevation ?? (AppTheme.isLightMode ? 4 : 0), // it helps to show shadow
      color: widget.color, // it helps to set background color
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(widget.radius),
      ),
      child: widget.child, // it helps to set child
    );
  }
}
