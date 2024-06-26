import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../__styling/spacing.dart';
import '../../../../__styling/variables.dart';
import '../../../../_providers/common/input.dart';
import '../../../../_widgets/abcs/buttons/buttons.dart';
import '../../../../_widgets/abcs/dialogs_sheets/dialog_select_groups.dart';
import '../../../../_widgets/others/icons.dart';
import '../../../../_widgets/others/text.dart';

class Groups extends StatelessWidget {
  const Groups({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, inputProvider, child) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //
          Row(
            children: [
              //
              AppIcon(Icons.folder_outlined, size: 16),
              //
              spw(),
              //
              AppButton(
                onPressed: () => showSelectGroupsDialog(),
                child: AppText(
                  text: 'Add to Group',
                ),
              ),
              //
            ],
          ),
          //
          if (inputProvider.selectedGroups.isNotEmpty && kIsWeb) sph(),
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 5),
            child: Wrap(
              spacing: smallWidth(),
              runSpacing: smallWidth(),
              children: List.generate(inputProvider.selectedGroups.length, (index) {
                String groupName = inputProvider.selectedGroups[index];

                return AppButton(
                    onPressed: () => showSelectGroupsDialog(),
                    smallVerticalPadding: true,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppIcon(Icons.folder_rounded, size: 18),
                        spw(),
                        Flexible(
                            child: AppText(
                          text: groupName,
                        )),
                        spw(),
                        AppButton(
                          onPressed: () => inputProvider.updateSelectedGroups('add', groupName),
                          noStyling: true,
                          child: AppIcon(
                            closeIcon,
                            faded: true,
                          ),
                        ),
                      ],
                    ));
              }),
            ),
          ),
          //
        ],
      );
    });
  }
}
