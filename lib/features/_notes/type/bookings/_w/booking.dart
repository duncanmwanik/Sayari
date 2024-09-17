import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../__styling/spacing.dart';
import '../../../../../__styling/variables.dart';
import '../../../../../_providers/common/input.dart';
import '../../../../../_providers/providers.dart';
import '../../../../../_variables/features.dart';
import '../../../../../_widgets/buttons/buttons.dart';
import '../../../../../_widgets/others/icons.dart';
import '../../../../../_widgets/others/text.dart';
import 'bookings_list.dart';
import 'copy_link.dart';
import 'date_times.dart';
import 'header.dart';

class Booking extends StatelessWidget {
  const Booking({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      bool isActive = input.data[feature.share.lt] == '1';
      bool isExpanded = input.data['ep'] == '1';

      return Visibility(
        visible: input.data[feature.bookings.lt] != null,
        child: Container(
          margin: padding(s: 'b'),
          padding: paddingM(),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadiusSmall),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //
              AppButton(
                onPressed: () => input.update('ep', isExpanded ? '0' : '1'),
                padding: paddingM(),
                color: styler.appColor(0.5),
                hoverColor: transparent,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AppIcon(Icons.settings, size: 16, faded: true),
                            spw(),
                            AppText(text: 'Booking Settings'),
                          ],
                        ),
                        //
                        Spacer(),
                        // hide/show settings
                        AppButton(
                          onPressed: () => input.update('ep', isExpanded ? '0' : '1'),
                          noStyling: true,
                          isSquare: true,
                          child: AppIcon(isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, size: 18, faded: true),
                        ),
                        //
                        //
                      ],
                    ),
                    //
                    if (isExpanded) sph(),
                    if (isExpanded) BookingDateTimes(),
                    if (isExpanded) mph(),
                    if (isExpanded) BookingHeader(),
                    if (isExpanded && isActive) sph(),
                    if (isExpanded && isActive) CopyLink(path: '/${features[state.views.itemsView]!.path}/${input.itemId}'),
                    //
                  ],
                ),
              ),
              //
              mph(),
              BookingsList(),
              //
            ],
          ),
        ),
      );
    });
  }
}
