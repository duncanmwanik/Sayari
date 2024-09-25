import 'dart:convert';

import '../../../_helpers/_common/helpers.dart';
import '../../../_providers/_providers.dart';

String getQuills() => jsonEncode(state.quill.controller.document.toDelta().toJson());

String quillDescription() {
  return isShare()
      ? '...'
      : state.input.isBooking() || state.input.isLink()
          ? 'Type a short intro here...'
          : state.input.isLink()
              ? 'Type a short intro here...'
              : 'Start typing here...';
}
