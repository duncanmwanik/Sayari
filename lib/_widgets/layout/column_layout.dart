import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../__styling/spacing.dart';
import '../../_models/item.dart';
import '../../_providers/providers.dart';
import '../../_variables/features.dart';
import '../../features/_lists/list.dart';
import '../../features/_tables/_helpers/common.dart';
import '../../features/finance/period.dart';
import '../../features/notes/note.dart';
import '../others/others/other_widgets.dart';
import '../others/others/snap_scroll_physics.dart';
import 'orderables/background.dart';

class ColumnLayout extends StatelessWidget {
  const ColumnLayout({super.key, required this.type});

  final String type;

  @override
  Widget build(BuildContext context) {
    Box box = Hive.box('${liveTable()}_$type');

    return Align(
      alignment: Alignment.topLeft,
      child: SizedBox(
        height: 80.h,
        child: ReorderableListView.builder(
          scrollDirection: Axis.horizontal,
          physics: kIsWeb ? null : SnapScrollPhysics(snapSize: 300),
          padding: EdgeInsets.only(top: 5, bottom: 10, left: 10, right: 100.w - 320),
          shrinkWrap: true,
          buildDefaultDragHandles: false,
          proxyDecorator: (child, index, animation) => proxyDecorator(child, index, animation),
          onReorder: (oldIndex, newIndex) {},
          itemCount: state.data.chosen.length,
          itemBuilder: (ctx, index) {
            String itemId = state.data.chosen[index];
            Map itemData = box.get(state.data.chosen[index], defaultValue: {});
            Item item = Item(type: type, id: itemId, data: itemData);

            return ReorderableDelayedDragStartListener(
              index: index,
              key: ValueKey(item.id),
              child: Padding(
                padding: itemPadding(left: index != 0),
                child: SizedBox(
                  width: 300,
                  child: type == feature.notes.t
                      ? Note(item: item)
                      : type == feature.lists.t
                          ? AList(item: item)
                          : type == feature.finance.t
                              ? Period(item: item)
                              : NoWidget(),
                ),
              ),
            );

            //
          },
        ),
      ),
    );
  }
}
