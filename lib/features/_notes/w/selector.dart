import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../__styling/variables.dart';
import '../../../__styling/helpers.dart';
import '../../../_models/item.dart';
import '../../../_providers/_providers.dart';
import '../../../_providers/focus.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/others/other.dart';
import '../state/selection.dart';

class ItemSelector extends StatelessWidget {
  const ItemSelector({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    bool isChecked = state.selection.isSelected(item.id);

    return Consumer2<SelectionProvider, FocusProvider>(builder: (context, selection, focus, child) {
      bool isSelection = selection.isSelection;
      bool isSelected = selection.isSelected(item.id);
      bool isHovered = focus.id == item.id;

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
                  state.selection.select(item);
                }
              },
              customBorder: CircleBorder(),
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: isChecked
                      ? styler.accentColor()
                      : (isImage()
                          ? Colors.white70
                          : isBlack()
                              ? black
                              : styler.isDark
                                  ? styler.secondaryColor()
                                  : styler.primaryColor()),
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
                          bgColor: item.color(),
                          color: isChecked ? white : (isImage() ? black : Colors.grey.withOpacity(0.7)),
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
