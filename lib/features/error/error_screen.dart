import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../_providers/theme.dart';
import '../../_theme/spacing.dart';
import '../../_theme/variables.dart';
import '../../_widgets/buttons/button.dart';
import '../../_widgets/others/background.dart';
import '../../_widgets/others/icons.dart';
import '../../_widgets/others/images.dart';
import '../../_widgets/others/text.dart';
import '../user/_helpers/helpers.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBackground(
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
                  isSquare: true,
                  child: AppIcon(Icons.arrow_back_rounded),
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
                        AppImage('oops.png', height: 25.h, fit: BoxFit.fitHeight),
                        sph(),
                        AppText(size: normal, text: 'Lost in space.\n...', textAlign: TextAlign.center),
                        mph(),
                        AppButton(
                          onPressed: () => context.go('/'),
                          srp: true,
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
