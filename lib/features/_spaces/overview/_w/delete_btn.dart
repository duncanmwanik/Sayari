import 'package:flutter/material.dart';

import '../../../../__styling/spacing.dart';
import '../../../../__styling/variables.dart';
import '../../../../_widgets/buttons/button.dart';
import '../../../../_widgets/others/icons.dart';
import '../../../../_widgets/others/text.dart';
import '../../_helpers/common.dart';
import '../../_helpers/delete_space.dart';

class DeleteSpaceBtn extends StatelessWidget {
  const DeleteSpaceBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return AppButton(
      onPressed: () => deleteSpace(spaceId: liveSpace(), spaceName: 'space'),
      showBorder: true,
      slp: true,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppIcon(Icons.delete_forever, size: normal, color: styler.accent),
          spw(),
          Flexible(child: AppText(text: 'Delete Space', color: styler.accent)),
        ],
      ),
    );
  }
}
