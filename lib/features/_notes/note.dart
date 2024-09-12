import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../__styling/breakpoints.dart';
import '../../__styling/helpers.dart';
import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_helpers/_common/helpers.dart';
import '../../_models/item.dart';
import '../../_providers/common/selection.dart';
import '../../_providers/providers.dart';
import '../../_variables/features.dart';
import '../../_widgets/others/others/divider.dart';
import '../_spaces/_helpers/common.dart';
import '../files/overview.dart';
import '../share/_w/preview.dart';
import '_helpers/ontap.dart';
import '_w/text_overview.dart';
import 'items/details.dart';
import 'items/header.dart';
import 'items/hover_actions.dart';
import 'types/bookings/_w/overview.dart';
import 'types/finance/_w/overview.dart';
import 'types/habits/overview.dart';
import 'types/links/_w/overview.dart';
import 'types/tasks/_w_item/new_item.dart';
import 'types/tasks/task.dart';

class Note extends StatelessWidget {
  const Note({super.key, required this.item});
  final Item item;

  @override
  Widget build(BuildContext context) {
    return Consumer<SelectionProvider>(builder: (_, selection, __) {
      bool isSelected = selection.isSelected(item.id);
      bool showHover = isNotPhone() && !isShare();

      return Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: 400,
          child: MouseRegion(
            onEnter: (event) => state.hover.set(item.id),
            onExit: (event) => state.hover.reset(),
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
                onTap: () => onTapNote(item),
                onLongPress: isSelected ? null : () => onLongPressNote(item),
                borderRadius: BorderRadius.circular(borderRadiusTinySmall),
                hoverColor: styler.appColor(isImageTheme() ? 0.5 : (styler.isDark ? 0.2 : 0.3)),
                focusColor: transparent,
                child: Container(
                  constraints: BoxConstraints(minHeight: 100),
                  child: IgnorePointer(
                    ignoring: selection.isSelection,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        //
                        ImageOverview(item: item),
                        //
                        ItemHeader(item: item),
                        tph(),
                        AppDivider(height: 0, thickness: 1, color: styler.appColor(isDark() ? 1 : 1.5)),
                        //
                        Flexible(
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                //
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding:
                                        item.hasTasks() ? itemPaddingMedium(left: true, right: true) : itemPadding(left: true, right: true),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        //
                                        item.hasTasks() ? ph(2) : msph(),
                                        if (item.hasFinances()) FinanceOverview(item: item),
                                        if (item.hasBookings()) BookingOverview(item: item),
                                        if (item.hasHabits()) HabitOverview(item: item),
                                        if (item.hasLinks()) LinksOverview(item: item),
                                        if (item.showEditorOverview()) NoteTextOverview(item: item),
                                        if (item.hasDetails()) ItemDetails(item: item),
                                        if (item.hasTasks()) NoteTask(item: item),
                                        if (item.isShared() && !isShare()) tph(),
                                        if (item.isShared() && !isShare()) PreviewNote(item: item),
                                        // temp
                                        if (item.id == '1724578910529' && !isShare()) sph(),
                                        if (item.id == '1724578910529' && !isShare())
                                          PreviewNote(
                                            item: item,
                                            label: 'View Published Book',
                                            path: '/${features[feature.space.lt]!.path}/${liveSpace()}',
                                          ),
                                        //
                                      ],
                                    ),
                                  ),
                                ),
                                //
                              ],
                            ),
                          ),
                        ),
                        // new task entry
                        if (item.hasTasks()) ph(2),
                        if (item.hasTasks()) NewItemInput(item: item),
                        // on-hover actions
                        showHover ? tph() : sph(),
                        if (showHover) HoverActions(item: item),
                        //
                        if (isShare()) sph(),
                      ],
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
