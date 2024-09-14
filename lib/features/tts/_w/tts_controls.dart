import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../__styling/spacing.dart';
import '../../../_widgets/buttons/buttons.dart';
import '../../../_widgets/menu/menu_item.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';
import '../_state/tts_provider.dart';

class TTSControls extends StatelessWidget {
  const TTSControls({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TTSProvider>(builder: (context, ttsProvider, child) {
      String selectedVoice = ttsProvider.selectedVoice;

      return Row(
        children: [
          //
          AppButton(
            tooltip: 'Change Voice',
            menuWidth: 200,
            menuItems: List.generate(
              4,
              (index) => MenuItem(
                label: 'Karen',
                trailing: ttsProvider.selectedVoice == selectedVoice ? Icons.done_rounded : null,
                onTap: () async => ttsProvider.updateSelectedVoice('voice'),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Selected Voice
                Flexible(child: AppText(text: 'Karen')),
                //
                spw(),
                //
                AppIcon(Icons.arrow_drop_down),
                //
              ],
            ),
          ),

          //
        ],
      );
    });
  }
}
