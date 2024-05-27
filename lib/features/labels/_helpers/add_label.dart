import 'package:hive_flutter/hive_flutter.dart';

import '../../../_helpers/_common/global.dart';
import '../../../_services/firebase/sync_to_cloud.dart';
import '../../../_variables/features.dart';
import '../../../_variables/strings.dart';
import '../../../_widgets/others/toast.dart';
import '../../_tables/_helpers/common.dart';

Future<void> addLabel(String label) async {
  try {
    //
    // if label dows not exist already or is a default label
    //
    if (Hive.box('${liveTable()}_${feature.labels.t}').containsKey(label) || specialLabelsIcons.keys.contains(label)) {
      // Future helps us show the toast consistently : bug
      Future.delayed(Duration(seconds: 0), () => showToast(0, 'Label already exists!'));
    }
    //
    //
    //
    else {
      Hive.box('${liveTable()}_${feature.labels.t}').put(label, '0');

      await syncToCloud(db: 'tables', parentId: liveTable(), type: feature.labels.t, action: 'c', itemId: label, data: '0');
    }
    //
    //
    //
  } catch (e) {
    errorPrint('add-label', e);
  }
}
