// ignore_for_file: unused_local_variable

import '../../_helpers/debug.dart';
import '../hive/get_data.dart';

Future saveActivity(String spaceId, String timestamp, String activity) async {
  try {
    // List<String> activityData = splitList(activity, separator: ',', clearEmpties: false);
    // String db = activityData[0];
    // String type = activityData[1];
    // String action = activityData[2];
    // String id = activityData[3];
    // String sid = activityData[4];
    // String keys = activityData[5];
    // String extras = activityData[6];
    // String userName = activityData[7];

    storage('activity', spaceId: spaceId).put(timestamp, activity);

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
    //     //   title: getSpaceName(spaceId),
    //     //   body: activityDescription,
    //     //   data: {'type': type, 'spaceId': spaceId, 'id': id},
    //     // );
    //   }
    // }
    // }
  } catch (e) {
    errorPrint('save-activity', e);
  }
}
