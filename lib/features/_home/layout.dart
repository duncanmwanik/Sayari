import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../__styling/breakpoints.dart';
import '../../__styling/helpers.dart';
import '../../__styling/variables.dart';
import '../../_helpers/_common/helpers.dart';
import '../../_providers/common/theme.dart';
import '../../_providers/common/views.dart';
import '../../_variables/navigation.dart';
import '../_sessions/info_header.dart';
import '../chat/input_bar.dart';
import '_helpers/change_view.dart';
import '_w/left_box.dart';
import '_w/navbar_horizontal.dart';
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
                if (kIsWeb && showVertNav()) WebLeftBox(),
                //
                Expanded(
                  child: SafeArea(
                    child: Column(
                      children: [
                        //
                        Expanded(
                          child: Consumer<ViewsProvider>(builder: (context, views, child) {
                            return Title(
                              title: 'Sayari ${capitalFirst(views.view)}',
                              color: styler.accentColor(),
                              child: ScrollConfiguration(
                                behavior: scrollNoBars,
                                child: Stack(
                                  children: [
                                    // main view
                                    CustomScrollView(
                                      slivers: [
                                        //
                                        CustomAppBar(),
                                        //
                                        if (views.isSessions()) InfoHeader(),
                                        //
                                        SliverList(
                                          delegate: SliverChildListDelegate(
                                            [
                                              changeView(views.view),
                                            ],
                                          ),
                                        ),
                                        //
                                      ],
                                    ),
                                    //
                                    if (views.isChat()) MessageInputBar(),
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
