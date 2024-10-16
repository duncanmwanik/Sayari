import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../_providers/views.dart';
import '../../_theme/spacing.dart';
import '../../_theme/variables.dart';
import '../../_widgets/buttons/button.dart';
import '../../_widgets/others/svg.dart';
import '../../_widgets/others/text.dart';
import 'menu.dart';

class TagSelector extends StatelessWidget {
  const TagSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ViewsProvider>(builder: (context, tags, child) {
      return AppButton(
        menuItems: tagsMenu(onDone: (newTags) => tags.updateSelectedTag(newTags.first)),
        isDropDown: true,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(child: AppText(text: tags.selectedTag)),
            spw(),
            AppSvg(dropDownSvg),
          ],
        ),
      );
    });
  }
}
