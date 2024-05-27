import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../__styling/breakpoints.dart';
import '../../__styling/spacing.dart';
import '_w/device_panel.dart';
import '_w/hub_views.dart';
import '_w/tools.dart';
import '_w/view_picker.dart';

class HubView extends StatelessWidget {
  const HubView({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isPhone() ? Alignment.topCenter : Alignment.topLeft,
      child: SingleChildScrollView(
        padding: EdgeInsets.only(top: 5, left: 15, right: 15, bottom: largeHeightPlaceHolder()),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //
            DevicePanel(),
            //
            msph(),
            //
            HubViewPicker(),
            //
            msph(),
            //
            HubTools(),
            //
            mph(),
            //
            HubViews(),
            //
          ],
        ),
      ),
    );
  }
}
