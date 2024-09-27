import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../__styling/breakpoints.dart';
import '../../../__styling/helpers.dart';
import '../../../__styling/variables.dart';
import '../../_spaces/manager/manager.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: isPhone() ? 80.w : 350,
      backgroundColor: transparent,
      elevation: 0,
      surfaceTintColor: transparent,
      shape: RoundedRectangleBorder(),
      child: Container(
        decoration: backgroundImage(),
        child: SpaceManager(),
      ),
    );
  }
}
