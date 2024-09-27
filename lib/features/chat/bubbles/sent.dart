import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../__styling/helpers.dart';
import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_providers/_providers.dart';
import '../../../_services/hive/get_data.dart';
import '../../../_services/hive/local_storage_service.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';
import '../../calendar/_helpers/date_time/misc.dart';
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
        valueListenable: storage(feature.chat).listenable(keys: [id]),
        builder: (context, box, wdgt) {
          bool isPending = pendingBox.containsKey(id);
          Map files = getFiles(data);

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
                                AppText(size: 8, text: getMessageTime(id), faded: true, weight: FontWeight.w500),
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
