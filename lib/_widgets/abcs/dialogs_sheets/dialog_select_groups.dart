import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_helpers/user/set_user_data.dart';
import '../../../_providers/common/input.dart';
import '../../../features/_tables/_helpers/table_names.dart';
import '../../../features/_tables/table_management/_w/dialog_create_group.dart';
import '../../others/checkbox.dart';
import '../../others/icons.dart';
import '../../others/text.dart';
import '../buttons/buttons.dart';
import 'app_dialog.dart';
import 'dialog_buttons.dart';

Future showSelectGroupsDialog() {
  List groupNames = [];

  return showAppDialog(
    title: 'Select Groups',
    content: ValueListenableBuilder(
        valueListenable: Hive.box('${liveUser()}_data').listenable(),
        builder: (context, box, widget) {
          Map userTableData = box.toMap();
          groupNames = getGroupNamesAsList(userTableData);

          return groupNames.isNotEmpty
              ? ListView.separated(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: groupNames.length,
                  separatorBuilder: (context, index) => sph(),
                  itemBuilder: (context, index) {
                    String group = groupNames[index];

                    return Consumer<InputProvider>(
                        builder: (context, input, child) => ListTile(
                              onTap: () => input.updateSelectedGroups('add', group),
                              tileColor: styler.appColor(1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(borderRadiusSmall),
                              ),
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  AppIcon(Icons.folder_rounded, faded: true, size: 16),
                                  mpw(),
                                  Flexible(
                                      child: AppText(
                                    text: group,
                                  )),
                                ],
                              ),
                              trailing: AppCheckBox(
                                isChecked: input.selectedGroups.contains(group),
                                onTap: () => input.updateSelectedGroups('add', group),
                              ),
                            ));
                  })
              : Align(
                  alignment: Alignment.center,
                  child: AppButton(
                    onPressed: () => showCreateGroupDialog(),
                    noStyling: true,
                    child: AppText(text: 'Tap to create your first group', faded: true),
                  ),
                );
        }),
    actions: [
      ActionButton(
        isCancel: true,
      ),
      ActionButton(),
    ],
  );
}
