import 'dart:convert';

import '../../../_helpers/_common/global.dart';
import '../../../_helpers/_common/helpers.dart';
import '../../../_models/item.dart';
import '../../../_providers/_providers.dart';
import '../../../_variables/features.dart';
import '../note_sheet.dart';

Future<void> prepareNoteForEdit(Item item, {bool isFull = false}) async {
  state.input.setInputData(isNw: false, typ: feature.items, itm: item, id: item.id, dta: item.data);
  await state.quill.reset(quills: item.data['n']);
  await showNoteBottomSheet(isMinimized: item.isTask());
}

Future<void> prepareNoteForCreation() async {
  String itemsView = state.views.itemView;
  String id = getUniqueId();
  state.quill.reset();

  if (itemsView == feature.notes) {
    state.input.setInputData(typ: feature.items, dta: {feature.notes: '1'});
  }
  //
  else if (itemsView == feature.tasks) {
    state.input.setInputData(typ: feature.items, dta: {feature.tasks: '1'});
  }
  //
  else if (itemsView == feature.finances) {
    state.input.setInputData(typ: feature.items, dta: {feature.finances: '1'});
  }
  //
  else if (itemsView == feature.habits) {
    state.input.setInputData(typ: feature.items, dta: {feature.habits: '1'});
  }
  //
  else if (itemsView == feature.links) {
    state.input.setInputData(typ: feature.items, dta: {feature.links: '1', feature.share: '1'});
  }
  //
  else if (itemsView == feature.portfolios) {
    state.input.setInputData(typ: feature.items, dta: {feature.portfolios: '1', feature.share: '1'});
  }
  //
  else if (itemsView == feature.bookings) {
    state.input.setInputData(typ: feature.items, dta: {feature.bookings: '1', feature.share: '1'});
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
