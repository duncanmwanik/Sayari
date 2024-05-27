import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../__styling/variables.dart';
import '../../../_variables/strings.dart';
import '../../../_widgets/others/forms/input.dart';
import '../_state/tts_provider.dart';

class TTSInput extends StatelessWidget {
  const TTSInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TTSProvider>(builder: (context, ttsProvider, child) {
      return DataInput(
        onChanged: (value) => ttsProvider.updateTextToSpeak(value.trim()),
        hintText: 'Type or paste text from clipboard...',
        initialValue: ttsProvider.textToSpeak,
        focusNode: noteTextFocusNode,
        fontSize: normal,
        maxLines: null,
        filled: false,
      );
    });
  }
}
