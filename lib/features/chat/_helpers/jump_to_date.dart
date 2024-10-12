import 'package:flutter/material.dart';

import '../../../_services/hive/get_data.dart';
import '../../../_variables/features.dart';
import '../../calendar/_helpers/date_time/misc.dart';
import '../w/var.dart';

Future<void> jumpToChatDate(DateTime? date) async {
  if (date != null && storage(feature.chat).containsKey(getDatePart(date))) {
    chatScrollController.scrollTo(
      index: storage(feature.chat).keys.toList().reversed.toList().indexOf(getDatePart(date)),
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOutCubic,
    );
  }
}
