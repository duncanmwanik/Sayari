import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../_helpers/navigation.dart';
import '../../_providers/_providers.dart';
import '../../_services/hive/store.dart';
import '../../_theme/spacing.dart';
import '../../_theme/variables.dart';
import '../../_variables/features.dart';
import '../../_widgets/buttons/action.dart';
import '../../_widgets/others/text.dart';
import '../_spaces/_helpers/common.dart';
import 'new_tag.dart';
import 'tag.dart';

class TagManager extends StatefulWidget {
  const TagManager({
    super.key,
    this.isPopup = false,
    this.isSelection = false,
    this.alreadySelected = const [],
    this.onDone,
  });

  final bool isPopup;
  final bool isSelection;
  final List alreadySelected;
  final Function(List newTags)? onDone;

  @override
  State<TagManager> createState() => _TagManagerState();
}

class _TagManagerState extends State<TagManager> {
  List selectedTags = [];

  @override
  void initState() {
    if (widget.alreadySelected.isNotEmpty) {
      selectedTags = widget.alreadySelected;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: storage(feature.tags).listenable(),
        builder: (context, box, wgt) {
          String selected = state.views.selectedTag;

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
                          tag: 'All',
                          iconData: Icons.tag_rounded,
                          isSelected: selected == 'All',
                          isPopup: widget.isPopup,
                          isDefault: true,
                        ),
                      if (!widget.isSelection)
                        TagItem(
                          tag: 'Archive',
                          iconData: Icons.archive_rounded,
                          isSelected: selected == 'Archive',
                          isPopup: widget.isPopup,
                          isDefault: true,
                        ),
                      if (!widget.isSelection)
                        TagItem(
                          tag: 'Trash',
                          iconData: Icons.delete_rounded,
                          isSelected: selected == 'Trash',
                          isPopup: widget.isPopup,
                          isDefault: true,
                        ),
                      // user tags  -----------------------------------------
                      for (String tagId in box.keys.toList())
                        TagItem(
                          tag: tagId,
                          isSelection: widget.isSelection,
                          isSelected: selectedTags.contains(tagId),
                          onSelect: () =>
                              setState(() => selectedTags.contains(tagId) ? selectedTags.remove(tagId) : selectedTags.add(tagId)),
                          isPopup: widget.isPopup,
                        ),
                      // empty user tags
                      if (box.isEmpty && widget.isSelection)
                        Padding(padding: padding(p: 15), child: AppText(text: 'No tags yet', size: tiny, faded: true)),
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
                      //
                      ActionButton(isCancel: true),
                      ActionButton(
                        label: 'Save',
                        onPressed: () {
                          popWhatsOnTop();
                          widget.onDone!(selectedTags);
                        },
                      ),
                      //
                    ],
                  ),
                ),
              //
            ],
          );
        });
  }
}
