import 'package:hive/hive.dart';

import '../../../_helpers/_common/global.dart';
import '../../../_services/hive/get_data.dart';
import 'quick_edit.dart';

Future<void> orderItems({
  required String type,
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

    Box box = storage(type);

    // because the original ids list is reverse, we reverse the sign of the change(1) as well
    String newOrder = (int.parse(box.get(newItemId)['o']) + (oldIndex < newIndex ? -1 : 1)).toString();

    printThis('--------------------------------------------------------------------------');
    printThis('$oldIndex >> $newIndex ------> ${box.get(oldItemId)['t']} ${box.get(oldItemId)['o']}');
    printThis('$oldIndex >> $newIndex ------> ${box.get(newItemId)['t']} ${box.get(newItemId)['o']}');
    printThis(newOrder);

    await editItemExtras(type: type, itemId: oldItemId, key: 'o', value: newOrder);
  } catch (e) {
    errorPrint('order-items-$type-$oldItemId', e);
  }
}
