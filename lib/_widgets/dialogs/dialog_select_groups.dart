import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../../__styling/spacing.dart';
import '../../_providers/common/input.dart';
import '../../_services/hive/local_storage_service.dart';
import '../../features/_spaces/_helpers/space_names.dart';
import '../../features/_spaces/manager/_w/dialog_create_group.dart';
import '../buttons/action_button.dart';
import '../buttons/buttons.dart';
import '../others/checkbox.dart';
import '../others/icons.dart';
import '../others/text.dart';
import 'app_dialog.dart';

Future showSelectGroupsDialog() {
  List groupNames = [];

  return showAppDialog(
    title: 'Select Groups',
    content: ValueListenableBuilder(
        valueListenable: userDataBox.listenable(),
        builder: (context, box, widget) {
          Map userSpaceData = box.toMap();
          groupNames = getGroupNamesAsList(userSpaceData);

          return groupNames.isNotEmpty
              ? ListView.separated(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: groupNames.length,
                  separatorBuilder: (context, index) => sph(),
                  itemBuilder: (context, index) {
                    String group = groupNames[index];

                    return Consumer<InputProvider>(
                        builder: (context, input, child) => AppButton(
                              onPressed: () => input.updateSelectedGroups('add', group),
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
                                    onTap: () => input.updateSelectedGroups('add', group),
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
      const ActionButton(
        isCancel: true,
      ),
      const ActionButton(),
    ],
  );
}
