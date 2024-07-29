import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../__styling/spacing.dart';
import '../../_models/item.dart';
import '../../_providers/providers.dart';
import '../../features/_notes/note.dart';
import '../../features/_tables/_helpers/common.dart';
import 'masonry/rendering/sliver_simple_grid_delegate.dart';
import 'masonry/widgets/masonry_grid_view.dart';

class GridLayout extends StatelessWidget {
  const GridLayout({super.key, required this.type});

  final String type;

  @override
  Widget build(BuildContext context) {
    bool isGrid = state.views.isGrid();
    Box box = Hive.box('${liveTable()}_$type');

    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      double width = constraints.maxWidth;

      return MasonryGridView.builder(
        key: UniqueKey(),
        shrinkWrap: true,
        padding: EdgeInsets.only(bottom: largeHeightPlaceHolder()),
        gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: isGrid ? gridCount(width) : 1,
        ),
        crossAxisSpacing: smallWidth(),
        mainAxisSpacing: smallWidth(),
        itemCount: state.data.chosen.length,
        itemBuilder: (ctx, index) {
          String itemId = state.data.chosen[index];
          Map itemData = box.get(state.data.chosen[index], defaultValue: {});
          Item item = Item(type: type, id: itemId, data: itemData);

          return Note(key: Key(item.id), item: item);
        },
      );
    });
  }
}
