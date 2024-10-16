import 'package:intl/intl.dart';

import '../../../../../_providers/_providers.dart';

Map getEntriesMap(List entryFilters) {
  Map entries = {};
  state.input.item.data.forEach((key, value) {
    if (key.toString().length > 2 && entryFilters.contains(key.toString().substring(0, 2))) {
      entries[key] = value;
    }
  });

  return entries;
}

String formatThousands(double amount) {
  if (amount != 0) {
    return NumberFormat('#,##0.${"#" * 10}').format(amount);
  } else {
    return '0';
  }
}
