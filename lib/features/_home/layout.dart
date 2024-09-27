import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../__styling/breakpoints.dart';
import '../../__styling/helpers.dart';
import '../../__styling/variables.dart';
import '../../_helpers/helpers.dart';
import '../../_providers/theme.dart';
import '../../_providers/views.dart';
import '../../_widgets/others/others/scroll.dart';
import '../calendar/_helpers/date_time/date_info.dart';
import '../calendar/state/datetime.dart';
import 'appbar.dart';
import 'navbars/navbar_horizontal.dart';
import 'panel/panel.dart';
import 'view.dart';

class AppLayout extends StatelessWidget {
  const AppLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer3<ThemeProvider, ViewsProvider, DateTimeProvider>(builder: (context, theme, views, dates, child) {
      return Container(
        decoration: backgroundImage(),
        alignment: Alignment.topCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // nav panel
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
                              // appbar
                              CustomAppBar(),
                              // view
                              Expanded(child: AppView(view: views.view)),
                              //
                            ],
                          ),
                        ),
                      ),
                    ),
                    // bottom navbar
                    HorizontalNavigationBox(),
                    //
                  ],
                ),
              ),
            ),
            //
          ],
        ),
      );
    });
  }
}
