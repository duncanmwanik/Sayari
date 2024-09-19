import '../../../_providers/_providers.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/others/toast.dart';

bool validateInput({required String type, bool validate = true}) {
  if (validate) {
    String message = '';
    String title = state.input.data['t'] ?? '';
    bool isCreate = state.input.itemId.isEmpty;

    if (type == feature.space.t) {
      if (title.isEmpty) {
        message = 'Enter space name';
      }
    }

    if (type == feature.calendar.t) {
      String startTime = state.input.data['s'] ?? '';

      if (title.isEmpty) {
        message = 'Enter session title';
      } else if (startTime.isEmpty) {
        message = 'Choose a start time';
      } else if (isCreate && state.input.selectedDates.isEmpty) {
        message = 'Select at least one date';
      }
    }

    if (type == feature.items.t) {
      if (isCreate && title.isEmpty && state.quill.controller.document.toPlainText().trim().isEmpty) {
        return false;
      }
    }

    if (type == feature.finances.t) {
      if (state.input.data.isEmpty) {
        return false;
      }
    }

    // show toast message

    if (message.isNotEmpty) {
      showToast(0, message);
      return false;
    }
  }

  return true;
}
