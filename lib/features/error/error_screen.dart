import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../__styling/helpers.dart';
import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_providers/common/theme.dart';
import '../../_widgets/buttons/buttons.dart';
import '../../_widgets/others/icons.dart';
import '../../_widgets/others/images.dart';
import '../../_widgets/others/text.dart';
import '../user/_helpers/set_user_data.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: getImageBackgroundDecoration(),
      child: Scaffold(
        backgroundColor: transparent,
        body: Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // appbar
              Padding(
                padding: paddingM(),
                child: AppButton(
                  onPressed: () async => context.go('/'),
                  leading: Icons.arrow_back_rounded,
                  noStyling: true,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppIcon(Icons.arrow_back_rounded),
                      mpw(),
                      AppText(size: normal, text: 'Sayari Universe'),
                    ],
                  ),
                ),
              ),
              //
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppImage('oops.png', height: 25.h),
                        sph(),
                        AppText(
                          size: normal,
                          text: 'Lost in space.\n...',
                          weight: FontWeight.bold,
                          textAlign: TextAlign.center,
                        ),
                        mph(),
                        AppButton(
                          onPressed: () => context.go('/'),
                          smallRightPadding: true,
                          color: styler.accentColor(),
                          borderRadius: borderRadiusCrazy,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AppText(text: isSignedIn() ? 'Go Home' : 'Join Sayari', color: white, weight: FontWeight.bold),
                              spw(),
                              AppIcon(Icons.arrow_forward_rounded, size: 16, color: white),
                            ],
                          ),
                        ),
                        elph(),
                      ],
                    ),
                  ),
                ),
              ),
              //
            ],
          );
        }),
      ),
    );
  }
}
