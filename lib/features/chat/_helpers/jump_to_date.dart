import 'package:flutter/material.dart';

import '../../../_helpers/extentions/dateTime.dart';
import '../../../_services/hive/store.dart';
import '../../../_variables/features.dart';
import '../w/var.dart';

Future<void> jumpToChatDate(DateTime? date) async {
  if (date != null && storage(feature.chat).containsKey(date.part())) {
    chatScrollController.scrollTo(
      index: storage(feature.chat).keys.toList().reversed.toList().indexOf(date.part()),
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOutCubic,
    );
  }
}
