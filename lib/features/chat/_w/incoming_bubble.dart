import 'package:flutter/material.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_widgets/abcs/buttons/buttons.dart';
import '../../../_widgets/others/text.dart';
import '../../files/_helpers/helper.dart';
import '../../files/file_list.dart';
import 'options.dart';

class IncomingMessageBubble extends StatelessWidget {
  const IncomingMessageBubble({super.key, required this.messageId, required this.messageData});
  final String messageId;
  final Map messageData;

  @override
  Widget build(BuildContext context) {
    String userName = messageData['u'] ?? 'User';
    String message = messageData['n'];

    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      return AppButton(
        menuItems: messageMenu(messageId, messageData),
        hoverColor: transparent,
        padding: EdgeInsets.zero,
        color: Color.alphaBlend(styler.accentColor(0.3), styler.appColor(1)),
        child: Container(
          padding: itemPaddingMedium(left: true, right: true, top: true),
          constraints: BoxConstraints(maxWidth: constraints.maxWidth * 0.6, minWidth: 100),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // username
              AppText(text: userName, fontWeight: FontWeight.w900),
              tph(),
              //
              // files
              FileList(fileData: getFiles(messageData)),
              //
              // message
              AppText(size: 13, text: message, fontWeight: FontWeight.w500),
              //
              // time
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //
                  AppText(size: tiny, text: '6:10 PM', fontWeight: FontWeight.w500),
                  //
                  spw(),
                  AppButton(
                    menuItems: messageMenu(messageId, messageData),
                    noStyling: true,
                    isRound: true,
                    leading: moreIcon,
                  ),
                  //
                ],
              ),
              //
            ],
          ),
        ),
      );
    });
  }
}
