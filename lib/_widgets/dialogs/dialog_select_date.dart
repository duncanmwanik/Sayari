import '../../_helpers/navigation.dart';
import '../buttons/action.dart';
import '../others/sfcalendar.dart';
import '../others/text.dart';
import 'app_dialog.dart';

Future<List> showDateDialog({
  String title = 'Select one or more dates',
  String actionLabel = 'Done',
  String? initialDate,
  List initialDates = const [],
  bool isMultiple = false,
  bool showTitle = false,
  bool pop = false,
  Function(DateTime)? onSelect,
}) async {
  List selectedDates = [];

  await showAppDialog(
    maxWidth: 330,
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

  if (pop) popWhatsOnTop();
  return selectedDates;
}
