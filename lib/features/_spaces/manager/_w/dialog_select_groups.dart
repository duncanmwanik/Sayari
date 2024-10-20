import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../_helpers/navigation.dart';
import '../../../../_providers/_providers.dart';
import '../../../../_providers/input.dart';
import '../../../../_services/hive/local_storage_service.dart';
import '../../../../_theme/spacing.dart';
import '../../../../_theme/variables.dart';
import '../../../../_widgets/buttons/action.dart';
import '../../../../_widgets/buttons/button.dart';
import '../../../../_widgets/dialogs/app_dialog.dart';
import '../../../../_widgets/others/checkbox.dart';
import '../../../../_widgets/others/icons.dart';
import '../../../../_widgets/others/text.dart';
import 'dialog_create_group.dart';

Future showSelectGroupsDialog() {
  return showAppDialog(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText(text: 'Select groups'),
        AppButton(
          onPressed: () => showCreateGroupDialog(),
          svp: true,
          slp: true,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppIcon(Icons.add, size: normal),
              spw(),
              AppText(text: 'Create'),
            ],
          ),
        ),
      ],
    ),
    content: ValueListenableBuilder(
        valueListenable: userGroupsBox.listenable(),
        builder: (context, box, widget) {
          return box.isNotEmpty
              ? ListView.separated(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: box.length,
                  separatorBuilder: (context, index) => tph(),
                  itemBuilder: (context, index) {
                    String group = box.keyAt(index);

                    return Consumer<InputProvider>(
                        builder: (context, input, child) => AppButton(
                              onPressed: () => input.updateSelectedGroups(group),
                              srp: true,
                              noStyling: true,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const AppIcon(Icons.folder_rounded, faded: true, size: 16),
                                  mpw(),
                                  Expanded(child: AppText(text: group)),
                                  spw(),
                                  AppCheckBox(
                                    isChecked: input.selectedGroups.contains(group),
                                    onTap: () => input.updateSelectedGroups(group),
                                  ),
                                ],
                              ),
                            ));
                  })
              : Align(
                  alignment: Alignment.center,
                  child: AppButton(
                    onPressed: () => showCreateGroupDialog(),
                    noStyling: true,
                    child: const AppText(text: 'Tap to create your first group', faded: true),
                  ),
                );
        }),
    actions: [
      ActionButton(isCancel: true, onPressed: () => popWhatsOnTop(todo: () => state.input.clearSelectedGroups())),
      ActionButton(),
    ],
  );
}
