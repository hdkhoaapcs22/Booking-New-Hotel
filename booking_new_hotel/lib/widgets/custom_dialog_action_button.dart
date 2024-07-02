import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomDialogActionButton extends StatefulWidget {
  String buttonText;
  Color color;
  VoidCallback onPressed;
  CustomDialogActionButton(
      {super.key,
      required this.buttonText,
      required this.color,
      required this.onPressed});

  @override
  State<CustomDialogActionButton> createState() =>
      _CustomDialogActionButtonState();
}

class _CustomDialogActionButtonState extends State<CustomDialogActionButton> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: widget.onPressed,
        child: Center(
          child: Text(widget.buttonText,
              style: TextStyle(
                color: widget.color,
                fontSize: 18,
              )),
        ),
      ),
    );
  }
}
