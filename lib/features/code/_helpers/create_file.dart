import '../../../_helpers/_common/global.dart';
import '../../../_helpers/_common/navigation.dart';
import '../../../_variables/features.dart';
import '../../_notes/_helpers/create_item.dart';
import '../../_notes/_helpers/quick_edit.dart';

Future<void> createCodeFile({String title = '', Map? codeMap}) async {
  try {
    hideKeyboard();
    popWhatsOnTop();
    print('object');
    createItem(
      type_: feature.code.t,
      data_: codeMap ?? {'t': title.isEmpty ? 'Untitled' : title},
    );
  } catch (e) {
    errorPrint('create-code-file', e);
  }
}

Future<void> editCodeFile({required String title, required String codeId}) async {
  try {
    hideKeyboard();
    popWhatsOnTop();
    editItemExtras(type: feature.code.t, itemId: codeId, key: 't', value: title.isEmpty ? 'Untitled' : title);
  } catch (e) {
    errorPrint('edit-code-file', e);
  }
}
