import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../_helpers/global.dart';
import '../../_helpers/navigation.dart';
import '../../_models/item.dart';
import '../../_services/hive/store.dart';
import '../../_theme/spacing.dart';
import '../../_theme/variables.dart';
import '../../_variables/features.dart';
import '../../_widgets/buttons/action.dart';
import '../../_widgets/others/text.dart';
import '../_spaces/_helpers/common.dart';
import 'new_tag.dart';
import 'tag.dart';
import 'var/tag_model.dart';

class TagManager extends StatefulWidget {
  const TagManager({
    super.key,
    this.item,
    this.isPopup = false,
    this.isSelection = false,
    this.onUpdate,
  });

  final Item? item;
  final bool isPopup;
  final bool isSelection;
  final Function(String)? onUpdate;

  @override
  State<TagManager> createState() => _TagManagerState();
}

class _TagManagerState extends State<TagManager> {
  List selectedTags = [];

  @override
  void initState() {
    if (widget.item != null) selectedTags = splitList(widget.item!.tags());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: storage(feature.tags).listenable(),
        builder: (context, box, wgt) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //
              Flexible(
                child: Padding(
                  padding: EdgeInsets.only(left: widget.isPopup ? 0 : 5, right: widget.isPopup ? 0 : 5),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //
                      if (isAdmin() && !widget.isSelection) NewTag(isPopup: widget.isPopup, isSelection: widget.isSelection),
                      if (isAdmin() && !widget.isSelection) tph(),
                      // default tags -----------------------------------------
                      if (!widget.isSelection)
                        TagItem(
                          tag: Tag(id: 'All'),
                          iconData: Icons.tag_rounded,
                          isPopup: widget.isPopup,
                          isDefault: true,
                        ),
                      if (!widget.isSelection)
                        TagItem(
                          tag: Tag(id: 'Archive'),
                          iconData: Icons.archive_rounded,
                          isPopup: widget.isPopup,
                          isDefault: true,
                        ),
                      if (!widget.isSelection)
                        TagItem(
                          tag: Tag(id: 'Trash'),
                          iconData: Icons.delete_rounded,
                          isPopup: widget.isPopup,
                          isDefault: true,
                        ),
                      // user tags  -----------------------------------------
                      for (String tagId in box.keys.toList())
                        TagItem(
                          tag: Tag(id: tagId),
                          isSelection: widget.isSelection,
                          isSelected: selectedTags.contains(tagId),
                          onSelect: () =>
                              setState(() => selectedTags.contains(tagId) ? selectedTags.remove(tagId) : selectedTags.add(tagId)),
                          isPopup: widget.isPopup,
                        ),
                      // empty user tags
                      if (box.isEmpty && widget.isSelection)
                        Padding(padding: pad(p: 15), child: AppText(text: 'No tags yet', size: tiny, faded: true)),
                      //
                    ],
                  ),
                ),
              ),
              //
              if (box.isNotEmpty && widget.isSelection) sph(),
              if (box.isNotEmpty && widget.isSelection)
                Align(
                  alignment: Alignment.bottomRight,
                  child: Wrap(
                    runSpacing: tinyHeight(),
                    children: [
                      ActionButton(isCancel: true),
                      ActionButton(label: 'Save', onPressed: () => popWhatsOnTop(todoLast: () => widget.onUpdate!(joinList(selectedTags)))),
                    ],
                  ),
                ),
              //
            ],
          );
        });
  }
}
