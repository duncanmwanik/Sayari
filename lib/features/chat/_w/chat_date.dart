import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../__styling/breakpoints.dart';
import '../../../__styling/helpers.dart';
import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/others/text.dart';
import '../../calendar/_helpers/date_time/date_info.dart';
import '../../calendar/_helpers/date_time/jump_to_date.dart';
import '../state/chat.dart';

class ChatDate extends StatelessWidget {
  const ChatDate({super.key, required this.date});

  final DateInfo date;

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(builder: (context, chat, child) {
      return Padding(
        padding: paddingL('tb'),
        child: AppButton(
          onPressed: () => jumpToDateDialog(),
          menuItems: isPhone() ? null : jumpToDateMenu(initialDate: date.date),
          color: isDark() ? Colors.black26 : Colors.black12,
          child: AppText(
            text: date.isToday()
                ? 'Today'
                : date.isYesterday()
                    ? 'Yesterday'
                    : date.formatFull(),
            size: tiny,
          ),
        ),
      );
    });
  }
}
