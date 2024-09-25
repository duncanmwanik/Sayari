import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../__styling/spacing.dart';
import '../../../../__styling/variables.dart';
import '../../../../_models/item.dart';
import '../../../../_providers/input.dart';
import '../../../../_widgets/buttons/button.dart';
import '../../../../_widgets/others/icons.dart';
import '../../../../_widgets/others/text.dart';
import '../../../calendar/_helpers/date_time/date_info.dart';
import '../../../calendar/_helpers/date_time/misc.dart';

class CheckedDates extends StatelessWidget {
  const CheckedDates({super.key, this.item});

  final Item? item;

  @override
  Widget build(BuildContext context) {
    bool isInput = item == null;

    return Consumer<InputProvider>(builder: (context, input, child) {
      Map data = item != null ? item!.data : input.data;
      List checkedDates = data.keys.where((key) => key.toString().startsWith('hc')).toList();
      bool isExpanded = data['he'] == '1';

      return Visibility(
        visible: isInput,
        child: Padding(
          padding: padding(s: 't'),
          child: Column(
            children: [
              //
              Align(
                alignment: Alignment.centerRight,
                child: AppButton(
                  onPressed: () => input.update('he', isExpanded ? '0' : '1'),
                  noStyling: true,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppText(text: isExpanded ? 'See less' : 'See more'),
                      spw(),
                      AppIcon(isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, size: 16, faded: true),
                    ],
                  ),
                ),
              ),
              //
              sph(),
              //
              Visibility(
                visible: isExpanded,
                child: checkedDates.isNotEmpty
                    ? Column(
                        children: List.generate(checkedDates.length, (index) {
                          String checkedDate = checkedDates[index];

                          return Padding(
                            padding: EdgeInsets.only(top: 4),
                            child: AppButton(
                              onPressed: () {},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  AppText(text: getDayInfo(checkedDate.substring(2))),
                                  Flexible(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        AppIcon(Icons.tag_rounded, size: 16, color: styler.accentColor()),
                                        Flexible(child: AppText(text: getEditDateTime(data[checkedDate]))),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      )
                    : Center(child: AppText(text: 'Check dates to see them here', size: small, faded: true)),
              ),
            ],
          ),
        ),
      );
    });
  }
}
