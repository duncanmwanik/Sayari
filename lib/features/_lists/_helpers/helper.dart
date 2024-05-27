import '../../../_helpers/_common/global.dart';

Map getListItems(Map listData) {
  Map itemsMap = getNewMapFrom(listData);

  listData.forEach((key, value) {
    if (!key.toString().startsWith('i')) {
      itemsMap.remove(key);
    }
  });

  return itemsMap;
}
