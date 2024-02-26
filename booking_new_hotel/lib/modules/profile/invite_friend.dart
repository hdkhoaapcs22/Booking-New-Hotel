import 'package:booking_new_hotel/languages/appLocalizations.dart';
import 'package:booking_new_hotel/widgets/common_button.dart';
import 'package:flutter/material.dart';

import '../../utils/localfiles.dart';
import '../../utils/text_styles.dart';
import '../../utils/themes.dart';

class InviteFriend extends StatefulWidget {
  const InviteFriend({super.key});

  @override
  State<InviteFriend> createState() => _InviteFriendState();
}

class _InviteFriendState extends State<InviteFriend> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Stack(
          children: [
            Column(children: [
              Container(
                padding: EdgeInsets.only(
                  top: AppBar().preferredSize.height,
                  left: 16,
                  right: 16,
                ),
                child: Image.asset(Localfiles.inviteImage),
              ),
              Container(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  AppLocalizations(context).of("invite_your_friend"),
                  style:
                      TextStyles(context).getBoldStyle().copyWith(fontSize: 20),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  AppLocalizations(context).of("invite_your_friend_desc"),
                  textAlign: TextAlign.center,
                  style: TextStyles(context)
                      .getRegularStyle()
                      .copyWith(fontSize: 16),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CommonButton(
                      radius: 4,
                      buttonTextWidget: SizedBox(
                        height: 40,
                        width: 120,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.share,
                                color: Colors.white, size: 22),
                            Padding(
                                padding: const EdgeInsets.all(4),
                                child: Text(
                                  AppLocalizations(context).of("share_text"),
                                  style: TextStyles(context)
                                      .getRegularStyle()
                                      .copyWith(color: AppTheme.whiteColor),
                                ))
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ]),
            Padding(
              padding: EdgeInsets.only(
                top: AppBar().preferredSize.height,
              ),
              child: Row(
                children: [
                  appBar(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  appBar() {
    return SizedBox(
        height: AppBar().preferredSize.height,
        child: Padding(
          padding: const EdgeInsets.only(top: 8, left: 8),
          child: Container(
            width: AppBar().preferredSize.height - 8,
            height: AppBar().preferredSize.height - 8,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                  borderRadius: const BorderRadius.all(Radius.circular(32.0)),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.arrow_back_ios_new,
                    ),
                  )),
            ),
          ),
        ));
  }
}
