import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../__styling/helpers.dart';
import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_helpers/date_time/misc.dart';
import '../../../_providers/providers.dart';
import '../../../_services/hive/local_storage_service.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/abcs/buttons/buttons.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';
import '../../_spaces/_helpers/common.dart';
import '../../files/_helpers/helper.dart';
import '../../files/file_list.dart';
import '../_w/options.dart';
import '../_w/options_btn.dart';

class SentMessageBubble extends StatelessWidget {
  const SentMessageBubble({super.key, required this.id, required this.data});
  final String id;
  final Map data;

  @override
  Widget build(BuildContext context) {
    String message = data['n'];
    bool isShortMessage = message.length < 20;

    return ValueListenableBuilder(
        valueListenable: Hive.box('${liveSpace()}_${feature.chat.t}').listenable(keys: [id]),
        builder: (context, box, wdgt) {
          bool isPending = pendingBox.containsKey(id);

          return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
            return MouseRegion(
              onEnter: (value) => state.hover.set(id),
              onExit: (value) => state.hover.reset(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // options
                  MessageOptions(id: id, menuItems: messageMenu(id, data), isSent: true),
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
                        padding: itemPaddingMedium(),
                        constraints: BoxConstraints(maxWidth: constraints.maxWidth * 0.6, minWidth: 100),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: isShortMessage ? CrossAxisAlignment.end : CrossAxisAlignment.end,
                          children: [
                            //
                            FileList(fileData: getFiles(data)),
                            // message
                            AppText(size: 12, text: message, fontWeight: isDark() ? FontWeight.w400 : FontWeight.w600),
                            if (isShortMessage) sph(),
                            // sent status Icon
                            ph(1),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // time
                                AppText(size: 8, text: getMessageTime(id), faded: true, fontWeight: FontWeight.w500),
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
        });
  }
}
