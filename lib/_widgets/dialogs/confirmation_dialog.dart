import '../../_helpers/_common/navigation.dart';
import '../others/others/other_widgets.dart';
import '../others/text.dart';
import 'app_dialog.dart';
import 'dialog_buttons.dart';

Future<void> showConfirmationDialog({
  required String title,
  String content = '',
  String? yeslabel,
  String? noLabel,
  bool showBottomPadding = false,
  required Function() onAccept,
}) async {
  bool yes = false;

  await showAppDialog(
    title: title,
    content: content.isNotEmpty ? AppText(text: content, faded: true) : const NoWidget(),
    actions: [
      ActionButton(
          isCancel: true,
          label: noLabel,
          onPressed: () {
            popWhatsOnTop();
          }),
      ActionButton(
          label: yeslabel,
          onPressed: () {
            yes = true;
            popWhatsOnTop();
          }),
    ],
  );

  if (yes) onAccept();
}
