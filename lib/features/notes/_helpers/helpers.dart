import 'dart:convert';

import '../../../_models/item.dart';
import '../../../_providers/providers.dart';
import '../../../_variables/features.dart';
import '../note_sheet.dart';

Future<void> prepareNoteForEdit(Item item, {bool isFull = false}) async {
  state.input.setInputData(typ: feature.notes.t, itm: item, id: item.id, dta: item.data);
  await state.quill.setQuillController(quills: item.data['n']);
  await showNoteBottomSheet(isFull: isFull);
}

Future<void> prepareNoteForCreation() async {
  state.input.setInputData(typ: feature.notes.t);
  state.quill.setQuillController();
  await showNoteBottomSheet();
}

String getQuills() {
  return jsonEncode(state.quill.quillcontroller.document.toDelta().toJson());
}
