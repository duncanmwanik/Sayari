import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../__styling/variables.dart';
import '../../_helpers/user/set_user_data.dart';
import '../../_providers/common/theme.dart';
import '../../_variables/features.dart';
import '../../_widgets/others/empty_box.dart';
import '../_tables/_helpers/common.dart';
import '_w/incoming_bubble.dart';
import '_w/sent_bubble.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    String currentUserName = liveUserName();

    return Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
      return ValueListenableBuilder(
          valueListenable: Hive.box('${liveTable()}_${feature.chat.t}').listenable(),
          builder: (context, box, widget) {
            //
            if (box.keys.toList().isNotEmpty) {
              List chatIds = box.keys.toList();

              return SizedBox(
                width: webMaxWidth,
                height: 100.h,
                child: SingleChildScrollView(
                  reverse: true,
                  padding: EdgeInsets.only(
                    bottom: 55,
                    left: kIsWeb ? 15 : 0,
                    right: kIsWeb ? 15 : 0,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(chatIds.length, (index) {
                      String messageId = chatIds[index];
                      Map messageData = box.get(messageId);
                      String userName = messageData['u'] ?? 'User';

                      return (userName == currentUserName)
                          ? SentMessageBubble(
                              messageId: messageId,
                              messageData: messageData,
                            )
                          : IncomingMessageBubble(
                              messageId: messageId,
                              messageData: messageData,
                            );
                    }),
                  ),
                ),
              );
            } else {
              return EmptyBox(label: 'No new messages', icon: chatUnselectedIcon);
            }
          });
    });
  }
}
