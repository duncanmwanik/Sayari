import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../_services/hive/local_storage_service.dart';
import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/others/icons.dart';

class ChatFormarttingButton extends StatelessWidget {
  const ChatFormarttingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: globalBox.listenable(keys: ['chatShowToolbar']),
        builder: (context, box, child) {
          bool show = box.get('chatShowToolbar', defaultValue: false);

          return AppButton(
            onPressed: () => box.put('chatShowToolbar', !show),
            noStyling: !show,
            tooltip: 'Formatting',
            isSquare: true,
            child: AppIcon(Icons.format_size, faded: true),
          );
        });
  }
}
