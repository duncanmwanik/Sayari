import '../../../_providers/providers.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/others/toast.dart';

bool validateInput({required String type, bool validate = true}) {
  if (validate) {
    String message = '';
    String title = state.input.data['t'] ?? '';
    bool isCreate = state.input.itemId.isEmpty;

    if (type == feature.table.t) {
      if (title.isEmpty) {
        message = 'Enter table name';
      }
    }

    if (type == feature.sessions.t) {
      String startTime = state.input.data['s'] ?? '';

      if (title.isEmpty) {
        message = 'Enter session title';
      } else if (startTime.isEmpty) {
        message = 'Choose a start time';
      } else if (isCreate && state.input.selectedDates.isEmpty) {
        message = 'Select at least one date';
      }
    }

    if (type == feature.notes.t) {
      if (title.isEmpty) {
        message = 'Enter list title';
      }
    }

    if (type == feature.notes.t) {
      if (isCreate && title.isEmpty && state.quill.quillcontroller.document.toPlainText().trim().isEmpty) {
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
