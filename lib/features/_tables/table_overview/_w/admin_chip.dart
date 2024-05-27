import 'package:flutter/material.dart';

import '../../../../__styling/variables.dart';
import '../../../../_widgets/abcs/buttons/buttons.dart';
import '../../../../_widgets/others/icons.dart';
import '../../../../_widgets/others/text.dart';
import '../../_helpers/admin_helpers.dart';
import '../../_helpers/checks_table.dart';

class AdminChip extends StatelessWidget {
  const AdminChip({super.key, required this.userEmail, required this.userId, required this.tableId});

  final String userEmail;
  final String userId;
  final String tableId;

  @override
  Widget build(BuildContext context) {
    return AppButton(
        onPressed: null,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Flexible(child: AppText(text: userEmail)),
            if (isAdmin())
              AppButton(
                onPressed: () async {
                  if (isAdmin()) {
                    await removeAdminFromTable(context, userId, userEmail);
                  }
                },
                noStyling: true,
                child: AppIcon(closeIcon, faded: true, size: 18),
              )
          ],
        ));
  }
}
