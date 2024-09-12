import '../../../_helpers/_common/internet_connection.dart';
import '../../../_helpers/_common/navigation.dart';
import '../../../_helpers/forms/regex_checks.dart';
import '../../../_services/firebase/_helpers/helpers.dart';
import '../../../_services/hive/local_storage_service.dart';
import '../../../_widgets/others/toast.dart';
import '../../_spaces/_helpers/checks_space.dart';
import '../../user/_helpers/set_user_data.dart';
import '../../user/_helpers/user_actions.dart';

Future<void> addSpaceFromId(String spaceId) async {
  try {
    if (spaceId.isNotEmpty) {
      if (isValidSpaceId(spaceId)) {
        hideKeyboard();
        showToast(2, 'Adding workspace...');

        if (!isSpaceAlreadyAdded(spaceId)) {
          hasAccessToInternet().then((hasInternet) async {
            if (hasInternet) {
              await doesSpaceExist(spaceId).then((spaceName) async {
                if (spaceName != 'none') {
                  await userDataBox.put(spaceId, 0);
                  await spaceNamesBox.put(spaceId, spaceName);

                  await addSpaceToUserData(liveUser(), spaceId, []);
                  popWhatsOnTop();
                  showToast(1, 'Added workspace $spaceName');
                } else {
                  showToast(0, 'That workspace does not exist');
                }
              });
            }
          });
        } else {
          showToast(2, 'Space is already added.');
        }
      } else {
        showToast(0, 'Enter a valid workspace id');
      }
    } else {
      showToast(0, 'Enter workspace id');
    }
  } catch (error) {
    showToast(0, 'Could not add workspace');
  }
}
