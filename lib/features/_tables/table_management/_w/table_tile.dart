import 'package:flutter/material.dart';

import '../../../../__styling/helpers.dart';
import '../../../../__styling/spacing.dart';
import '../../../../__styling/variables.dart';
import '../../../../_widgets/abcs/buttons/buttons.dart';
import '../../../../_widgets/others/icons.dart';
import '../../../../_widgets/others/images.dart';
import '../../../../_widgets/others/loader.dart';
import '../../../../_widgets/others/others/other_widgets.dart';
import '../../../../_widgets/others/text.dart';
import '../../_helpers/checks_table.dart';
import '../../_helpers/common.dart';
import '../../_helpers/select_table.dart';
import 'table_options.dart';

class TableTile extends StatefulWidget {
  const TableTile({super.key, required this.tableId, this.tableGroupName = ''});

  final String tableId;
  final String tableGroupName;

  @override
  State<TableTile> createState() => _TableTileState();
}

class _TableTileState extends State<TableTile> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    bool isSelected = widget.tableId == liveTable();

    return FutureBuilder(
        future: getTableNameFuture(widget.tableId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return NoWidget();
            } else if (snapshot.hasData) {
              final tableName = snapshot.data as String;

              return AppButton(
                onPressed: isLoading
                    ? () {}
                    : () async {
                        setState(() => isLoading = true);
                        await selectNewTable(widget.tableId);
                        setState(() => isLoading = false);
                      },
                borderRadius: borderRadiusSmall,
                color: styler.appColor(1),
                padding: EdgeInsets.only(left: 10, right: 4),
                height: 40,
                child: Row(
                  children: [
                    //
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          //
                          AppImage(imagePath: 'assets/images/sayari.png', size: 16),
                          //
                          spw(),
                          // table name
                          Expanded(
                            child: AppText(
                              text: tableName,
                              textAlign: TextAlign.start,
                              fontWeight: FontWeight.w700,
                              faded: true,
                            ),
                          ),
                          //
                          spw(),
                          // indicator, if table is selected
                          if (isSelected) AppIcon(Icons.done_rounded, size: 18, faded: true),
                          //
                        ],
                      ),
                    ),
                    //
                    isLoading
                        ? Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: AppLoader(color: isImageTheme() ? white : styler.accentColor()),
                          )
                        : TableOptions(
                            tableId: widget.tableId,
                            tableName: tableName,
                            tableGroupName: widget.tableGroupName,
                          ),
                    //
                    //
                  ],
                ),
              );
            }
          }
          return NoWidget();
        });
  }
}
