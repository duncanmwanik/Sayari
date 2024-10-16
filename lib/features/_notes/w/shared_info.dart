import 'package:flutter/material.dart';

import '../../../_helpers/clipboard.dart';
import '../../../_helpers/helpers.dart';
import '../../../_models/item.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_widgets/buttons/button.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';

class SharedInfo extends StatelessWidget {
  const SharedInfo({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: (item.isShared() || item.isPublished()) && !isShare(),
      child: Padding(
        padding: EdgeInsets.only(top: 4.5),
        child: Wrap(
          spacing: tinyWidth(),
          runSpacing: tinyWidth(),
          children: [
            // shared
            if (item.isShared())
              AppButton(
                onPressed: () => copyText(item.sharedLink(), description: 'Copied shared link'),
                tooltip: 'Copy shared link',
                padding: paddingC('l5,r5,t3,b3'),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppIcon(Icons.share, faded: true, size: tiny),
                    tpw(),
                    AppText(text: 'Shared', bgColor: item.color(), size: tiny),
                  ],
                ),
              ),
            // published
            if (item.isPublished())
              AppButton(
                onPressed: () => copyText(item.publishedLink(), description: 'Copied blog link'),
                tooltip: 'Copy blog link',
                padding: paddingC('l5,r5,t3,b3'),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppIcon(Icons.article, faded: true, size: tiny),
                    tpw(),
                    AppText(text: 'Published', bgColor: item.color(), size: tiny),
                  ],
                ),
              ),
            //
          ],
        ),
      ),
    );
  }
}
