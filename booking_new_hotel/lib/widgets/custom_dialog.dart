import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomDialog extends StatefulWidget {
  String title;
  String description;
  Function onCloseClick;
  List<Widget> actionButtonList;

  CustomDialog(
      {super.key,
      required this.title,
      required this.description,
      required this.onCloseClick,
      required this.actionButtonList});

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
