import 'dart:convert';

import '../../../_helpers/_common/global.dart';
import '../../../_helpers/items/share.dart';
import '../../../_models/item.dart';
import '../../../_providers/providers.dart';
import '../../../_variables/features.dart';
import '../../forms/_helpers/helpers.dart';
import '../note_sheet.dart';

Future<void> prepareNoteForEdit(Item item, {bool isFull = false}) async {
  state.input.setInputData(isNw: false, typ: feature.notes.t, itm: item, id: item.id, dta: item.data);
  await state.quill.setQuillController(quills: item.data['n']);
  await showNoteBottomSheet();
}

Future<void> prepareNoteForCreation() async {
  String noteView = state.views.noteView;
  String id = getUniqueId();
  state.quill.setQuillController();

  if (noteView == feature.notes.lt) {
    state.input.setInputData(typ: feature.notes.t, dta: {feature.notes.lt: '1'});
  }
  //
  else if (noteView == feature.finances.lt) {
    state.input.setInputData(typ: feature.notes.t, dta: {feature.finances.lt: '1'});
  }
  //
  else if (noteView == feature.habits.lt) {
    state.input.setInputData(typ: feature.notes.t, dta: {feature.habits.lt: '1'});
  }
  //
  else if (noteView == feature.links.lt) {
    state.input.setInputData(typ: feature.notes.t, dta: {feature.links.lt: '1'});
    shareItem(type: feature.links.t, itemId: id);
  }
  //
  else if (noteView == feature.portfolios.lt) {
    state.input.setInputData(typ: feature.notes.t, dta: {feature.portfolios.lt: '1'});
    shareItem(type: feature.portfolios.t, itemId: id);
  }
  //
  else if (noteView == feature.forms.lt) {
    state.input.setInputData(typ: feature.notes.t, dta: {feature.forms.lt: '1'});
    addForm();
    shareItem(type: feature.forms.t, itemId: id);
  }
  //
  else if (noteView == feature.bookings.lt) {
    state.input.setInputData(typ: feature.notes.t, dta: {feature.bookings.lt: '1'});
    shareItem(type: feature.bookings.t, itemId: id);
  }
  //
  else {
    state.input.setInputData(typ: feature.notes.t, dta: {feature.notes.lt: '1'});
  }

  await showNoteBottomSheet(id: id);
}

String getQuills() {
  return jsonEncode(state.quill.quillcontroller.document.toDelta().toJson());
}
