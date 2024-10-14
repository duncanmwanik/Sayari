import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../_services/hive/local_storage_service.dart';
import '../../../../_widgets/buttons/button.dart';
import '../../../../_widgets/others/icons.dart';

class QuickNoteFormartingButton extends StatelessWidget {
  const QuickNoteFormartingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: globalBox.listenable(keys: ['timelineShowToolbar']),
        builder: (context, box, child) {
          bool show = box.get('timelineShowToolbar', defaultValue: false);

          return AppButton(
            onPressed: () => box.put('timelineShowToolbar', !show),
            noStyling: !show,
            tooltip: 'Formatting',
            isSquare: true,
            child: AppIcon(Icons.format_size, faded: true),
          );
        });
  }
}
