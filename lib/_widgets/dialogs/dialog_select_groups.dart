import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_helpers/_common/navigation.dart';
import '../../_providers/_providers.dart';
import '../../_providers/input.dart';
import '../../_services/hive/local_storage_service.dart';
import '../../features/_spaces/manager/_w/dialog_create_group.dart';
import '../buttons/action.dart';
import '../buttons/button.dart';
import '../others/checkbox.dart';
import '../others/icons.dart';
import '../others/text.dart';
import 'app_dialog.dart';

Future showSelectGroupsDialog() {
  return showAppDialog(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText(text: 'Select groups'),
        AppButton(
          onPressed: () => showCreateGroupDialog(),
          smallVerticalPadding: true,
          smallLeftPadding: true,
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
                              smallRightPadding: true,
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
