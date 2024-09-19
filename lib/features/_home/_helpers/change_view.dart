import 'package:flutter/material.dart';

import '../../../../_variables/features.dart';
import '../../../_providers/_providers.dart';
import '../../_notes/item_view.dart';
import '../../calendar/session_view.dart';
import '../../chat/chat_view.dart';
import '../../code/code_view.dart';

Widget changeView(String type) {
  if (type == feature.calendar.t) {
    return SessionsView();
  } else if (type == feature.items.t) {
    return ListOfItems();
  } else if (type == feature.chat.t) {
    return ChatView();
  } else if (type == feature.code.t) {
    return CodeView();
  } else {
    return SessionsView();
  }
}

void goToView(String type) {
  if (type != state.views.view) {
    state.scroll.updateShowAppbar(true);
    state.views.setHomeView(type);
    state.input.clearData();
    state.data.clear();
  }
}
