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
import '../../_models/item.dart';
import '../../_services/hive/get_data.dart';
import '../../_variables/features.dart';
import '../../_widgets/others/empty_box.dart';
import '../calendar/_helpers/date_time/date_info.dart';
import '../calendar/state/datetime.dart';
import '../user/_helpers/set_user_data.dart';
import '_w/chat_date.dart';
import '_w/var.dart';
import 'bubbles/incoming.dart';
import 'bubbles/sent.dart';
import 'input_bar.dart';
import 'state/chat.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    String currentUserName = liveUserName();

    return Consumer2<ChatProvider, DateTimeProvider>(builder: (context, chat, dateTime, child) {
      return Stack(
        children: [
          // message list
          Align(
            child: ValueListenableBuilder(
                valueListenable: storage(feature.chat).listenable(),
                builder: (context, box, widget) {
                  Map chatData = box.toMap();
                  //
                  return chatData.isNotEmpty
                      ? SingleChildScrollView(
                          reverse: true,
                          controller: chatScrollController,
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
                              children: List.generate(chatData.length, (dateIndex) {
                                String date = chatData.keys.toList()[dateIndex];
                                Map dateChats = chatData[date];

                                List chatIds = chat.type == 'Pinned'
                                    ? dateChats.keys.where((key) => dateChats[key]['p'] == '1').toList()
                                    : chat.type == 'Starred'
                                        ? dateChats.keys.where((key) => dateChats[key]['stt'] == '1').toList()
                                        : dateChats.keys.toList();

                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: List.generate(chatIds.length, (index) {
                                    Item item = Item(
                                      parent: feature.chat,
                                      id: date,
                                      sid: chatIds[index],
                                      data: dateChats[chatIds[index]],
                                    );
                                    String userName = item.data['u'];
                                    bool isSent = userName == currentUserName;
                                    bool isPreviousSimilar =
                                        index == 0 ? false : (dateChats[chatIds[index - 1]]['u'] == currentUserName) == isSent;

                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ph(isPreviousSimilar ? 2 : 5), // spacing
                                        if (index == 0) ChatDate(date: DateInfo(date)), // date
                                        Align(
                                          alignment: isSent ? Alignment.centerRight : Alignment.centerLeft,
                                          child: isSent ? SentMessageBubble(item: item) : IncomingMessageBubble(item: item),
                                        ),
                                      ],
                                    );
                                  }),
                                );
                              }),
                            ),
                          ),
                        )
                      : EmptyBox(label: 'No messages');
                }),
          ),
          //
          MessageInputBar(),
          //
        ],
      );
    });
  }
}
