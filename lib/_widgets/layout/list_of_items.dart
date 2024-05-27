import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../../__styling/variables.dart';
import '../../_helpers/items/chosen.dart';
import '../../_providers/common/views.dart';
import '../../_providers/providers.dart';
import '../../features/_tables/_helpers/common.dart';
import '../others/empty_box.dart';
import 'column_layout.dart';
import 'grid_layout.dart';
import 'list_layout.dart';

class ListOfItems extends StatelessWidget {
  const ListOfItems({super.key, required this.type});

  final String type;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box('${liveTable()}_$type').listenable(),
        builder: (context, box, widget) {
          return Consumer<ViewsProvider>(builder: (context, views, child) {
            String currentLabel = views.selectedLabel;
            state.data.setAll(getChosenItems(type, currentLabel));

            return (state.data.isEmpty())
                ? EmptyBox(label: 'No $type here...', icon: notesUnselectedIcon)
                : views.isColumn()
                    ? ColumnLayout(type: type)
                    : views.isList()
                        ? ListLayout(type: type)
                        : GridLayout(type: type);
          });
        });
  }
}
