import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../_widgets/abcs/buttons/buttons.dart';
import '../../../_widgets/others/icons.dart';
import '../_helpers/tts_service.dart';
import '../_state/tts_provider.dart';

class TTSButton extends StatelessWidget {
  const TTSButton({super.key, this.text});

  final String? text;

  @override
  Widget build(BuildContext context) {
    return Consumer<TTSProvider>(builder: (context, tts, child) {
      return AppButton(
        onPressed: () {
          if (text != null) {
            tts.updateTextToSpeak(text ?? '');
          }
          tts.isPlaying ? ttsService.stopTTS() : ttsService.startTTS();
        },
        noStyling: true,
        isSquare: true,
        tooltip: 'Speak',
        child: AppIcon(tts.isPlaying ? Icons.stop_rounded : Icons.play_arrow_rounded, faded: true, size: 18),
      );
    });
  }
}
