import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_helpers/_common/navigation.dart';
import '../../_providers/providers.dart';
import '../../_widgets/buttons/buttons.dart';
import '../../_widgets/dialogs/confirmation_dialog.dart';
import '../../_widgets/others/checkbox.dart';
import '../../_widgets/others/icons.dart';
import '../../_widgets/others/text.dart';
import '_helpers/delete_label.dart';

class LabelItem extends StatefulWidget {
  const LabelItem({
    super.key,
    required this.label,
    this.isSelection = false,
    this.isSelected = false,
    this.onSelect,
    this.isPopup = false,
    this.isDefault = false,
    this.iconData = labelIcon,
  });

  final String label;
  final bool isSelection;
  final bool isSelected;
  final Function()? onSelect;
  final bool isPopup;
  final bool isDefault;
  final IconData iconData;

  @override
  State<LabelItem> createState() => _LabelItemState();
}

class _LabelItemState extends State<LabelItem> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    bool isCurrentLabel = widget.label == state.views.selectedLabel;
    bool showDelete = !widget.isDefault && !widget.isSelection && isHovered;

    return Padding(
      padding: EdgeInsets.only(bottom: kIsWeb ? 2 : 0),
      child: Material(
        color: transparent,
        child: InkWell(
          onTap: widget.isSelection
              ? widget.onSelect
              : () {
                  state.views.updateSelectedLabel(widget.label);
                  if (widget.isPopup) {
                    popWhatsOnTop();
                  }
                },
          onHover: (value) => setState(() => isHovered = value),
          borderRadius: BorderRadius.circular(widget.isSelection ? borderRadiusSmall : borderRadiusLarge),
          child: Container(
            padding: EdgeInsets.only(
              left: widget.isSelection ? 10 : 15,
              right: showDelete ? 3 : (widget.isPopup ? 7 : 15),
              top: kIsWeb ? 3 : 6,
              bottom: kIsWeb ? 3 : 6,
            ),
            decoration: BoxDecoration(
              color: isCurrentLabel && !widget.isSelection ? styler.appColor(1) : null,
              borderRadius: BorderRadius.circular(borderRadiusLarge),
            ),
            child: Row(
              children: [
                //
                widget.isSelection
                    ? AppCheckBox(smallPadding: true, isChecked: widget.isSelected, onTap: widget.onSelect)
                    : AppIcon(widget.iconData, faded: true, size: 18),
                mpw(),
                Expanded(child: AppText(text: widget.label, weight: FontWeight.w500, overflow: TextOverflow.ellipsis)),
                tpw(),
                AppButton(
                  onPressed: showDelete
                      ? () => showConfirmationDialog(
                            title: 'Delete label: <b>${widget.label}</b>?',
                            yeslabel: 'Delete',
                            onAccept: () => deleteLabel(widget.label),
                          )
                      : null,
                  noStyling: true,
                  isRound: true,
                  child: AppIcon(
                    Icons.close,
                    color: showDelete ? null : transparent,
                    faded: kIsWeb,
                    extraFaded: !kIsWeb,
                    size: 16,
                  ),
                ),
                //
              ],
            ),
          ),
          //
        ),
      ),
    );
  }
}
