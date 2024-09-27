List<String> splitList(String? string, {String separator = '|', bool clearEmpties = true}) {
  try {
    if (string != null) {
      return clearEmpties ? string.split(separator).where((e) => e.isNotEmpty).toList() : string.split(separator);
    } else {
      return [];
    }
  } catch (e) {
    return [];
  }
}

String joinList(List list) {
  try {
    if (list.isNotEmpty) {
      return list.join('|');
    } else {
      return '';
    }
  } catch (e) {
    return '';
  }
}

String getUniqueId() => DateTime.now().millisecondsSinceEpoch.toString();
