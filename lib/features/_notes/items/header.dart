import 'package:flutter/material.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_helpers/_common/helpers.dart';
import '../../../_models/item.dart';
import '../../../_widgets/buttons/buttons.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';
import 'emoji.dart';
import 'item_actions.dart';
import 'published.dart';

class ItemHeader extends StatelessWidget {
  const ItemHeader({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                    //
                    // emoji
                    if (item.isTask()) TaskEmoji(item: item),
                    if (item.isTask()) tpw(),
                    //
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
                        fontWeight: FontWeight.w800,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )),
                    //
                    // if note is shared
                    if (item.isShared() && !isShare()) spw(),
                    if (item.isShared() && !item.isPublished() && !isShare())
                      AppButton(
                        noStyling: true,
                        isSquare: true,
                        child: AppIcon(Icons.share, size: 14, faded: true, bgColor: item.color()),
                      ),
                    //
                    // if note is published
                    if (item.isPublished() && !isShare()) PublishedLabel(item: item),
                    //
                  ],
                ),
              ),
              // if note is pinned
              // if (!item.hasOverview() && !isShare()) PinnedIcon(item: item),
              //
            ],
          ),
        ),
        //
        Positioned(right: 5, top: 5, child: ItemActions(item: item)),
        //
      ],
    );
  }
}
