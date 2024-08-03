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
import '../../_variables/navigation.dart';
import '../_notes/_w/note_options.dart';
import '../_sessions/info_header.dart';
import '_helpers/change_view.dart';
import '_w/navbar_horizontal.dart';
import '_w/panel.dart';
import 'appbar.dart';

class Applayout extends StatelessWidget {
  const Applayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
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
                          child: Consumer<ViewsProvider>(builder: (context, views, child) {
                            return Title(
                              title: 'Sayari | ${capitalFirst(views.view)}',
                              color: styler.accentColor(),
                              child: ScrollConfiguration(
                                behavior: scrollNoBars,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    //
                                    CustomAppBar(),
                                    //
                                    if (views.isSessions()) InfoHeader(),
                                    if (views.isNotes()) NoteOptions(),
                                    //
                                    Expanded(
                                      child: Container(
                                        width: double.infinity,
                                        margin: partitionPadding(right: isSmallPC(), bottom: isSmallPC()),
                                        padding: partitionPadding(
                                          left: !views.isSessions(),
                                          right: !views.isSessions(),
                                          top: true,
                                          bottom: isSmallPC(),
                                        ),
                                        decoration: BoxDecoration(
                                          // color: isSmallPC() ? styler.appColor(0.5) : null,
                                          borderRadius: BorderRadius.circular(borderRadiusSmall),
                                        ),
                                        child: changeView(views.view),
                                      ),
                                    ),
                                    //
                                  ],
                                ),
                              ),
                            );
                          }),
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
