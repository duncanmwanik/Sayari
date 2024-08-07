import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_helpers/date_time/misc.dart';
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
          // bool isSent = box.get(messageId, defaultValue: {})['s'] == '1';
          // bool isPending = isPendingItem(messageId);
          return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
            return AppButton(
              menuItems: messageMenu(messageId, messageData),
              padding: EdgeInsets.zero,
              hoverColor: transparent,
              noStyling: true,
              showBorder: true,
              borderWidth: 0.5,
              child: Container(
                padding: itemPaddingMedium(),
                constraints: BoxConstraints(maxWidth: constraints.maxWidth * 0.6, minWidth: 100),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: isShortMessage ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                  children: [
                    //
                    FileList(fileData: getFiles(messageData)),
                    // message
                    AppText(size: 13, text: message, fontWeight: FontWeight.w500),
                    if (isShortMessage) sph(),
                    //
                    tph(),
                    // sent status Icon
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        //
                        // AppButton(
                        //   menuItems: messageMenu(messageId, messageData),
                        //   noStyling: true,
                        //   isRound: true,
                        //   leading: moreIcon,
                        // ),
                        // spw(),
                        // time
                        AppText(size: tiny, text: getTimeFromTimestamp(messageId), fontWeight: FontWeight.w500),
                        spw(),
                        // status
                        AppIcon(Icons.done_rounded, size: 15),
                        // AppIcon(isSent ? moreIcon : (isPending ? Icons.refresh_rounded : Icons.done_rounded), size: 15),
                        //
                      ],
                    ),
                    //
                    tph(),
                    //
                  ],
                ),
              ),
            );
          });
        });
  }
}
