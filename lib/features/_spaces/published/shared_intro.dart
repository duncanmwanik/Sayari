import 'package:flutter/material.dart';

import '../../../../../__styling/spacing.dart';
import '../../../../../__styling/variables.dart';
import '../../../../../_widgets/others/text.dart';
import '../../../__styling/breakpoints.dart';
import '../../../_widgets/abcs/buttons/buttons.dart';
import '../../files/user_dp.dart';
import 'cover.dart';

class PublishedBookIntro extends StatelessWidget {
  const PublishedBookIntro({super.key, required this.sharedData, required this.data, required this.userName});

  final Map sharedData;
  final Map data;
  final String userName;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: isTabAndBelow() ? double.infinity : 300),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadiusSmall),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //
            PublishedCover(sharedData: sharedData),
            //
            mph(),
            AppText(
              text: sharedData['t'],
              // text: 'Being Mortal: Medicine and What Matters in the End',
              size: title,
              fontWeight: FontWeight.w800,
              textAlign: TextAlign.center,
            ),
            sph(),
            Container(
              width: 30,
              height: 3,
              decoration: BoxDecoration(
                color: styler.accentColor(),
                borderRadius: BorderRadius.circular(borderRadiusLarge),
              ),
            ),
            tph(),
            AppButton(
              onPressed: () {},
              noStyling: true,
              smallVerticalPadding: true,
              smallLeftPadding: true,
              borderRadius: borderRadiusLarge,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  UserDp(onPressed: () {}, userId: sharedData['u'], tooltip: userName, noViewer: true, isTiny: true, size: tiny),
                  spw(),
                  Flexible(child: AppText(text: userName, size: medium)),
                ],
              ),
            ),
            //
          ],
        ),
      ),
    );
  }
}
