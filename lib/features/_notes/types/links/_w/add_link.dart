import 'package:flutter/material.dart';

import '../../../../../_theme/spacing.dart';
import '../../../../../_widgets/buttons/button.dart';
import '../../../../../_widgets/others/icons.dart';
import '../../../../../_widgets/others/text.dart';
import '../_helpers/helpers.dart';

class AddLink extends StatelessWidget {
  const AddLink({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: smallWidth(),
      runSpacing: smallWidth(),
      children: [
        //
        AppButton(
          onPressed: () => addLink(),
          slp: true,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppIcon(Icons.add, faded: true),
              spw(),
              Flexible(child: AppText(text: 'Add Link', faded: true)),
            ],
          ),
        ),
        //
        AppButton(
          onPressed: () => addLink(isTitle: true),
          slp: true,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppIcon(Icons.add, faded: true),
              spw(),
              Flexible(child: AppText(text: 'Add Title', faded: true)),
            ],
          ),
        ),
        //
      ],
    );
  }
}
