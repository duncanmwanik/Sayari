import 'package:flutter/material.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_models/item.dart';
import '../../../_providers/_providers.dart';
import '../../../_widgets/others/text.dart';
import '../_helpers/ontap.dart';
import '../actions/actions.dart';
import 'emoji.dart';
import 'pinned.dart';

class ItemHeader extends StatelessWidget {
  const ItemHeader({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTapNote(item),
      onLongPress: state.selection.isSelected(item.id) ? null : () => onLongPressNote(item),
      borderRadius: BorderRadius.circular(borderRadiusTinySmall),
      hoverColor: transparent,
      focusColor: transparent,
      splashColor: transparent,
      highlightColor: transparent,
      child: Stack(
        children: [
          // header
          Padding(
            padding: paddingC('l10,t5,r5,b5'),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // emoji
                      if (item.isTask()) TaskEmoji(item: item),
                      if (item.isTask()) tpw(),
                      // title
                      Flexible(
                          child: Padding(
                        padding: EdgeInsets.only(top: 2),
                        child: AppText(
                          size: medium,
                          text: item.title(),
                          faded: !item.hasTitle(),
                          bgColor: item.color(),
                          maxlines: 2,
                          weight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )),
                      //
                    ],
                  ),
                ),
                //
                PinnedIcon(item: item)
                //
              ],
            ),
          ),
          //
          if (!item.hasOverview()) ItemActions(item: item),
          //
        ],
      ),
    );
  }
}
