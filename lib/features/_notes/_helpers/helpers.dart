import 'dart:convert';

import '../../../_helpers/_common/global.dart';
import '../../../_helpers/_common/helpers.dart';
import '../../../_models/item.dart';
import '../../../_providers/providers.dart';
import '../../../_variables/features.dart';
import '../note_sheet.dart';

Future<void> prepareNoteForEdit(Item item, {bool isFull = false}) async {
  state.input.setInputData(isNw: false, typ: feature.items.t, itm: item, id: item.id, dta: item.data);
  await state.quill.reset(quills: item.data['n']);
  await showNoteBottomSheet(isMinimized: item.isTask());
}

Future<void> prepareNoteForCreation() async {
  String itemsView = state.views.itemView;
  String id = getUniqueId();
  state.quill.reset();

  if (itemsView == feature.notes.lt) {
    state.input.setInputData(typ: feature.items.t, dta: {feature.notes.lt: '1'});
  }
  //
  else if (itemsView == feature.tasks.lt) {
    state.input.setInputData(typ: feature.items.t, dta: {feature.tasks.lt: '1'});
  }
  //
  else if (itemsView == feature.finances.lt) {
    state.input.setInputData(typ: feature.items.t, dta: {feature.finances.lt: '1'});
  }
  //
  else if (itemsView == feature.habits.lt) {
    state.input.setInputData(typ: feature.items.t, dta: {feature.habits.lt: '1'});
  }
  //
  else if (itemsView == feature.links.lt) {
    state.input.setInputData(typ: feature.items.t, dta: {feature.links.lt: '1', feature.share.lt: '1'});
  }
  //
  else if (itemsView == feature.portfolios.lt) {
    state.input.setInputData(typ: feature.items.t, dta: {feature.portfolios.lt: '1', feature.share.lt: '1'});
  }
  //
  else if (itemsView == feature.bookings.lt) {
    state.input.setInputData(typ: feature.items.t, dta: {feature.bookings.lt: '1', feature.share.lt: '1'});
  }
  //
  else {
    return;
  }

  // for ordering
  state.input.update('o', getUniqueId());

  await showNoteBottomSheet(id: id, isMinimized: state.input.isTask());
}

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
