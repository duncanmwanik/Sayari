import '../../../../_services/activity/activity_helper.dart';
import '../../../../_widgets/buttons/action.dart';
import '../../../../_widgets/dialogs/app_dialog.dart';

Future showSpaceActivityDialog(String activityId) async {
  await showAppDialog(title: 'Delete ativity?', actions: [
    ActionButton(isCancel: true),
    ActionButton(
      label: 'Delete',
      onPressed: () => deleteActivity(activityId),
    ),
  ]);
}
