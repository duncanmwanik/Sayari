import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_helpers/pending/pending_actions.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/abcs/buttons/buttons.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';
import '../../_tables/_helpers/common.dart';
import '../../files/_helpers/helper.dart';
import '../../files/file_list.dart';
import 'options.dart';

class SentMessageBubble extends StatelessWidget {
  const SentMessageBubble({super.key, required this.messageId, required this.messageData});
  final String messageId;
  final Map messageData;

  @override
  Widget build(BuildContext context) {
    String message = messageData['n'];
    bool isShortMessage = message.length < 20;

    return ValueListenableBuilder(
        valueListenable: Hive.box('${liveTable()}_${feature.chat.t}').listenable(keys: [messageId]),
        builder: (context, box, widget) {
          bool isSent = box.get(messageId, defaultValue: {})['s'] == '1';
          bool isPending = isPendingItem(messageId);

          return AppButton(
            menuItems: messageMenu(messageId, messageData),
            noStyling: true,
            borderRadius: 0,
            padding: EdgeInsets.zero,
            // The Row minimizes the chat box horizontally
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Container(
                    constraints: BoxConstraints(maxWidth: maxChatWidth(), minWidth: 55),
                    margin: itemMargin(top: true, right: true),
                    padding: EdgeInsets.only(left: 7, right: 7, top: 7),
                    decoration: BoxDecoration(
                      color: styler.chatBubbleColor(isSent: true),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(borderRadiusSmall),
                        bottomLeft: Radius.circular(borderRadiusSmall),
                        bottomRight: Radius.circular(borderRadiusSmall),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: isShortMessage ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                      children: [
                        //
                        FileList(fileData: getFiles(messageData)),
                        // message
                        AppText(size: 15, text: message, fontWeight: FontWeight.w500),
                        if (isShortMessage) sph(),
                        // sent status Icon
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // time
                            AppText(size: small, text: '5:07 PM', fontWeight: FontWeight.w500),
                            //
                            spw(),
                            // status
                            AppIcon(isSent ? moreIcon : (isPending ? Icons.refresh_rounded : Icons.done_rounded), size: 15),
                            //
                          ],
                        ),
                        //
                        sph(),
                        //
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
