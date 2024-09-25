import '../../../_helpers/_common/global.dart';
import '../../../_models/item.dart';
import '../../../_providers/_providers.dart';
import '../../../_variables/features.dart';
import '../note_sheet.dart';

Future<void> prepareNoteForEdit(Item item, {bool isFull = false}) async {
  state.input.setInputData(isNw: false, typ: feature.notes, itm: item, id: item.id, dta: item.data);
  await state.quill.reset(quills: item.data['n']);
  await showNoteBottomSheet(isMinimized: item.isTask());
}

Future<void> prepareNoteForCreation(String type) async {
  String id = getUniqueId();
  state.quill.reset();

  if (feature.isNote(type)) {
    state.input.setInputData(typ: feature.notes, dta: {feature.notes: '1'});
  }
  //
  else if (feature.isTask(type)) {
    state.input.setInputData(typ: feature.notes, dta: {feature.tasks: '1'});
  }
  //
  else if (type == feature.finances) {
    state.input.setInputData(typ: feature.notes, dta: {feature.finances: '1'});
  }
  //
  else if (type == feature.habits) {
    state.input.setInputData(typ: feature.notes, dta: {feature.habits: '1'});
  }
  //
  else if (type == feature.links) {
    state.input.setInputData(typ: feature.notes, dta: {feature.links: '1', feature.share: '1'});
  }
  //
  else if (type == feature.portfolios) {
    state.input.setInputData(typ: feature.notes, dta: {feature.portfolios: '1', feature.share: '1'});
  }
  //
  else if (type == feature.bookings) {
    state.input.setInputData(typ: feature.notes, dta: {feature.bookings: '1', feature.share: '1'});
  }
  //
  else {
    return;
  }

  // for ordering
  state.input.update('o', getUniqueId());
  await showNoteBottomSheet(id: id, isMinimized: state.input.isTask());
}
