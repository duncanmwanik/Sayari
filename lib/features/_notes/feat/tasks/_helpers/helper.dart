Map getListItems(Map listData) {
  Map itemsMap = {...listData};

  listData.forEach((key, value) {
    if (!key.toString().startsWith('i')) {
      itemsMap.remove(key);
    }
  });

  return itemsMap;
}
