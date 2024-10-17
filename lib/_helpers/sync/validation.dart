import '../../_models/item.dart';
import '../../_providers/_providers.dart';
import '../../_variables/features.dart';
import '../../_widgets/others/toast.dart';

bool validateInput(Item item, [bool isNew = false]) {
  String message = '';
  String title = state.input.item.data['t'] ?? '';
  bool hasTitle = title.isNotEmpty;

  if (item.type.isSpace()) {
    if (!hasTitle) {
      message = 'Enter space name';
    }
  }

  if (item.type.isCalendar()) {
    String startTime = state.input.item.data['s'] ?? '';

    if (!hasTitle) {
      message = 'Enter session title';
    } else if (startTime.isEmpty) {
      message = 'Choose a start time';
    } else if (isNew && state.input.selectedDates.isEmpty) {
      message = 'Select at least one date';
    }
  }

  if (item.type.isNote()) {
    if (isNew && !hasTitle && state.quill.controller.document.toPlainText().trim().isEmpty) {
      return false;
    }
  }

  if (item.type.isTask()) {
    if (isNew && !hasTitle && item.taskCount() == 0) {
      return false;
    }
  }

  if (item.type.isFinance()) {
    if (isNew && !hasTitle && state.input.item.data.isEmpty) {
      return false;
    }
  }

  // show toast message
  if (message.isNotEmpty) {
    showToast(0, message);
    return false;
  }

  return true;
}
