import 'package:flutter/material.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_widgets/abcs/buttons/buttons.dart';
import '../../../_widgets/others/text.dart';
import 'options.dart';

class IncomingMessageBubble extends StatelessWidget {
  const IncomingMessageBubble({super.key, required this.messageId, required this.messageData});
  final String messageId;
  final Map messageData;

  @override
  Widget build(BuildContext context) {
    String userName = messageData['u'] ?? 'User';
    String message = messageData['n'];

    return AppButton(
      menuItems: messageMenu(messageId, messageData),
      padding: EdgeInsets.zero,
      child: Container(
        padding: itemPaddingMedium(),
        constraints: BoxConstraints(maxWidth: maxChatWidth(), minWidth: 100),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // username
            AppText(size: small, text: userName, fontWeight: FontWeight.w700),
            //
            sph(),
            // message
            AppText(
              size: 15,
              text: message,
              fontWeight: FontWeight.w500,
            ),
            //
            sph(),
            // message
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                //
                AppText(size: small, text: '6:10 PM', fontWeight: FontWeight.w500),
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
  }
}
