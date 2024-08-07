import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../__styling/breakpoints.dart';
import '../../__styling/helpers.dart';
import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_models/item.dart';
import '../../_providers/common/selection.dart';
import '../../_providers/providers.dart';
import '../../_variables/features.dart';
import '../../_widgets/items/details.dart';
import '../../_widgets/items/header.dart';
import '../../_widgets/items/hover_actions.dart';
import '../../_widgets/others/others/divider.dart';
import '../files/overview.dart';
import '../share/_w/preview.dart';
import '_helpers/ontap.dart';
import '_w/text_overview.dart';
import 'feat/bookings/_w/overview.dart';
import 'feat/finance/_w/overview.dart';
import 'feat/forms/_w/overview.dart';
import 'feat/habits/overview.dart';
import 'feat/links/_w/overview.dart';
import 'feat/tasks/_w_item/new_item.dart';
import 'feat/tasks/task.dart';

class Note extends StatelessWidget {
  const Note({super.key, required this.item});
  final Item item;

  @override
  Widget build(BuildContext context) {
    return Consumer<SelectionProvider>(builder: (_, selection, __) {
      bool isSelected = selection.isSelected(item.id);

      return Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: 500,
          child: MouseRegion(
            onEnter: (event) => state.hover.updateId(item.id),
            onExit: (event) => state.hover.updateId(''),
            child: Card(
              elevation: 0,
              margin: EdgeInsets.zero,
              color: styler.getItemColor(item.color(), false, isShadeColor: true),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: isSelected
                      ? styler.accentColor()
                      : Colors.grey.withOpacity(styler.isDark && !isBlackTheme() ? 0.05 : 0.4),
                  width: isSelected ? 2 : (styler.isDark ? 0.3 : 0.7),
                ),
                borderRadius: BorderRadius.circular(borderRadiusSmall),
              ),
              child: InkWell(
                onTap: () => onTapNote(item),
                onLongPress: isSelected ? null : () => onLongPressNote(item),
                borderRadius: BorderRadius.circular(borderRadiusSmall),
                hoverColor: styler.appColor(isImageTheme() ? 0.5 : (styler.isDark ? 0.1 : 0.3)),
                focusColor: transparent,
                child: Container(
                  constraints: BoxConstraints(minHeight: 70),
                  child: IgnorePointer(
                    ignoring: selection.isSelection,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        //
                        ImageOverview(item: item),
                        //
                        ItemHeader(item: item),
                        if (!item.hasTasks()) tph(),
                        if (!item.hasTasks()) AppDivider(height: 0),
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
                                    padding: item.hasTasks()
                                        ? itemPaddingMedium(left: true, right: true)
                                        : itemPadding(left: true, right: true),
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
                                        if (item.hasForms()) FormsOverview(item: item),
                                        if (item.showEditor()) NoteTextOverview(item: item),
                                        if (item.hasDetails()) ItemDetails(item: item),
                                        if (item.hasTasks()) NoteTask(item: item),
                                        if (item.isPublished()) lph(),
                                        if (item.isPublished()) PreviewNote(path: '/${feature.share.t}/${item.id}'),
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
                        //
                        // new task entry
                        if (item.hasTasks()) ph(2),
                        if (item.hasTasks()) NewItemInput(item: item),
                        //m
                        // on-hover actions
                        if (isNotPhone()) tph(),
                        if (isNotPhone()) HoverActions(item: item),
                        //
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
