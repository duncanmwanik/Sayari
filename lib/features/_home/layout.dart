import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../__styling/breakpoints.dart';
import '../../__styling/helpers.dart';
import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_helpers/_common/helpers.dart';
import '../../_providers/theme.dart';
import '../../_providers/views.dart';
import '../../_widgets/others/others/scroll.dart';
import '../calendar/_helpers/date_time/date_info.dart';
import '../calendar/state/datetime.dart';
import '_helpers/change_view.dart';
import 'appbar.dart';
import 'navbars/navbar_horizontal.dart';
import 'panel/panel.dart';

class Applayout extends StatelessWidget {
  const Applayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer3<ThemeProvider, ViewsProvider, DateTimeProvider>(builder: (context, theme, views, dates, child) {
      return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
        return Align(
          alignment: Alignment.topCenter,
          child: Container(
            decoration: getImageBackgroundDecoration(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //
                if (isSmallPC()) Panel(),
                //
                Expanded(
                  child: SafeArea(
                    child: Column(
                      children: [
                        //
                        Expanded(
                          child: Title(
                            title: 'Sayari • ${capitalFirst(views.isCalendar() ? getDayInfo(dates.selectedDate) : views.view)}',
                            color: styler.accentColor(),
                            child: NoScrollBars(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  //
                                  CustomAppBar(),
                                  //
                                  Expanded(
                                    child: Container(
                                      width: double.infinity,
                                      margin: isSmallPC() ? paddingM('rb') : noPadding,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(borderRadiusSmall),
                                      ),
                                      child: changeView(views.view),
                                    ),
                                  ),
                                  //
                                ],
                              ),
                            ),
                          ),
                        ),
                        //
                        HorizontalNavigationBox(),
                        //
                      ],
                    ),
                  ),
                ),
                //
              ],
            ),
          ),
        );
      });
    });
  }
}
