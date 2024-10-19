import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../_models/item.dart';
import '../../_services/hive/store.dart';
import '../../_theme/breakpoints.dart';
import '../../_theme/spacing.dart';
import '../../_theme/variables.dart';
import '../../_variables/features.dart';
import '../../_widgets/others/empty_box.dart';
import '../calendar/_helpers/date_time/date_info.dart';
import '../user/_helpers/helpers.dart';
import 'input.dart';
import 'state/chat.dart';
import 'w/bubble_incoming.dart';
import 'w/bubble_sent.dart';
import 'w/chat_date.dart';
import 'w/var.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  @override
  void initState() {
    chatScrollController = ItemScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: storage(feature.chat).listenable(),
        builder: (context, box, child) {
          Map chatData = box.toMap();

          return Consumer<ChatProvider>(builder: (context, chat, child) {
            return Stack(
              children: [
                // message list
                chatData.isNotEmpty
                    ? ScrollablePositionedList.builder(
                        reverse: true,
                        shrinkWrap: true,
                        itemScrollController: chatScrollController,
                        padding: EdgeInsets.only(
                          top: 15,
                          bottom: 95,
                          left: kIsWeb ? 15 : 0,
                          right: kIsWeb ? 15 : 0,
                        ),
                        itemCount: chatData.length,
                        itemBuilder: (context, dateIndex) {
                          String date = chatData.keys.toList().reversed.toList()[dateIndex];
                          Map dateChats = chatData[date];

                          List chatIds = chat.type == 'Pinned'
                              ? dateChats.keys.where((key) => dateChats[key]['p'] == '1').toList()
                              : chat.type == 'Starred'
                                  ? dateChats.keys.where((key) => dateChats[key]['stt'] == '1').toList()
                                  : dateChats.keys.toList();

                          return Padding(
                            padding: isSmallPC() ? pad(p: 15.w, s: 'lr') : noPadding,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: List.generate(chatIds.length, (index) {
                                Item item = Item(
                                  parent: feature.chat,
                                  id: date,
                                  sid: chatIds[index],
                                  data: dateChats[chatIds[index]],
                                );
                                String userId = item.data['u'];
                                bool isSent = userId == liveUser();
                                bool isPreviousSimilar = index == 0 ? false : (dateChats[chatIds[index - 1]]['u'] == liveUser()) == isSent;

                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ph(isPreviousSimilar ? 2 : 5), // spacing
                                    if (index == 0) ChatDate(date: DateItem(date)), // date
                                    Align(
                                      alignment: isSent ? Alignment.centerRight : Alignment.centerLeft,
                                      child: isSent ? SentMessageBubble(item: item) : IncomingMessageBubble(item: item),
                                    ),
                                  ],
                                );
                              }),
                            ),
                          );
                        },
                      )
                    : EmptyBox(label: 'No messages'),
                // input bar
                ChatInput(),
                //
              ],
            );
          });
        });
  }
}
