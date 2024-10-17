import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../_helpers/navigation.dart';
import '../../../_theme/breakpoints.dart';
import '../../../_theme/helpers.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/dialogs/dialog_select_date.dart';
import '../../../_widgets/others/text.dart';
import '../../calendar/_helpers/date_time/date_info.dart';
import '../../calendar/_helpers/date_time/jump_to_date.dart';
import '../_helpers/jump_to_date.dart';
import '../state/chat.dart';

class ChatDate extends StatelessWidget {
  const ChatDate({super.key, required this.date});

  final DateInfo date;

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(builder: (context, chat, child) {
      return AppButton(
        margin: padL('tb'),
        onPressed: () => showDateDialog(onSelect: (date) => jumpToChatDate(date), pop: true),
        menuItems: isPhone() ? null : jumpToDateMenu((date) => popWhatsOnTop(todo: () => jumpToChatDate(date))),
        color: isDark() ? Colors.black26 : Colors.black12,
        child: AppText(
          text: date.isToday()
              ? 'Today'
              : date.isYesterday()
                  ? 'Yesterday'
                  : date.formatFull(),
          size: tiny,
        ),
      );
    });
  }
}
