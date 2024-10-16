import 'package:flutter/material.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_providers/_providers.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';
import '../../_notes/types/bookings/_w/copy_link.dart';
import '../_helpers/common.dart';
import '../_helpers/helpers.dart';

class PublishButton extends StatelessWidget {
  const PublishButton({super.key, required this.spaceData});
  final Map spaceData;

  @override
  Widget build(BuildContext context) {
    bool isPublished = spaceData[feature.share] == '1';

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        //
        AppButton(
          padding: noPadding,
          color: isPublished ? styler.accentColor(5) : null,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppButton(
                onPressed: () {
                  prepareSpaceForEdit(spaceData);
                  if (!isPublished) state.input.update(feature.share, '1');
                },
                noStyling: true,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppIcon(Icons.book, size: normal),
                    spw(),
                    Flexible(child: AppText(text: isPublished ? 'Published as Book' : 'Publish as Book')),
                    spw(),
                    AppIcon(Icons.arrow_forward, tiny: true),
                  ],
                ),
              ),
              if (isPublished) CopyLink(path: publishedSpaceLink(true), isMinimized: true),
            ],
          ),
        ),
        //
      ],
    );
  }
}
