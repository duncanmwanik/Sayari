import 'package:flutter/material.dart';

import '../../../__styling/helpers.dart';
import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_models/item.dart';
import '../../../_providers/_providers.dart';
import '../../../_services/hive/local_storage_service.dart';
import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';
import '../../calendar/_helpers/date_time/misc.dart';
import '../../files/_helpers/helper.dart';
import '../../files/file_list.dart';
import '../_w/actions.dart';

class SentMessageBubble extends StatelessWidget {
  const SentMessageBubble({super.key, required this.item});
  final Item item;

  @override
  Widget build(BuildContext context) {
    String message = item.data['n'];
    bool isShortMessage = message.length < 20;
    bool isPending = pendingBox.containsKey(item.sid);
    Map files = getFiles(item.data);

    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      return MouseRegion(
        onEnter: (value) => state.hover.set(item.sid),
        onExit: (value) => state.hover.reset(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // options
            MessageActions(item: item, isSent: true),
            // message
            tpw(),
            Flexible(
              child: AppButton(
                onPressed: null,
                padding: EdgeInsets.zero,
                borderRadius: borderRadiusTinySmall,
                hoverColor: transparent,
                color: Color.alphaBlend(styler.accentColor(3), black.withOpacity(0.01)),
                child: Container(
                  padding: paddingM(),
                  constraints: BoxConstraints(maxWidth: constraints.maxWidth * 0.7, minWidth: 100),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: isShortMessage ? CrossAxisAlignment.end : CrossAxisAlignment.end,
                    children: [
                      //
                      FileList(fileData: files),
                      if (files.isNotEmpty) mph(),
                      // message
                      AppText(size: 12, text: message, weight: isDark() ? FontWeight.w400 : FontWeight.w500),
                      if (isShortMessage) sph(),
                      // sent status Icon
                      ph(1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // time
                          AppText(size: 8, text: getMessageTime(item.sid), faded: true, weight: FontWeight.w500),
                          // status
                          tpw(),
                          AppIcon(
                            isPending ? Icons.refresh_rounded : Icons.done_rounded,
                            size: 10,
                            faded: true,
                          ),
                          //
                        ],
                      ),
                      //
                    ],
                  ),
                ),
              ),
            ),
            //
          ],
        ),
      );
    });
  }
}
