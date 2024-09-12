import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../__styling/variables.dart';
import '../../../_services/hive/local_storage_service.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/abcs/buttons/buttons.dart';
import '../../../_widgets/abcs/menu/menu_item.dart';

class OptionsToggler extends StatelessWidget {
  const OptionsToggler({super.key});

  @override
  Widget build(BuildContext context) {
    return AppButton(
      menuItems: [
        OptionToggle(label: 'Notes', type: feature.notes.lt, isDefault: true),
        OptionToggle(label: 'Tasks', type: feature.tasks.lt),
        OptionToggle(label: 'Finances', type: feature.finances.lt),
        OptionToggle(label: 'Habits', type: feature.habits.lt),
        OptionToggle(label: 'Links', type: feature.links.lt),
        // OptionToggle(label: 'Portfolio', type: feature.portfolios.lt),
        // OptionToggle(label: 'Forms', type: feature.forms.lt),
        OptionToggle(label: 'Bookings', type: feature.bookings.lt),
      ],
      tooltip: 'Options',
      isRound: true,
      noStyling: true,
      leading: moreIcon,
    );
  }
}

class OptionToggle extends StatelessWidget {
  const OptionToggle({
    super.key,
    required this.label,
    required this.type,
    this.isDefault = false,
  });

  final String label;
  final String type;
  final bool isDefault;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: globalBox.listenable(keys: ['showNoteOption_$type']),
        builder: (context, box, widget) {
          bool show = box.get('showNoteOption_$type', defaultValue: true);

          return MenuItem(
            onTap: isDefault ? null : () => box.put('showNoteOption_$type', !show),
            label: label,
            trailing: show ? Icons.push_pin : Icons.push_pin_outlined,
            trailingColor: isDefault
                ? styler.appColor(3)
                : show
                    ? styler.accent
                    : null,
            trailingSize: 14,
            pop: false,
          );
        });
  }
}
