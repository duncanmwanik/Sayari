import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../__styling/spacing.dart';
import '../../_helpers/_common/navigation.dart';
import '../../_providers/providers.dart';
import '../../_variables/features.dart';
import '../../_widgets/abcs/dialogs_sheets/dialog_buttons.dart';
import '../_tables/_helpers/checks_table.dart';
import '../_tables/_helpers/common.dart';
import 'label.dart';
import 'new_label.dart';

class LabelManager extends StatefulWidget {
  const LabelManager({
    super.key,
    this.isPopup = false,
    this.isSelection = false,
    this.alreadySelected = const [],
    this.onDone,
  });

  final bool isPopup;
  final bool isSelection;
  final List alreadySelected;
  final Function(List newLabels)? onDone;

  @override
  State<LabelManager> createState() => _LabelManagerState();
}

class _LabelManagerState extends State<LabelManager> {
  List selectedLabels = [];

  @override
  void initState() {
    if (widget.alreadySelected.isNotEmpty) {
      selectedLabels = widget.alreadySelected;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box('${liveTable()}_${feature.labels.t}').listenable(),
        builder: (context, box, wdgt) {
          String selected = state.labels.selectedLabel;

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //
              if (widget.isSelection)
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
                          if (selectedLabels.isNotEmpty) widget.onDone!(selectedLabels);
                        },
                      ),
                      //
                    ],
                  ),
                ),
              //
              sph(),
              //
              Flexible(
                child: Padding(
                  padding: EdgeInsets.only(left: widget.isPopup ? 0 : 5, right: widget.isPopup ? 0 : 5),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //
                      // if (isAdmin() && kIsWeb && !widget.isSelection) tph(),
                      // if (isAdmin() && !widget.isSelection) NewlabelInput(isPopup: widget.isPopup, isSelection: widget.isSelection),
                      // if (isAdmin() && kIsWeb && !widget.isSelection) tph(),
                      // default labels -----------------------------------------
                      if (!widget.isSelection)
                        LabelItem(
                          label: 'All',
                          iconData: Icons.label_rounded,
                          isSelected: selected == 'All',
                          isPopup: widget.isPopup,
                          isDefault: true,
                        ),
                       if (!widget.isSelection)
                        LabelItem(
                          label: 'Archive',
                          iconData: Icons.archive_rounded,
                          isSelected: selected == 'Archive',
                          isPopup: widget.isPopup,
                          isDefault: true,
                        ),
                       if (!widget.isSelection)
                        LabelItem(
                          label: 'Trash',
                          iconData: Icons.delete_rounded,
                          isSelected: selected == 'Trash',
                          isPopup: widget.isPopup,
                          isDefault: true,
                        ),
                      // user labels  -----------------------------------------
                      for (String label in box.keys.toList())
                        LabelItem(
                          label: label,
                          isSelection: widget.isSelection,
                          isSelected: selectedLabels.contains(label),
                          onSelect: () => setState(() => selectedLabels.contains(label) ? selectedLabels.remove(label) : selectedLabels.add(label)),
                          isPopup: widget.isPopup,
                        ),
                      //
                    ],
                  ),
                ),
              ),
              //
            ],
          );
        });
  }
}
