import '../../../_helpers/_common/global.dart';
import '../../../_variables/features.dart';
import '../../_notes/_helpers/delete_item.dart';

Future<void> deleteCodeFile(String codeId) async {
  try {
    deleteItemForever(type: feature.code, itemId: codeId, files: {});
  } catch (e) {
    errorPrint('delete-code-file', e);
  }
}
