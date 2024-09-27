import 'package:flutter/material.dart';

import '../../../../_variables/features.dart';
import '../../../_providers/_providers.dart';
import '../../_notes/notes_view.dart';
import '../../calendar/session_view.dart';
import '../../chat/chat_view.dart';

Widget changeView(String type) {
  if (type == feature.calendar) {
    return SessionsView();
  } else if (type == feature.notes) {
    return ListOfItems(type: feature.notes);
  } else if (type == feature.tasks) {
    return ListOfItems(type: feature.tasks);
  } else if (type == feature.chat) {
    return ChatView();
  } else {
    return SessionsView();
  }
}

void goToView(String type) {
  if (type != state.views.view) {
    state.views.setView(type);
    state.input.clear();
    state.data.clear();
  }
}
