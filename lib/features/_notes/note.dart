import 'package:flutter/foundation.dart';
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
import '../../_widgets/items/hover_actions.dart';
import '../../_widgets/items/items.dart';
import '../../_widgets/items/selector.dart';
import '../files/file_overview.dart';
import '../share/_w/preview.dart';
import '_helpers/ontap.dart';
import '_w/text_overview.dart';
import 'feat/bookings/_w/overview.dart';
import 'feat/finance/_w/overview.dart';
import 'feat/forms/_w/overview.dart';
import 'feat/habits/overview.dart';
import 'feat/links/_w/overview.dart';
import 'feat/tasks/task.dart';

class Note extends StatelessWidget {
  const Note({super.key, required this.item});
  final Item item;

  @override
  Widget build(BuildContext context) {
    return Consumer<SelectionProvider>(builder: (_, selection, __) {
      bool isSelected = selection.isSelected(item.id);

      return MouseRegion(
        onEnter: (event) => state.hover.updateId(item.id),
        onExit: (event) => state.hover.updateId(''),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            //
            Card(
              elevation: 0,
              margin: kIsWeb ? itemPaddingMedium() : EdgeInsets.zero,
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
                  padding: itemPaddingLarge(bottom: !kIsWeb || !isNotPhone()),
                  constraints: BoxConstraints(minHeight: 70),
                  child: IgnorePointer(
                    ignoring: selection.isSelection,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          //
                          ImageOverview(item: item),
                          //
                          ItemHeader(item: item),
                          //
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: itemPaddingLarge(left: true, right: true),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //
                                  if (!item.hasTasks()) msph(),
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
                          if (kIsWeb && isNotPhone()) tph(),
                          if (kIsWeb && isNotPhone()) HoverActions(item: item),
                          //
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            //
            ItemSelector(item: item),
            //
          ],
        ),
      );
    });
  }
}
