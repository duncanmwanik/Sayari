import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../__styling/breakpoints.dart';
import '../../__styling/helpers.dart';
import '../../_providers/common/theme.dart';
import '../../_providers/common/views.dart';
import '../_sessions/info_header.dart';
import '_helpers/change_view.dart';
import '_w/appbar.dart';
import '_w/navbar_horizontal.dart';
import '_w_web/left_box.dart';

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
                        Expanded(
                          child: Consumer<ViewsProvider>(builder: (context, views, child) {
                            return CustomScrollView(
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
                            );
                          }),
                        ),
                        if (!showVertNav()) HorizontalNavigationBox()
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
