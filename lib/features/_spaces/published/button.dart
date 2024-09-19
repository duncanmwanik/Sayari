import 'package:flutter/material.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_providers/_providers.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';
import '../../_notes/type/bookings/_w/copy_link.dart';
import '../../share/_helpers/share.dart';
import '../_helpers/common.dart';
import '../_helpers/helpers.dart';

class PublishButton extends StatelessWidget {
  const PublishButton({super.key, required this.spaceData});

  final Map spaceData;

  @override
  Widget build(BuildContext context) {
    bool isPublished = spaceData[feature.share.lt] == '1';

    return Wrap(
      spacing: mediumWidth(),
      runSpacing: smallWidth(),
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        //
        AppButton(
          onPressed: () {
            prepareSpaceForEdit(spaceData);
            if (!isPublished) state.input.update(feature.share.lt, '1');
            shareItem(itemId: liveSpace(), type: feature.space.lt, title: spaceData['t'] ?? 'Book');
          },
          smallLeftPadding: true,
          color: isPublished ? styler.accentColor(5) : null,
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
        //
        if (isPublished) CopyLink(path: publishedSpaceLink(true), isMinimized: true),
        //
      ],
    );
  }
}
