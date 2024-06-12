// ignore_for_file: unused_local_variable

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../../__styling/spacing.dart';
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

              return SingleChildScrollView(
                reverse: true,
                padding: EdgeInsets.only(
                  top: 30,
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
                    // bool isSent = userName == currentUserName;
                    bool isSent = Random().nextInt(3) == 1;

                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        //
                        Align(
                          alignment: isSent ? Alignment.centerRight : Alignment.centerLeft,
                          child: isSent
                              ? SentMessageBubble(messageId: messageId, messageData: messageData)
                              : IncomingMessageBubble(messageId: messageId, messageData: messageData),
                        ),
                        tph(),
                        //
                      ],
                    );
                  }),
                ),
              );
            } else {
              return EmptyBox(label: 'No new messages', icon: chatUnselectedIcon);
            }
          });
    });
  }
}
