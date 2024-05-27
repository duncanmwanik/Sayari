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
      noStyling: true,
      borderRadius: 0,
      padding: EdgeInsets.zero,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Container(
              constraints: BoxConstraints(maxWidth: maxChatWidth(), minWidth: 55),
              margin: itemMargin(top: true, left: true),
              padding: itemPadding(),
              decoration: BoxDecoration(
                color: styler.chatBubbleColor(),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(borderRadiusSmall),
                  bottomLeft: Radius.circular(borderRadiusSmall),
                  bottomRight: Radius.circular(borderRadiusSmall),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // username
                  AppText(size: small, text: userName, color: black, fontWeight: FontWeight.w700),
                  //
                  sph(),
                  // message
                  AppText(
                    size: 15,
                    text: message,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                  //
                  sph(),
                  // message
                  AppText(size: small, text: '6:10 PM', color: Colors.black, fontWeight: FontWeight.w500),
                  //
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
