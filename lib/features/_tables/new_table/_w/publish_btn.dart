import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../__styling/spacing.dart';
import '../../../../__styling/variables.dart';
import '../../../../_providers/providers.dart';
import '../../../../_widgets/abcs/buttons/buttons.dart';
import '../../../../_widgets/others/icons.dart';
import '../../../../_widgets/others/text.dart';
import '../../_helpers/helpers.dart';

class PublishButton extends StatelessWidget {
  const PublishButton({super.key, required this.spaceData});

  final Map spaceData;

  @override
  Widget build(BuildContext context) {
    bool isPublished = spaceData['sp'] == '1';

    return AppButton(
      onPressed: () {
        prepareTableForEdit(spaceData);
        if (!isPublished) state.input.update(action: 'add', key: 'sp', value: '1');
      },
      height: 45,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppIcon(FontAwesomeIcons.bookOpen, size: 12),
          pw(10),
          Flexible(child: AppText(text: isPublished ? 'Published as Book' : 'Publish as Book')),
          if (isPublished) spw(),
          if (isPublished) AppIcon(Icons.check_circle_rounded, color: styler.accent),
        ],
      ),
    );
  }
}
