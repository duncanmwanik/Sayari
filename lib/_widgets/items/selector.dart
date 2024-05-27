import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../__styling/variables.dart';
import '../../__styling/helpers.dart';
import '../../_models/item.dart';
import '../../_providers/common/misc.dart';
import '../../_providers/common/selection.dart';
import '../../_providers/providers.dart';
import '../others/icons.dart';
import '../others/others/other_widgets.dart';

class ItemSelector extends StatelessWidget {
  const ItemSelector({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    bool isChecked = state.selection.isSelected(item.id);

    return Consumer2<SelectionProvider, HoverProvider>(builder: (context, selection, hover, child) {
      bool isSelection = selection.isSelection;
      bool isSelected = selection.isSelected(item.id);
      bool isHovered = hover.id == item.id;

      return Visibility(
        visible: kIsWeb && (isSelection || isSelected || isHovered),
        child: Align(
          alignment: Alignment.topLeft,
          child: Material(
            color: transparent,
            child: InkWell(
              onTap: () {
                if (isChecked) {
                  state.selection.unSelect(item.id);
                } else {
                  state.selection.select(item.id, item.title(), item.type);
                }
              },
              customBorder: CircleBorder(),
              child: Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  color: isChecked ? styler.accentColor() : (isImageTheme() ? Colors.white70 : styler.primaryColor()),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isChecked ? transparent : Colors.grey.withOpacity(0.4),
                    width: 1.4,
                  ),
                ),
                child: Center(
                  child: isChecked || isHovered || isSelection
                      ? AppIcon(
                          Icons.done_rounded,
                          size: 14,
                          faded: true,
                          bgColor: item.bgColor(),
                          color: isChecked ? white : (isImageTheme() ? black : Colors.grey.withOpacity(0.7)),
                        )
                      : NoWidget(),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
