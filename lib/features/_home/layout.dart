import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../__styling/breakpoints.dart';
import '../../__styling/helpers.dart';
import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_helpers/_common/helpers.dart';
import '../../_providers/common/theme.dart';
import '../../_providers/common/views.dart';
import '../../_widgets/others/others/scroll.dart';
import '_helpers/change_view.dart';
import 'appbar.dart';
import 'navbars/navbar_horizontal.dart';
import 'panel/panel.dart';

class Applayout extends StatelessWidget {
  const Applayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeProvider, ViewsProvider>(builder: (context, theme, views, child) {
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
                            title: 'Sayari | ${capitalFirst(views.isItems() ? 'space' : views.view)}',
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
                                      margin: partitionPadding(right: isSmallPC(), bottom: isSmallPC()),
                                      padding: partitionPadding(
                                        left: !views.isCalendar(),
                                        right: !views.isCalendar(),
                                        top: !views.isCalendar() && !views.isItems(),
                                        bottom: isSmallPC(),
                                      ),
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
