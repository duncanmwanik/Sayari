import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../../../__styling/spacing.dart';
import '../../../_providers/providers.dart';
import '../../../_services/hive/local_storage_service.dart';
import '../../../_widgets/abcs/buttons/buttons.dart';
import '../../../_widgets/others/icons.dart';
import '../../tts/_helpers/tts_service.dart';
import '../../tts/_state/tts_provider.dart';
import '../../user/_helpers/saved.dart';

class SharedActions extends StatelessWidget {
  const SharedActions({super.key, required this.itemId, required this.userId, required this.data});

  final String itemId;
  final String userId;
  final Map data;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: smallWidth(),
      runSpacing: smallWidth(),
      crossAxisAlignment: WrapCrossAlignment.end,
      alignment: WrapAlignment.end,
      children: [
        //
        ValueListenableBuilder(
            valueListenable: savedBox.listenable(),
            builder: (context, box, widget) {
              bool isSaved = box.containsKey(itemId);

              return AppButton(
                onPressed: () => saveItem(itemId, isSaved),
                tooltip: isSaved ? 'Remove from saved' : 'Save',
                noStyling: true,
                isSquare: true,
                child: AppIcon(isSaved ? Icons.bookmark_remove : Icons.bookmark_add_outlined, faded: true),
              );
            }),
        //
        Consumer<TTSProvider>(
          builder: (context, tts, child) => AppButton(
            onPressed: () {
              tts.updateTextToSpeak(state.quill.controller.document.toPlainText());
              tts.isPlaying ? ttsService.stopTTS() : ttsService.startTTS();
            },
            tooltip: tts.isPlaying ? 'Stop Narration' : 'Narrate',
            noStyling: !tts.isPlaying,
            isSquare: true,
            child: AppIcon(tts.isPlaying ? Icons.stop_rounded : Icons.play_arrow_rounded, faded: true),
          ),
        ),
        //
        AppButton(
          onPressed: () {},
          tooltip: 'Share',
          noStyling: true,
          isSquare: true,
          child: AppIcon(Icons.share, faded: true),
        ),
        //
      ],
    );
  }
}
