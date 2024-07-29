import 'package:flutter/material.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_helpers/date_time/misc.dart';
import '../../../_widgets/abcs/buttons/buttons.dart';
import '../../../_widgets/others/icons.dart';
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
        color: Color.alphaBlend(styler.appColor(0.5), styler.appColor(1)),
        child: Container(
          padding: itemPaddingMedium(),
          constraints: BoxConstraints(maxWidth: constraints.maxWidth * 0.6, minWidth: 100),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // dp + username
              AppButton(
                onPressed: () {},
                noStyling: true,
                smallVerticalPadding: true,
                smallLeftPadding: true,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppIcon(Icons.person, size: small),
                    tpw(),
                    Flexible(
                        child: AppText(
                      size: small,
                      text: userName,
                      fontWeight: FontWeight.w700,
                      overflow: TextOverflow.ellipsis,
                    )),
                  ],
                ),
              ),
              //
              tph(),
              // files
              Center(child: FileList(fileData: getFiles(messageData))),
              // message
              AppText(size: 13, text: message, fontWeight: FontWeight.w500),
              //
              tsph(),
              // time
              AppText(size: tiny, text: getTimeFromTimestamp(messageId), fontWeight: FontWeight.w500),
              //
            ],
          ),
        ),
      );
    });
  }
}
