import 'dart:math';

import 'package:flutter/material.dart';

import '../../../../_theme/spacing.dart';
import '../../../../_theme/variables.dart';
import '../../../../_variables/colors.dart';
import '../../../../_variables/features.dart';
import '../../../../_widgets/buttons/button.dart';
import '../../../../_widgets/others/icons.dart';
import '../../../../_widgets/others/text.dart';
import '../../../_notes/w/picker_type.dart';
import '../../_helpers/checks_space.dart';
import '../../_helpers/member_helpers.dart';
import '../../var/variables.dart';

class AdminChip extends StatelessWidget {
  const AdminChip({super.key, required this.userEmail, required this.userId, required this.spaceId});

  final String userEmail;
  final String userId;
  final String spaceId;

  @override
  Widget build(BuildContext context) {
    return AppButton(
        onPressed: null,
        srp: isSuperAdmin(),
        slp: true,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            //
            AppButton(
              onPressed: () {},
              noStyling: true,
              isRound: true,
              padding: noPadding,
              margin: paddingM('r'),
              child: CircleAvatar(
                backgroundColor: backgroundColors['${Random().nextInt(backgroundColors.length - 1)}']!.color.withOpacity(0.5),
                radius: small,
                child: AppText(text: userEmail[0].toUpperCase(), size: small, faded: true),
              ),
            ),
            // email
            Expanded(child: AppText(text: userEmail)),
            // change priviledges
            isSuperAdmin()
                ? AppButton(
                    svp: true,
                    color: styler.accentColor(6),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppIcon(Icons.lock, size: small),
                        spw(),
                        AppText(text: 'Owner', size: small),
                      ],
                    ),
                  )
                : AppTypePicker(
                    type: feature.calendar,
                    subType: 'y',
                    initial: superPriviledges.keys.firstWhere((key) => superPriviledges[key] == memberPriviledge(userId)),
                    typeEntries: isSuperAdmin() ? superPriviledges : memberPriviledges,
                    onSelect: (chosenType, chosenValue) => changeMemberPriviledge(userId, chosenValue),
                  ),
            if (isAdmin()) spw(),
            // remove person
            if (!isSuperAdmin() && isAdmin())
              AppButton(
                onPressed: () => removeMemberFromSpace(userId, userEmail),
                noStyling: true,
                isSquare: true,
                padding: noPadding,
                margin: paddingM('l'),
                child: AppIcon(closeIcon, faded: true, size: 18),
              )
          ],
        ));
  }
}
