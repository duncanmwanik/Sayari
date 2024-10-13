//

Map getSubItems(Map data) {
  Map map = {...data};

  data.forEach((key, value) {
    if (!key.toString().startsWith('i')) {
      map.remove(key);
    }
  });

  return map;
}
