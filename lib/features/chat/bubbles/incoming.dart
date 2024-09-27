import 'package:flutter/material.dart';

import '../../../__styling/helpers.dart';
import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_models/item.dart';
import '../../../_providers/_providers.dart';
import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/others/images.dart';
import '../../../_widgets/others/text.dart';
import '../../calendar/_helpers/date_time/misc.dart';
import '../../files/file_list.dart';
import '../_w/actions.dart';

class IncomingMessageBubble extends StatelessWidget {
  const IncomingMessageBubble({super.key, required this.item});
  final Item item;

  @override
  Widget build(BuildContext context) {
    String userName = item.data['u'] ?? 'User';
    String message = item.data['n'];
    Map files = item.files();

    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      return MouseRegion(
        onEnter: (value) => state.hover.set(item.sid),
        onExit: (value) => state.hover.reset(),
        child: Row(
          children: [
            // user dp
            Align(
              alignment: Alignment.topLeft,
              child: AppButton(
                onPressed: () {},
                noStyling: true,
                isRound: true,
                child: AppImage('sayari.png', size: title),
              ),
            ),
            // message
            tpw(),
            Flexible(
              child: AppButton(
                hoverColor: transparent,
                padding: EdgeInsets.zero,
                borderRadius: borderRadiusTinySmall,
                color: Color.alphaBlend(styler.appColor(isImage() ? 1 : (isDark() ? 0.1 : 0.5)), styler.appColor(1)),
                child: Container(
                  padding: paddingM(),
                  constraints: BoxConstraints(maxWidth: constraints.maxWidth * 0.7, minWidth: 100),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // username
                      AppButton(
                        onPressed: () {},
                        noStyling: true,
                        padding: EdgeInsets.zero,
                        hoverColor: transparent,
                        child: AppText(
                          size: tiny,
                          text: userName,
                          weight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      // files
                      tph(),
                      FileList(fileData: files),
                      if (files.isNotEmpty) mph(),
                      // message
                      AppText(size: 12, text: message, weight: isDark() ? FontWeight.w400 : FontWeight.w500),
                      // time
                      ph(1),
                      Align(
                        alignment: Alignment.centerRight,
                        child: AppText(text: getMessageTime(item.sid), size: 8, faded: true, weight: FontWeight.w500),
                      ),
                      //
                    ],
                  ),
                ),
              ),
            ),
            // options
            tpw(),
            MessageActions(item: item),
            //
          ],
        ),
      );
    });
  }
}
