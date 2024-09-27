import '../../../_helpers/debug.dart';
import '../../../_services/firebase/sync_to_cloud.dart';
import '../../../_services/hive/get_data.dart';
import '../../../_variables/constants.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/others/toast.dart';
import '../../_spaces/_helpers/common.dart';

Future<void> addLabel(String label) async {
  try {
    //
    // if label dows not exist already or is a default label
    //
    if (storage(feature.labels).containsKey(label) || specialLabelsIcons.keys.contains(label)) {
      // Future helps us show the toast consistently : bug
      Future.delayed(Duration(seconds: 0), () => showToast(0, 'Label already exists!'));
    }
    //
    //
    //
    else {
      storage(feature.labels).put(label, '0');

      await syncToCloud(db: 'spaces', space: liveSpace(), parent: feature.flags, action: 'c', id: label, data: '0');
    }
    //
    //
    //
  } catch (e) {
    errorPrint('add-label', e);
  }
}
