import 'package:flutter/material.dart';

import '../../../../__styling/variables.dart';
import '../../../../_helpers/user/user_actions.dart';
import '../../../../_widgets/abcs/buttons/buttons.dart';
import '../../../../_widgets/abcs/menu/menu_item.dart';
import '../../../../_widgets/others/icons.dart';
import '../../../../_widgets/others/others/other_widgets.dart';
import '../../_helpers/checks_table.dart';
import '../../_helpers/delete_table.dart';

class TableOptions extends StatelessWidget {
  const TableOptions({super.key, required this.tableId, required this.tableName, required this.tableGroupName});

  final String tableId;
  final String tableName;
  final String tableGroupName;

  @override
  Widget build(BuildContext context) {
    bool isNotDefaultTable = !isDefaultTable(tableId);

    return AppButton(
      tooltip: 'Options',isSquare: true,
      menuItems: [
        //
        MenuItem(
          label: 'Add To Group',
          iconData: Icons.drive_folder_upload_rounded,
          onTap: () => addTableToGroup(tableId),
        ),
        //
        if (tableGroupName.isNotEmpty)
          MenuItem(
            label: 'Remove From Group',
            iconData: Icons.folder_off_rounded,
            onTap: () => removeTableFromGroup(tableId, tableGroupName),
          ),
        //
        if (isNotDefaultTable)
          FutureBuilder(
              future: isOwner(tableId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return NoWidget();
                  } else if (snapshot.hasData) {
                    final isOwner = snapshot.data as bool;

                    return isOwner
                        ? NoWidget()
                        : MenuItem(
                            label: 'Remove Table',
                            iconData: Icons.remove_circle_outlined,
                            onTap: () => removeTable(tableId: tableId, tableName: tableName),
                          );
                  }
                }
                return LinearProgressIndicator(color: styler.textColor(faded: true));
              }),
        //
        //
        if (isNotDefaultTable)
          FutureBuilder(
              future: isOwner(tableId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return NoWidget();
                  } else if (snapshot.hasData) {
                    final isOwner = snapshot.data as bool;

                    return isOwner
                        ? MenuItem(
                            label: 'Delete Table',
                            iconData: Icons.delete_forever_rounded,
                            onTap: () => deleteTable(tableId: tableId, tableName: tableName),
                          )
                        : NoWidget();
                  }
                }
                return LinearProgressIndicator(color: styler.textColor(faded: true));
              }),
        //
      ],
      noStyling: true,
      child: AppIcon(Icons.more_vert, faded: true, size: 18),
    );
  }
}
