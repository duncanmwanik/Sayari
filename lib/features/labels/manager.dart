import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_helpers/navigation.dart';
import '../../_providers/_providers.dart';
import '../../_services/hive/get_data.dart';
import '../../_variables/features.dart';
import '../../_widgets/buttons/action.dart';
import '../../_widgets/others/text.dart';
import '../_spaces/_helpers/checks_space.dart';
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
        valueListenable: storage(feature.labels).listenable(),
        builder: (context, box, wdgt) {
          String selected = state.views.selectedLabel;

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
                      if (isAdmin() && !widget.isSelection) NewlabelInput(isPopup: widget.isPopup, isSelection: widget.isSelection),
                      if (isAdmin() && !widget.isSelection) tph(),
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
                          onSelect: () =>
                              setState(() => selectedLabels.contains(label) ? selectedLabels.remove(label) : selectedLabels.add(label)),
                          isPopup: widget.isPopup,
                        ),
                      // empty user labels
                      if (box.isEmpty && widget.isSelection)
                        Padding(padding: padding(p: 15), child: AppText(text: 'No labels yet', size: tiny, faded: true)),
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
                          widget.onDone!(selectedLabels);
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
