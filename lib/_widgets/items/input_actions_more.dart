import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../__styling/variables.dart';
import '../../_helpers/_common/navigation.dart';
import '../../_providers/common/input.dart';
import '../../_providers/providers.dart';
import '../../_variables/features.dart';
import '../../features/_notes/_helpers/share.dart';
import '../../features/_notes/feat/habits/habit_options.dart';
import '../../features/_notes/feat/tasks/task_options.dart';
import '../../features/files/_helpers/upload.dart';
import '../../features/tts/_helpers/tts_service.dart';
import '../../features/tts/_state/tts_provider.dart';
import '../abcs/buttons/buttons.dart';
import '../abcs/menu/menu_item.dart';
import '../others/icons.dart';

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
          if (input.isTask()) TaskOptions(),
          //
          if (input.isHabit()) HabitOptions(),
          //
          MenuItem(
            label: 'Attach file',
            iconData: Icons.file_present_outlined,
            onTap: () async => await getFilesToUpload(),
          ),
          //
          if (feature.isNote(input.item.type))
            Consumer<TTSProvider>(
              builder: (context, tts, child) => MenuItem(
                label: tts.isPlaying ? 'Stop Narration' : 'Narrate',
                iconData: tts.isPlaying ? Icons.stop_rounded : Icons.play_arrow_rounded,
                onTap: () {
                  tts.updateTextToSpeak(state.quill.quillcontroller.document.toPlainText());
                  tts.isPlaying ? ttsService.stopTTS() : ttsService.startTTS();
                },
              ),
            ),
          //
          if (!input.item.isShared())
            MenuItem(
              label: 'Share',
              iconData: Icons.share_rounded,
              onTap: () {
                input.update(action: 'add', key: feature.share.lt, value: '1');
                shareItem(type: feature.share.t, itemId: input.itemId);
              },
            ),
          //
          if (input.item.exists())
            MenuItem(
              label: isArchived ? 'Unarchive' : 'Archive',
              iconData: isArchived ? unarchiveIcon : archiveIcon,
              onTap: () {
                input.update(action: 'add', key: 'a', value: isArchived ? '0' : '1');
                if (!isArchived) closeBottomSheetIfOpen();
              },
            ),
          //
          if (input.item.exists())
            MenuItem(
              label: 'Move To Trash',
              iconData: Icons.delete_outlined,
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
