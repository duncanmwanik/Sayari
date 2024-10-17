import 'package:flutter/material.dart';

import '../../_helpers/global.dart';
import '../../_models/item.dart';
import '../../_services/hive/store.dart';
import '../../_theme/spacing.dart';
import '../../_theme/variables.dart';
import '../../_variables/features.dart';
import '../../_widgets/buttons/button.dart';
import '../../_widgets/others/others/other.dart';
import '../../_widgets/others/text.dart';
import 'menu.dart';
import 'var/tag_model.dart';

class TagList extends StatelessWidget {
  const TagList({super.key, required this.item, required this.onUpdate});

  final Item item;
  final Function(String) onUpdate;

  @override
  Widget build(BuildContext context) {
    List tagList = splitList(item.tags());

    Future<void> removeTag(String tagId) async {
      await Future.delayed(Duration.zero);
      tagList.remove(tagId);
      onUpdate(joinList(tagList));
    }

    return Visibility(
      visible: tagList.isNotEmpty,
      child: Padding(
        padding: padM('t'),
        child: Wrap(
            spacing: tinyWidth(),
            runSpacing: tinyWidth(),
            children: List.generate(tagList.length, (index) {
              Tag tag = Tag(id: tagList[index]);

              // good tag
              if (storage(feature.tags).containsKey(tag.id)) {
                return AppButton(
                  menuItems: tagsMenu(item: item, isSelection: true, onUpdate: onUpdate),
                  showBorder: item.hasColor(),
                  svp: true,
                  child: AppText(size: tinySmall, text: tag.name(), bgColor: item.color()),
                );
              }
              // if tag is missing
              else {
                removeTag(tag.id);
                return NoWidget();
              }
            })),
      ),
    );
  }
}
