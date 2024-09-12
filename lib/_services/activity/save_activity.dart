// ignore_for_file: unused_local_variable

import 'package:hive/hive.dart';

import '../../_helpers/_common/global.dart';

Future saveActivity(String parentId, String timestamp, String activity) async {
  try {
    // List<String> activityData = getSplitList(activity, separator: ',', clearEmpties: false);
    // String db = activityData[0];
    // String type = activityData[1];
    // String action = activityData[2];
    // String itemId = activityData[3];
    // String subId = activityData[4];
    // String keys = activityData[5];
    // String extras = activityData[6];
    // String userName = activityData[7];

    Hive.box('${parentId}_activity').put(timestamp, activity);

    // if (db == 'spaces' && itemTitle.isNotEmpty) {
    //   String activityDescription = '';

    //   if (action == 'c') {
    //     activityDescription = '<b>$userName</b> created ${subtitle.isNotEmpty ? 'entry <b>$subtitle</b> for ' : ''}$type <b>$itemTitle</b>.';
    //   } else if (action == 'e') {
    //     activityDescription = '<b>$userName</b> edited ${subtitle.isNotEmpty ? 'entry <b>$subtitle</b> for ' : ''}$type <b>$itemTitle</b>.';
    //   } else if (action == 'd') {
    //     activityDescription = '<b>$userName</b> deleted ${subtitle.isNotEmpty ? 'entry <b>$subtitle</b> from ' : ''}$type <b>$itemTitle</b>.';
    //   }

    // if (activityDescription.isNotEmpty) {
    //   if (activityDescription.isNotEmpty) {
    //     // await showNotification(
    //     //   type: type,
    //     //   title: getSpaceName(parentId),
    //     //   body: activityDescription,
    //     //   data: {'type': type, 'parentId': parentId, 'itemId': itemId},
    //     // );
    //   }
    // }
    // }
  } catch (e) {
    errorPrint('save-activity', e);
  }
}
