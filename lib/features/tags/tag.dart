import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../_helpers/navigation.dart';
import '../../_providers/_providers.dart';
import '../../_theme/spacing.dart';
import '../../_theme/variables.dart';
import '../../_widgets/buttons/button.dart';
import '../../_widgets/dialogs/confirmation_dialog.dart';
import '../../_widgets/others/checkbox.dart';
import '../../_widgets/others/icons.dart';
import '../../_widgets/others/text.dart';
import '_helpers/delete_tag.dart';
import '_helpers/helpers.dart';
import 'var/tag_model.dart';

class TagItem extends StatefulWidget {
  const TagItem({
    super.key,
    required this.tag,
    this.isSelection = false,
    this.isSelected = false,
    this.onSelect,
    this.isPopup = false,
    this.isDefault = false,
    this.iconData = labelIcon,
  });

  final Tag tag;
  final bool isSelection;
  final bool isSelected;
  final Function()? onSelect;
  final bool isPopup;
  final bool isDefault;
  final IconData iconData;

  @override
  State<TagItem> createState() => _TagItemState();
}

class _TagItemState extends State<TagItem> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    bool showDelete = !widget.isDefault && !widget.isSelection && isHovered;

    return Padding(
      padding: EdgeInsets.only(bottom: kIsWeb ? 2 : 0),
      child: AppButton(
        onPressed: widget.isSelection
            ? widget.onSelect
            : () {
                state.views.updateSelectedTag(widget.tag.id);
                if (widget.isPopup) popWhatsOnTop();
              },
        onHover: (value) => setState(() => isHovered = value),
        padding: EdgeInsets.only(
          left: widget.isSelection ? 10 : 10,
          right: showDelete ? 3 : (widget.isPopup ? 7 : 15),
          top: kIsWeb ? 1 : 6,
          bottom: kIsWeb ? 1 : 6,
        ),
        noStyling: !isSelectedTag(widget.tag.id) && !widget.isSelection,
        child: Row(
          children: [
            //
            widget.isSelection
                ? AppCheckBox(smallPadding: true, isChecked: widget.isSelected, onTap: widget.onSelect)
                : AppIcon(widget.iconData, faded: true, size: 16),
            mpw(),
            Expanded(child: AppText(text: widget.tag.name(), weight: FontWeight.w500, overflow: TextOverflow.ellipsis)),
            tpw(),
            AppButton(
              onPressed: showDelete
                  ? () => showConfirmationDialog(
                        title: 'Delete tag: <b>${widget.tag}</b>?',
                        yeslabel: 'Delete',
                        onAccept: () => deleteTag(widget.tag.id),
                      )
                  : null,
              noStyling: true,
              isSquare: true,
              child: AppIcon(Icons.close, color: showDelete ? null : transparent, faded: true, size: 16),
            ),
            //
          ],
        ),
        //
      ),
    );
  }
}
