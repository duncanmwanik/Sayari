import 'package:flutter/material.dart';

import '../../__styling/spacing.dart';
import '../../_variables/intro_features.dart';
import '../../_widgets/buttons/buttons.dart';
import '../../_widgets/others/icons.dart';
import '../../_widgets/others/text.dart';

class AuthIntro extends StatelessWidget {
  const AuthIntro({super.key, required this.index, required this.next, required this.previous});

  final int index;
  final Function() next;
  final Function() previous;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        //
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppButton(
              onPressed: previous,
              noStyling: true,
              isRound: true,
              child: AppIcon(Icons.keyboard_arrow_left, extraFaded: true),
            ),
            mpw(),
            Flexible(
              child: SizedBox(
                width: 200,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppText(text: introFeatures[index].title, size: 20, fontWeight: FontWeight.w900),
                    sph(),
                    AppText(text: introFeatures[index].description, faded: true),
                  ],
                ),
              ),
            ),
            mpw(),
            AppButton(
              onPressed: next,
              noStyling: true,
              isRound: true,
              child: AppIcon(Icons.keyboard_arrow_right, extraFaded: true),
            ),
          ],
        ),
        //
      ],
    );
  }
}
