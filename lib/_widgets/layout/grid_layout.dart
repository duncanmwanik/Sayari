import 'package:flutter/material.dart';

import '../../__styling/spacing.dart';
import '../../_helpers/_common/ui.dart';
import '../../_models/item.dart';
import '../../_providers/providers.dart';
import '../../_services/hive/get_data.dart';
import '../../_variables/features.dart';
import '../../features/_notes/note.dart';
import 'masonry/rendering/sliver_simple_grid_delegate.dart';
import 'masonry/widgets/masonry_grid_view.dart';

class GridLayout extends StatelessWidget {
  const GridLayout({super.key});

  @override
  Widget build(BuildContext context) {
    bool isGrid = state.views.isGrid();

    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      double width = constraints.maxWidth;

      return MasonryGridView.builder(
        key: UniqueKey(),
        shrinkWrap: true,
        physics: shareScrollPhysics(),
        padding: EdgeInsets.only(bottom: largeHeightPlaceHolder()),
        gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: isGrid ? gridCount(width) : 1,
        ),
        crossAxisSpacing: smallWidth(),
        mainAxisSpacing: smallWidth(),
        itemCount: state.data.ids.length,
        itemBuilder: (ctx, index) {
          String itemId = state.data.ids[index];
          Map itemData = storage(feature.items.t).get(itemId, defaultValue: {});
          Item item = Item(type: feature.items.t, id: itemId, data: itemData);

          return Note(key: Key(item.id), item: item);
        },
      );
    });
  }
}


// class GridLayout extends StatelessWidget {
//   const GridLayout({super.key});

//   @override
//   Widget build(BuildContext context) {
//     bool isGrid = state.views.isGrid();
//     Box box = Hive.box('${liveSpace()}_${feature.items.t}');

//     return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
//       double width = constraints.maxWidth;

//       return GridView.builder(
//         key: UniqueKey(),
//         shrinkWrap: true,
//         physics: shareScrollPhysics(),
//         padding: EdgeInsets.only(bottom: largeHeightPlaceHolder()),
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: isGrid ? gridCount(width) : 1,
//           childAspectRatio: 0.9,
//           crossAxisSpacing: smallWidth(),
//           mainAxisSpacing: smallWidth(),
//         ),
//         itemCount: state.data.ids.length,
//         itemBuilder: (ctx, index) {
//           String itemId = state.data.ids[index];
//           Map itemData = box.get(state.data.ids[index], defaultValue: {});
//           Item item = Item(type: feature.items.t, id: itemId, data: itemData);

//           return Note(key: Key(item.id), item: item);
//         },
//       );
//     });
//   }
// }

