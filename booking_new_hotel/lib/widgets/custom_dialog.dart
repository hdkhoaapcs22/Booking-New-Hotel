import 'package:flutter/material.dart';

import '../utils/text_styles.dart';

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
    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(18.0)),
      ),
      child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.18,
          width: MediaQuery.of(context).size.width * 0.9,
          child: Column(
            children: [
              Row(children: [
                Expanded(
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(18.0),
                          topRight: Radius.circular(18.0)),
                    ),
                    child: Center(
                      child: Text(widget.title,
                          style: TextStyles(context)
                              .getBoldStyle()
                              .copyWith(fontSize: 18)),
                    ),
                  ),
                ),
              ]),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(widget.description,
                    style: TextStyles(context).getDescriptionStyle()),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Divider(
                  height: 1,
                  color: Colors.grey[400],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: widget.actionButtonList,
              )
            ],
          )),
    );
  }
}
