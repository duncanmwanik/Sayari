import 'package:hive/hive.dart';

import '../../../_helpers/debug.dart';
import '../../../_helpers/sync/quick_edit.dart';
import '../../../_services/hive/store.dart';
import '../../../_variables/features.dart';

Future<void> orderItems({
  required String oldItemId,
  required String newItemId,
  required int itemsLength,
  required int oldIndex,
  required int newIndex,
}) async {
  try {
    Box box = storage(feature.notes);
    // because the original ids list is reverse, we reverse the sign of the change(1) as well
    String newOrder = (int.parse(box.get(newItemId)['o']) + (oldIndex < newIndex ? -1 : 1)).toString();
    show('New item order: $oldIndex >> $newIndex ------> ${box.get(oldItemId)['o']} >> ${box.get(newItemId)['o']} >>> $newOrder');
    await quickEdit(parent: feature.notes, id: oldItemId, key: 'o', value: newOrder);
  } catch (e) {
    logError('orderItems-$oldItemId', e);
  }
}

Future<void> orderSubItem({
  String? parent,
  required String itemId,
  required String oldItemId,
  required String newItemId,
  required int itemsLength,
  required int oldIndex,
  required int newIndex,
  bool applyIndexFix = false,
}) async {
  try {
    if (applyIndexFix) {
      if (newIndex > itemsLength) newIndex = itemsLength;
      if (oldIndex < newIndex) newIndex--;
    }

    Box box = storage(parent ?? feature.notes);
    String oldItemOrder = box.get(itemId)[oldItemId]['o'];
    String newItemOrder = box.get(itemId)[newItemId]['o'];
    // because the original ids list is reverse, we reverse the sign of the change(1) as well
    String newOrder = (int.parse(newItemOrder) + (oldIndex < newIndex ? -1 : 1)).toString();
    show('${box.get(itemId)[oldItemId]['t']} >> ${box.get(itemId)[newItemId]['t']}');
    show('New subitem order: $oldIndex >> $newIndex --- $oldItemOrder >> $newItemOrder : $newOrder');
    await quickEdit(parent: parent ?? feature.notes, id: itemId, sid: oldItemId, key: 'o', value: newOrder);
  } catch (e) {
    logError('orderSubItem-$itemId-$oldItemId', e);
  }
}
