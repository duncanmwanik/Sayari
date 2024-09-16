import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_providers/common/views.dart';
import '../../../_services/hive/local_storage_service.dart';
import '../../../_widgets/buttons/buttons.dart';
import '../../../_widgets/others/text.dart';

class Option extends StatelessWidget {
  const Option({super.key, required this.label, required this.type});

  final String label;
  final String type;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: globalBox.listenable(keys: ['showNoteOption_$type']),
        builder: (context, box, widget) {
          //
          return Visibility(
            visible: box.get('showNoteOption_$type', defaultValue: true),
            child: Consumer<ViewsProvider>(builder: (context, views, child) {
              bool isSelectedView = views.itemsView == type;

              return Padding(
                padding: paddingS('r'),
                child: AppButton(
                  onPressed: isSelectedView ? null : () => views.setNotesView(type),
                  color: isSelectedView ? styler.accentColor(1.8) : transparent,
                  borderRadius: borderRadiusCrazy,
                  smallVerticalPadding: true,
                  child: AppText(text: label),
                ),
              );
            }),
          );
        });
  }
}
