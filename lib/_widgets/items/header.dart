import 'package:flutter/material.dart';

import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_models/item.dart';
import '../others/icons.dart';
import '../others/text.dart';
import 'emoji.dart';
import 'pinned.dart';
import 'published.dart';

class ItemHeader extends StatelessWidget {
  const ItemHeader({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 5, top: 5),
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
                if (item.hasTasks()) TaskEmoji(),
                if (item.hasTasks()) tpw(),
                //
                // title
                Flexible(
                    child: AppText(
                        size: medium,
                        text: item.title(),
                        bgColor: item.color(),
                        maxlines: 2,
                        fontWeight: FontWeight.w800)),
                //
                // if note is shared
                if (item.isShared()) spw(),
                if (item.isShared() && !item.isPublished())
                  AppIcon(Icons.share, size: 14, faded: true, bgColor: item.color()),
                //
                // if note is published
                if (item.isPublished()) PublishedLabel(item: item),
                //
              ],
            ),
          ),
          // if note is pinned
          if (!item.hasOverview()) PinnedIcon(item: item),
          //
        ],
      ),
    );
  }
}
