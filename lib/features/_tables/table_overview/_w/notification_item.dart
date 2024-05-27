import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../__styling/spacing.dart';
import '../../../../_variables/features.dart';
import '../../../../_widgets/others/checkbox.dart';
import '../../../../_widgets/others/text.dart';
import '../../_helpers/common.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({super.key, required this.label, required this.value, required this.type});

  final String label;
  final bool value;
  final String type;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Hive.box('${liveTable()}_notifications').put(type, !value),
      dense: true,
      contentPadding: itemPaddingMedium(left: true, right: true),
      leading: AppText(text: featureData[label]!.title),
      trailing: AppCheckBox(
        isChecked: value,
        onTap: () => Hive.box('${liveTable()}_notifications').put(type, !value),
      ),
    );
  }
}
