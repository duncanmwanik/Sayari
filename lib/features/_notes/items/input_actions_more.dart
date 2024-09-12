import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../__styling/variables.dart';
import '../../../_helpers/_common/navigation.dart';
import '../../../_providers/common/input.dart';
import '../../../_providers/providers.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/abcs/buttons/buttons.dart';
import '../../../_widgets/abcs/menu/menu_item.dart';
import '../../../_widgets/others/icons.dart';
import '../../files/_helpers/upload.dart';
import '../../share/_helpers/share.dart';
import '../../tts/_helpers/tts_service.dart';
import '../../tts/_state/tts_provider.dart';
import '../types/habits/habit_options.dart';

class MoreInputActions extends StatelessWidget {
  const MoreInputActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      bool isArchived = input.data['a'] == '1';

      return AppButton(
        tooltip: 'More',
        menuItems: [
          //
          if (input.isHabit()) HabitOptions(),
          //
          if (!input.isTask())
            MenuItem(
              label: 'Attach file',
              leading: Icons.file_present_outlined,
              onTap: () async => await getFilesToUpload(),
            ),
          //
          if (input.isNote())
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
          if (input.isNote() && !input.item.isShared())
            MenuItem(
              label: 'Share',
              leading: Icons.share_rounded,
              onTap: () {
                input.update(action: 'add', key: feature.share.lt, value: '1');
                shareItem(itemId: input.itemId, type: state.views.itemsView, title: input.data['t'] ?? 'Shared Item');
              },
            ),
          //
          if (input.item.exists())
            MenuItem(
              label: isArchived ? 'Unarchive' : 'Archive',
              leading: isArchived ? unarchiveIcon : archiveIcon,
              onTap: () {
                input.update(action: 'add', key: 'a', value: isArchived ? '0' : '1');
                if (!isArchived) closeBottomSheetIfOpen();
              },
            ),
          //
          if (input.item.exists())
            MenuItem(
              label: 'Move To Trash',
              leading: Icons.delete_outlined,
              onTap: () async {
                input.update(action: 'add', key: 'x', value: '1');
                closeBottomSheetIfOpen();
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
