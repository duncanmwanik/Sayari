import '../../../_helpers/extentions/dateTime.dart';
import '../../../_models/item.dart';
import '../../../_providers/_providers.dart';
import '../../../_variables/features.dart';
import '../new_session/session_dialog.dart';
import 'date_time/misc.dart';

Future<void> createSession({String? date, int? hour}) async {
  state.input.set(Item(
    parent: feature.calendar,
    type: feature.calendar,
    data: {
      'y': 'Session',
      'c': '0',
      'r': '30.m',
      's': now().toString(),
      'e': '${now().part()} 23:59:00',
    },
  ));

  state.input.updateSelectedDates('clear');
  if (date != null) state.input.updateSelectedDates('add', date: date);
  showSessionBottomSheet();
}

Future<void> editSession(Item item) async {
  state.input.set(item);
  showSessionBottomSheet();
}
