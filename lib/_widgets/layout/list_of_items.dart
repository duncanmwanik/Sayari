import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../../__styling/spacing.dart';
import '../../_providers/common/views.dart';
import '../../_providers/providers.dart';
import '../../_variables/features.dart';
import '../../features/_notes/_w/note_options.dart';
import '../../features/_spaces/_helpers/common.dart';
import '../others/empty_box.dart';
import 'column_layout.dart';
import 'grid_layout.dart';
import 'list_layout.dart';
import 'row_layout.dart';

class ListOfItems extends StatelessWidget {
  const ListOfItems({super.key, this.data});

  final Map? data;

  @override
  Widget build(BuildContext context) {
    bool isPublish = data != null;
    return Consumer<ViewsProvider>(builder: (context, views, child) {
      return ValueListenableBuilder(
          valueListenable: Hive.box('${liveSpace()}_${feature.items.t}').listenable(),
          builder: (context, box, wdgt) {
            state.data.setAll(
              data ?? box.toMap(),
              isPublish ? 'All' : views.selectedLabel,
              isPublish ? feature.notes.lt : null,
            );

            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //
                if (!isPublish) NoteOptions(),
                if (!isPublish) tph(),
                //
                Expanded(
                  child: (state.data.isEmpty())
                      ? EmptyBox()
                      : views.isColumn()
                          ? ColumnLayout()
                          : views.isList()
                              ? ListLayout()
                              : views.isRow()
                                  ? RowLayout()
                                  : GridLayout(),
                ),
                //
              ],
            );
          });
    });
  }
}
