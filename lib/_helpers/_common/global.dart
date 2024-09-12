import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';

import '../../_providers/providers.dart';
import '../../_widgets/others/toast.dart';
import '../../features/auth/_helpers/user_details_helper.dart';
import '../../features/user/_helpers/set_user_data.dart';

void errorPrint(String where, var e) {
  if (kDebugMode) {
    debugPrint('APP-ERROR: ($where) ^ $e ^');
  }
}

void printThis(var stuff) {
  if (kDebugMode) {
    log(stuff.toString());
  }
}

Map<String, dynamic> getJsonMap(Map data) {
  return Map<String, dynamic>.from(data);
}

String capitalizeStackTrace(String phrase) {
  return phrase.split('-').map((element) => '${element[0].toUpperCase()}${element.substring(1).toLowerCase()}').join(' ');
}

Future<void> doSomeFirstTimeWork() async {
  if (await isFirstTimer()) {
    showToast(1, 'Welcome ${liveUserName()}...', duration: 6000);
    // updateIsFirstTimeUser(false);
  }
}

Map getNewMapFrom(Map map) {
  return json.decode(json.encode(map));
}

List<String> getSplitList(String? string, {String separator = '|', bool clearEmpties = true}) {
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

String getJoinedList(List list) {
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

bool hasFlagList(String? flagList) {
  if (flagList != null && flagList.isNotEmpty) {
    return true;
  } else {
    return false;
  }
}

String getUniqueId() {
  return DateTime.now().millisecondsSinceEpoch.toString();
}

void clearItemSelection() {
  state.selection.clearAnyItemSelections();
}
