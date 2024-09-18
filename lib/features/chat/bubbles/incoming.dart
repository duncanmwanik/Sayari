import 'package:flutter/material.dart';

import '../../../__styling/helpers.dart';
import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_helpers/date_time/misc.dart';
import '../../../_providers/providers.dart';
import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/others/images.dart';
import '../../../_widgets/others/text.dart';
import '../../files/_helpers/helper.dart';
import '../../files/file_list.dart';
import '../_w/options.dart';
import '../_w/options_btn.dart';

class IncomingMessageBubble extends StatelessWidget {
  const IncomingMessageBubble({super.key, required this.id, required this.data});
  final String id;
  final Map data;

  @override
  Widget build(BuildContext context) {
    String userName = data['u'] ?? 'User';
    String message = data['n'];
    Map files = getFiles(data);

    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      return MouseRegion(
        onEnter: (value) => state.hover.set(id),
        onExit: (value) => state.hover.reset(),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // user dp
            AppButton(
              onPressed: () {},
              noStyling: true,
              isRound: true,
              child: AppImage('sayari.png', size: title),
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
                      AppText(size: 12, text: message, weight: isDark() ? FontWeight.w400 : FontWeight.w600),
                      // time
                      ph(1),
                      Align(
                        alignment: Alignment.centerRight,
                        child: AppText(text: getMessageTime(id), size: 8, faded: true, weight: FontWeight.w500),
                      ),
                      //
                    ],
                  ),
                ),
              ),
            ),
            // options
            tpw(),
            MessageOptions(id: id, menuItems: messageMenu(id, data)),
            //
          ],
        ),
      );
    });
  }
}
