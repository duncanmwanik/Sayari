import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../__styling/breakpoints.dart';
import '../../__styling/helpers.dart';
import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_helpers/helpers.dart';
import '../../_models/item.dart';
import '../../_providers/_providers.dart';
import '../../_widgets/others/others/divider.dart';
import '../bookings/_w/overview.dart';
import '../files/overview.dart';
import '../finance/_w/overview.dart';
import '../habits/overview.dart';
import '../links/_w/overview.dart';
import '../tasks/task.dart';
import '_helpers/ontap.dart';
import 'quill/overview_editor.dart';
import 'state/selection.dart';
import 'w/details.dart';
import 'w/header.dart';
import 'w/shared_info.dart';

class Note extends StatelessWidget {
  const Note({super.key, required this.item});
  final Item item;

  @override
  Widget build(BuildContext context) {
    return Consumer<SelectionProvider>(builder: (_, selection, __) {
      bool isSelection = selection.isSelection;
      bool isSelected = selection.isSelected(item.id);
      bool isGrid = state.views.isGrid();
      bool isRow = state.views.isRow();
      bool isColumn = state.views.isColumn();

      return SizedBox(
        width: isRow ? 500 : (isColumn ? 270 : (isTabAndBelow() ? 45.w : 240)),
        height: isGrid ? 320 : null,
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: isRow ? 200 : 320),
          child: MouseRegion(
            onEnter: (event) => isShare() ? null : state.focus.set(item.id),
            onExit: (event) => isShare() ? null : state.focus.reset(),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(borderRadiusTinySmall),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                child: Card(
                  elevation: 0,
                  margin: EdgeInsets.zero,
                  color: styler.getItemColor(item.color(), false, isShadeColor: true),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadiusTinySmall),
                    side: BorderSide(
                      color: isSelected ? styler.accentColor() : Colors.grey.withOpacity(0.4),
                      width: isSelected ? 2 : (styler.isDark ? 0.3 : 0.7),
                    ),
                  ),
                  child: InkWell(
                    onTap: item.isTask() && !isSelection ? null : () => onTapNote(item),
                    onLongPress: isSelected || (item.isTask() && !isSelection) ? null : () => onLongPressNote(item),
                    borderRadius: BorderRadius.circular(borderRadiusTinySmall),
                    hoverColor: styler.appColor(isImage() ? 0.5 : (styler.isDark ? 0.2 : 0.3)),
                    focusColor: transparent,
                    splashColor: transparent,
                    highlightColor: transparent,
                    child: IgnorePointer(
                      ignoring: selection.isSelection,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          //
                          ImageOverview(item: item),
                          ItemHeader(item: item),
                          tph(),
                          Padding(padding: paddingS('lr'), child: AppDivider()),
                          //
                          Flexible(
                            child: Padding(
                              padding: padding(s: 'lrb'),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SharedInfo(item: item),
                                  ItemDetails(item: item),
                                  if (item.hasFinances()) FinanceOverview(item: item),
                                  if (item.hasBookings()) BookingOverview(item: item),
                                  if (item.hasHabits()) HabitOverview(item: item),
                                  if (item.hasLinks()) LinksOverview(item: item),
                                  if (item.showEditorOverview()) Flexible(child: NoteEditorOverview(item: item)),
                                  if (item.isTask()) Flexible(child: NoteTask(item: item)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
