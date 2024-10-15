import 'package:flutter/material.dart';

import '../../../../__styling/spacing.dart';
import '../../../../_services/hive/store.dart';
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
      contentPadding: paddingM('lr'),
      leading: AppText(text: features[label]!.title),
      trailing: AppCheckBox(
        isChecked: value,
        onTap: () => storage('notifications').put(type, !value),
      ),
    );
  }
}
