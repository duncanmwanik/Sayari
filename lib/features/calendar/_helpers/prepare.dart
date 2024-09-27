import '../../../_models/item.dart';
import '../../../_providers/_providers.dart';
import '../../../_variables/features.dart';
import '../new_session/session_dialog.dart';

Future<void> createSession({String? date, int? hour}) async {
  state.input.set(Item(
    parent: feature.calendar,
    type: feature.calendar,
    data: {'y': 'Session', 'c': '0', 'r': '30.m', 's': '${hour ?? '8'}:0'},
  ));

  state.input.updateSelectedDates('clear');
  if (date != null) state.input.updateSelectedDates('add', date: date);
  showSessionBottomSheet();
}

Future<void> editSession(Item item) async {
  state.input.set(item);
  showSessionBottomSheet();
}
