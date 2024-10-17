import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../_helpers/navigation.dart';
import '../../../_providers/_providers.dart';
import '../../../_providers/input.dart';
import '../../../_theme/variables.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/menu/menu_item.dart';
import '../../../_widgets/others/icons.dart';
import '../../files/_helpers/upload.dart';
import '../../reminders/reminder_menu.dart';
import '../../tags/menu.dart';
import '../../tts/_helpers/tts_service.dart';
import '../../tts/_state/tts_provider.dart';
import '../../user/_helpers/helpers.dart';
import '../types/habits/habit_options.dart';

class MoreInputActions extends StatelessWidget {
  const MoreInputActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      bool isArchived = input.item.data['a'] == '1';

      return AppButton(
        tooltip: 'More Actions',
        menuItems: [
          //
          MenuItem(
            label: 'Add Tags',
            leading: labelIcon,
            menuItems: tagsMenu(
              item: input.item,
              isSelection: true,
              onUpdate: (newTags) => input.update('l', newTags),
            ),
          ),
          //
          MenuItem(
            label: 'Add Reminder',
            leading: reminderIcon,
            menuItems: reminderMenu(
              reminder: input.item.reminder(),
              onSet: (newReminder) => input.update('r', newReminder),
              onRemove: () => input.remove('r'),
            ),
          ),
          //
          MenuItem(
            onTap: () async => await getFilesToUpload(),
            label: 'Attach Files',
            leading: reminderIcon,
          ),
          //
          if (input.item.isHabit()) HabitOptions(),
          //
          if (input.item.isNote())
            Consumer<TTSProvider>(
              builder: (context, tts, child) => MenuItem(
                label: tts.isPlaying ? 'Stop Narration' : 'Narrate',
                leading: tts.isPlaying ? Icons.stop_rounded : Icons.play_arrow_rounded,
                onTap: () {
                  tts.updateTextToSpeak(state.quill.controller.document.toPlainText());
                  tts.isPlaying ? ttsService.stopTTS() : ttsService.startTTS();
                },
              ),
            ),
          //
          if (input.item.isNote() && !input.item.isShared())
            MenuItem(
              label: 'Share',
              leading: Icons.share_rounded,
              onTap: () {
                input.update(feature.share, '1');
                input.update('u', liveUser());
              },
            ),
          //
          menuDivider(),
          //
          if (!input.item.isNew())
            MenuItem(
              label: isArchived ? 'Unarchive' : 'Archive',
              leading: isArchived ? unarchiveIcon : archiveIcon,
              onTap: () {
                input.update('a', isArchived ? '0' : '1');
                if (!isArchived) closeBottomSheetIfOpen();
              },
            ),
          //
          if (!input.item.isNew())
            MenuItem(
              label: 'Move To Trash',
              leading: Icons.delete_outlined,
              onTap: () async {
                input.update('x', '1');
                if (!isArchived) closeBottomSheetIfOpen();
              },
            ),
          //
        ],
        noStyling: true,
        isSquare: true,
        child: AppIcon(moreIcon, faded: true, size: 18),
      );
    });
  }
}
