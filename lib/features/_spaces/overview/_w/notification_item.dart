import 'package:flutter/material.dart';

import '../../../../_services/hive/store.dart';
import '../../../../_theme/spacing.dart';
import '../../../../_variables/features.dart';
import '../../../../_widgets/others/checkbox.dart';
import '../../../../_widgets/others/text.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({super.key, required this.label, required this.value, required this.type});

  final String label;
  final bool value;
  final String type;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => storage('notifications').put(type, !value),
      dense: true,
      contentPadding: padM('lr'),
      leading: AppText(text: label.title()),
      trailing: AppCheckBox(
        isChecked: value,
        onTap: () => storage('notifications').put(type, !value),
      ),
    );
  }
}
