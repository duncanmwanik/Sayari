import '../../../_helpers/forms/regex_checks.dart';
import '../../../_helpers/internet_connection.dart';
import '../../../_helpers/navigation.dart';
import '../../../_services/firebase/_helpers/helpers.dart';
import '../../../_services/hive/local_storage_service.dart';
import '../../../_widgets/others/toast.dart';
import '../../_spaces/_helpers/checks_space.dart';
import '../../user/_helpers/actions.dart';
import '../../user/_helpers/helpers.dart';

Future<void> addSpaceFromId(String spaceId) async {
  try {
    if (spaceId.isNotEmpty) {
      if (isValidSpaceId(spaceId)) {
        hideKeyboard();
        showToast(2, 'Adding workspace...');
        if (await noInternet()) return;

        if (!isSpaceAlreadyAdded(spaceId)) {
          await doesSpaceExist(spaceId).then((spaceName) async {
            if (spaceName != 'none') {
              await spaceNamesBox.put(spaceId, spaceName);

              await addSpaceToUserData(liveUser(), spaceId, []);
              popWhatsOnTop();
              showToast(1, 'Added workspace $spaceName');
            } else {
              showToast(0, 'That workspace does not exist');
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
