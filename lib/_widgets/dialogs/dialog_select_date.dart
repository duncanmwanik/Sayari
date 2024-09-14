import 'package:flutter/material.dart';

import '../../_helpers/_common/navigation.dart';
import '../others/sfcalendar.dart';
import '../others/text.dart';
import 'app_dialog.dart';
import 'dialog_buttons.dart';

Future<List> showSelectDateDialog({
  String title = 'Select one or more dates',
  String actionLabel = 'Done',
  String? initialDate,
  List initialDates = const [],
  bool isMultiple = false,
  bool showTitle = false,
  EdgeInsets? padding,
  Function(DateTime)? onSelect,
}) async {
  List selectedDates = [];

  await showAppDialog(
    maxWidth: 330,
    padding: padding,
    crossAxisAlignment: CrossAxisAlignment.center,
    //
    title: showTitle ? AppText(text: title) : null,
    //
    content: SfCalendar(
      initialDate: initialDate ?? '',
      initialDates: initialDates,
      isMultiple: isMultiple,
      selectedDates: selectedDates,
      onSelect: onSelect,
    ),
    //
    actions: onSelect == null
        ? [
            ActionButton(
                isCancel: true,
                onPressed: () {
                  selectedDates.clear();
                  popWhatsOnTop();
                }),
            ActionButton(label: actionLabel, onPressed: (() => popWhatsOnTop())),
          ]
        : null,
    //
  );

  return selectedDates;
}
