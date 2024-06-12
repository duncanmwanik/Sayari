import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_providers/common/views.dart';
import '../../../_services/hive/local_storage_service.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/abcs/buttons/buttons.dart';
import '../../../_widgets/abcs/menu/menu_item.dart';
import '../../../_widgets/others/text.dart';
import '../../_home/_helpers/change_view.dart';

class NoteOptions extends StatelessWidget {
  const NoteOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ViewsProvider>(builder: (context, views, child) {
      return Visibility(
        visible: views.isNotes(),
        child: Padding(
          padding: itemPadding(left: true, right: true),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                //
                Option(label: 'Notes', type: feature.notes.lt),
                Option(label: 'Tasks', type: feature.tasks.lt),
                Option(label: 'Finances', type: feature.finances.lt),
                Option(label: 'Habits', type: feature.habits.lt),
                Option(label: 'Links', type: feature.links.lt),
                Option(label: 'Portfolio', type: feature.portfolios.lt),
                Option(label: 'Forms', type: feature.forms.lt),
                Option(label: 'Bookings', type: feature.bookings.lt),
                OptionsToggler(),
                lpw(),
                //
              ],
            ),
          ),
        ),
      );
    });
  }
}

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
              bool isSelectedView = views.noteView == type;

              return Padding(
                padding: itemPadding(right: true),
                child: AppButton(
                  onPressed: isSelectedView
                      ? null
                      : () {
                          if (type == feature.notes.lt) {
                            goToView(feature.notes.t);
                          }
                          views.setNotesView(type);
                        },
                  noStyling: true,
                  borderRadius: borderRadiusCrazy,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppText(text: label),
                      Container(
                        width: 15,
                        height: 3,
                        decoration: BoxDecoration(
                          color: isSelectedView ? styler.accent : null,
                          borderRadius: BorderRadius.circular(borderRadiusCrazy),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),
          );
        });
  }
}

class OptionsToggler extends StatelessWidget {
  const OptionsToggler({super.key});

  @override
  Widget build(BuildContext context) {
    return AppButton(
      menuItems: [
        OptionToggle(label: 'Notes', type: feature.notes.lt, isDefault: true),
        OptionToggle(label: 'Tasks', type: feature.tasks.lt, isDefault: true),
        OptionToggle(label: 'Finances', type: feature.finances.lt),
        OptionToggle(label: 'Habits', type: feature.habits.lt),
        OptionToggle(label: 'Links', type: feature.links.lt),
        OptionToggle(label: 'Portfolio', type: feature.portfolios.lt),
        OptionToggle(label: 'Forms', type: feature.forms.lt),
        OptionToggle(label: 'Bookings', type: feature.bookings.lt),
      ],
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
