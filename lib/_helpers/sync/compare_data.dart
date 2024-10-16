import 'package:collection/collection.dart';

import '../../_providers/_providers.dart';
import '../../_services/hive/local_storage_service.dart';
import '../global.dart';

Map compareData({required String type}) {
  Map editedData = state.input.item.data;
  Map previousData = state.input.previousData;

  List editedKeys = [];

  // show(previousData);
  // show(editedData);

  //
  // new keys
  //
  editedData.forEach((key, value) {
    if (previousData.containsKey(key)) {
      if (previousData[key] != value || !DeepCollectionEquality().equals(previousData[key], value)) {
        editedKeys.add(key);
      }
    } else {
      editedKeys.add(key);
    }
  });

  //
  // deleted keys
  //
  previousData.forEach((key, value) async {
    if (!editedData.containsKey(key)) {
      editedData.remove(key);
      editedKeys.add('d/$key');
      if (key.toString().startsWith('fl')) {
        fileNamesBox.put(key, value);
      }
    }
  });

  return {'editedKeys': joinList(editedKeys), 'validatedData': editedData};
}
