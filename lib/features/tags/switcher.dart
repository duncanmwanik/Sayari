import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../_helpers/global.dart';
import '../../_providers/views.dart';
import '../../_theme/spacing.dart';
import '../../_theme/variables.dart';
import '../../_widgets/buttons/button.dart';
import '../../_widgets/others/svg.dart';
import '../../_widgets/others/text.dart';
import 'menu.dart';
import 'var/tag_model.dart';

class TagSwitcher extends StatelessWidget {
  const TagSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ViewsProvider>(builder: (context, tags, child) {
      Tag selectedTag = Tag(id: tags.selectedTag);

      return AppButton(
        menuItems: tagsMenu(
          onUpdate: (newTags) => newTags.isNotEmpty ? tags.updateSelectedTag(splitList(newTags).first) : null,
        ),
        isDropDown: true,
        svp: true,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(child: AppText(text: selectedTag.name())),
            spw(),
            AppSvg(dropDownSvg),
          ],
        ),
      );
    });
  }
}
