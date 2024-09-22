// ignore_for_file: prefer_single_quotes

import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import '../../../../../_helpers/_common/global.dart';
import '../../../../../_providers/_providers.dart';
import '../../../../../_variables/features.dart';
import '../../../../_spaces/_helpers/common.dart';

List getChosenPeriods(List allPeriods, String currentLabel) {
  Box box = Hive.box('${liveSpace()}_${feature.finances}');
  List chosenPeriods = [];

  for (var periodId in allPeriods) {
    if (!periodId.toString().startsWith('ol')) {
      Map periodData = box.get(periodId);
      List labelList = getSplitList(periodData['l']);
      bool isDeleted = periodData['x'] != null ? periodData['x'].toString() == '1' : false;
      bool isArchived = periodData['a'] != null ? periodData['a'].toString() == '1' : false;

      if (currentLabel == 'Trash') {
        if (isDeleted) {
          chosenPeriods.insert(0, periodId);
        }
      } else if (currentLabel == 'Archive') {
        if (isArchived && !isDeleted) {
          chosenPeriods.insert(0, periodId);
        }
      } else {
        if (labelList.contains(currentLabel) && !isDeleted && !isArchived) {
          chosenPeriods.insert(0, periodId);
        }
      }
    }
  }

  return chosenPeriods;
}

Map getEntriesMap(List entryFilters) {
  Map entries = {};
  state.input.data.forEach((key, value) {
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
