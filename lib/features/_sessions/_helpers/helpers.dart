import '../../../_helpers/_common/global.dart';
import '../../../_providers/providers.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/abcs/dialogs_sheets/confirmation_dialog.dart';
import '../new_session/session_sheet.dart';

Future<void> prepareSessionCreation({String? date, int? hour}) async {
  state.input.resetSessionData();
  if (date != null) {
    state.input.updateSelectedDates('add', date: date);
  }
  if (hour != null) {
    state.input.update(action: 'add', key: 's', value: '$hour:0');
  }
  showSessionBottomSheet();
}

Future<void> prepareSessionEditing(String sessionDate, String sessionId, Map sessionData) async {
  state.input.resetSessionData();
  state.input.setInputData(isNw: false, typ: feature.sessions.t, id: sessionDate, sId: sessionId, dta: sessionData);
  showSessionBottomSheet();
}

void clearAllSelectedDates() async {
  await showConfirmationDialog(
    title: 'Clear all selected dates?',
    yeslabel: 'Clear',
    content: "You can delete individual dates by tapping 'X' on them.",
    onAccept: () => state.input.updateSelectedDates('clear'),
  );
}

Map getHourMap(Map source, int hour) {
  source.removeWhere((key, value) => value['s'].toString().split(':')[0] != hour.toString());
  return source;
}

void removeDuplicateReminders(String type, Map data) {
  if (type == feature.sessions.t && data['r'] != null) {
    data['r'] = getJoinedList(getSplitList(data['r']).toSet().toList());
  }
}
