import 'package:flutter/material.dart';

import '../../../../__styling/spacing.dart';
import '../../../../__styling/variables.dart';
import '../../../../_variables/features.dart';
import '../../../../_widgets/buttons/button.dart';
import '../../../../_widgets/others/icons.dart';
import '../../../../_widgets/others/text.dart';
import '../../../_notes/_w/picker_type.dart';
import '../../_helpers/admin_helpers.dart';
import '../../_helpers/checks_space.dart';
import '../../_var/variables.dart';

class AdminChip extends StatelessWidget {
  const AdminChip({super.key, required this.userEmail, required this.userId, required this.spaceId});

  final String userEmail;
  final String userId;
  final String spaceId;

  @override
  Widget build(BuildContext context) {
    return AppButton(
        onPressed: null,
        smallRightPadding: isAdmin(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(child: AppText(text: userEmail)),
            // change priviledges

            AppTypePicker(
              type: feature.calendar,
              subType: 'y',
              initial: superPriviledges.keys.firstWhere((key) => superPriviledges[key] == adminPriviledge(userId)),
              typeEntries: isSuperAdmin() ? superPriviledges : adminPriviledges,
              onSelect: (chosenType, chosenValue) async {
                await changePersonPriviledge(userId, chosenValue);
              },
            ),
            if (isAdmin()) spw(),
            // remove person
            if (isAdmin())
              AppButton(
                onPressed: () async {
                  if (isAdmin()) {
                    await removeMemberFromSpace(userId, userEmail);
                  }
                },
                noStyling: true,
                isSquare: true,
                child: AppIcon(closeIcon, faded: true, size: 18),
              )
          ],
        ));
  }
}
