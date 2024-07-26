import 'package:flutter/material.dart';

import '../../../../_variables/features.dart';
import '../../../_providers/providers.dart';
import '../../../_widgets/layout/note_list.dart';
import '../../_sessions/session_view.dart';
import '../../chat/chat_view.dart';
import '../../code/code_view.dart';
import '../../explore/explore_view.dart';

Widget changeView(String type) {
  if (type == feature.sessions.t) {
    return SessionsView();
  } else if (type == feature.notes.t) {
    return ListOfItems(type: feature.notes.t);
  } else if (type == feature.notes.t) {
    return ListOfItems(type: feature.notes.t);
  } else if (type == feature.finances.t) {
    return ListOfItems(type: feature.finances.t);
  } else if (type == feature.explore.t) {
    return ExploreView();
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
