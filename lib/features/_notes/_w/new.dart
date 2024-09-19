import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../__styling/spacing.dart';
import '../../../_providers/views.dart';
import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/others/text.dart';
import '../../_home/panel/creator.dart';
import '../_helpers/helpers.dart';

class NewOptions extends StatelessWidget {
  const NewOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ViewsProvider>(builder: (context, views, child) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          //
          Creator(),
          //
          spw(),
          //
          AppButton(
            onPressed: () => prepareNoteForCreation(),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // AppIcon(Icons.my_library_add_rounded, tiny: true),
                // spw(),
                AppText(text: 'Templates'),
              ],
            ),
          ),
          //
        ],
      );
    });
  }
}
