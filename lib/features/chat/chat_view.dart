// ignore_for_file: unused_local_variable

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../__styling/breakpoints.dart';
import '../../__styling/spacing.dart';
import '../../_providers/common/misc.dart';
import '../../_providers/common/theme.dart';
import '../../_variables/features.dart';
import '../../_widgets/others/empty_box.dart';
import '../_spaces/_helpers/common.dart';
import '../user/_helpers/set_user_data.dart';
import 'bubbles/incoming.dart';
import 'bubbles/sent.dart';
import 'input_bar.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    String currentUserName = liveUserName();

    return Consumer2<ThemeProvider, ChatProvider>(builder: (context, theme, chat, child) {
      return Stack(
        children: [
          // message list
          Align(
            child: ValueListenableBuilder(
                valueListenable: Hive.box('${liveSpace()}_${feature.chat.t}').listenable(),
                builder: (context, box, widget) {
                  //
                  List chatIds = chat.type == 'Pinned'
                      ? box.keys.where((key) => box.get(key)['p'] == '1').toList()
                      : chat.type == 'Starred'
                          ? box.keys.where((key) => box.get(key)['stt'] == '1').toList()
                          : box.keys.toList();

                  return chatIds.isNotEmpty
                      ? SingleChildScrollView(
                          reverse: true,
                          padding: EdgeInsets.only(
                            top: 15,
                            bottom: 65,
                            left: kIsWeb ? 15 : 0,
                            right: kIsWeb ? 15 : 0,
                          ),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: isSmallPC() ? 55.w : 100.w),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: List.generate(chatIds.length, (index) {
                                String messageId = chatIds[index];
                                Map messageData = box.get(messageId);
                                String userName = messageData['u'];
                                bool isPinned = messageData['p'] == '1';
                                bool isSent = userName == currentUserName;
                                bool isPreviousSimilar =
                                    index == 0 ? false : (box.get(chatIds[index - 1])['u'] == currentUserName) == isSent;

                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ph(isPreviousSimilar ? 2 : 5), // spacing
                                    Align(
                                      alignment: isSent ? Alignment.centerRight : Alignment.centerLeft,
                                      child: isSent
                                          ? SentMessageBubble(id: messageId, data: messageData)
                                          : IncomingMessageBubble(id: messageId, data: messageData),
                                    ),
                                  ],
                                );
                              }),
                            ),
                          ),
                        )
                      : EmptyBox(label: 'No messages');
                }),
          ),

          MessageInputBar(),
          //
        ],
      );
    });
  }
}
