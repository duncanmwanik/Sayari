import 'dart:convert';

import '../../../_helpers/helpers.dart';
import '../../../_providers/_providers.dart';

String getQuills() => jsonEncode(state.quill.controller.document.toDelta().toJson());

String quillDescription() {
  return isShare()
      ? '...'
      : state.input.item.isBooking() || state.input.item.isLink()
          ? 'Type a short intro here...'
          : state.input.item.isLink()
              ? 'Type a short intro here...'
              : 'Start typing here...';
}
