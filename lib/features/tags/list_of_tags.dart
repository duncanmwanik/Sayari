import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../_helpers/global.dart';
import '../../_helpers/sync/quick_edit.dart';
import '../../_providers/_providers.dart';
import '../../_providers/input.dart';
import '../../_services/hive/store.dart';
import '../../_theme/helpers.dart';
import '../../_theme/spacing.dart';
import '../../_variables/features.dart';
import '../../_widgets/buttons/button.dart';
import '../../_widgets/others/others/other.dart';
import '../../_widgets/others/text.dart';
import 'menu.dart';
import 'var/tag_model.dart';

class TagList extends StatelessWidget {
  const TagList({super.key, this.tags, this.bgColor, this.id});

  final String? tags;
  final String? bgColor;
  final String? id;

  @override
  Widget build(BuildContext context) {
    bool isInput = tags == null;

    return Consumer<InputProvider>(builder: (context, input, child) {
      List tagList = splitList(tags ?? state.input.item.data['l']);

      Future<void> removeTag(String tagId) async {
        await Future.delayed(Duration.zero);
        tagList.remove(tagId);

        if (isInput) {
          state.input.update('l', joinList(tagList));
        } else {
          await quickEdit(parent: feature.notes, id: id!, key: 'l', value: joinList(tagList));
        }
      }

      return Visibility(
        visible: tagList.isNotEmpty,
        child: Padding(
          padding: paddingM('t'),
          child: Wrap(
              spacing: tinyWidth(),
              runSpacing: tinyWidth(),
              children: List.generate(tagList.length, (index) {
                Tag tag = Tag(id: tagList[index]);

                if (storage(feature.tags).containsKey(tag.id)) {
                  // tag
                  return AppButton(
                    menuItems: tagsMenu(
                      isSelection: true,
                      alreadySelected: tagList,
                      onDone: (newTags) async {
                        isInput
                            ? newTags.isNotEmpty
                                ? state.input.update('l', joinList(newTags))
                                : state.input.remove('l')
                            : await quickEdit(
                                parent: feature.notes, id: id!, key: newTags.isNotEmpty ? 'l' : 'd/l', value: joinList(newTags));
                      },
                    ),
                    color: hasColour(bgColor) ? Colors.white24 : null,
                    svp: true,
                    child: AppText(size: 11, text: tag.name(), bgColor: bgColor),
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
    });
  }
}
