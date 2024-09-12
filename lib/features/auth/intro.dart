import 'dart:async';

import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_variables/intro_features.dart';
import '../../_widgets/abcs/buttons/buttons.dart';
import '../../_widgets/others/icons.dart';
import '../../_widgets/others/images.dart';
import '../../_widgets/others/text.dart';

class AuthIntro extends StatefulWidget {
  const AuthIntro({super.key});

  @override
  State<AuthIntro> createState() => _WelcomeIntroState();
}

class _WelcomeIntroState extends State<AuthIntro> {
  Timer? timer;
  int index = 0;

  @override
  void initState() {
    timer = Timer.periodic(Duration(seconds: 5), (_) => setState(() => index = index < introFeatures.length - 1 ? index + 1 : 0));
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: itemPadding(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //
          lph(),
          //
          AppImage(
            imagePath: 'assets/images/${introFeatures[index].title.toLowerCase()}.png',
            height: 30.h,
            borderRadius: borderRadiusTinySmall,
            fit: BoxFit.fitHeight,
          ),
          //
          mph(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppButton(
                onPressed: () => setState(() => index = index > 0 ? index - 1 : introFeatures.length - 1),
                noStyling: true,
                isRound: true,
                child: AppIcon(Icons.keyboard_arrow_left, extraFaded: true),
              ),
              mpw(),
              Flexible(
                child: SizedBox(
                  width: 200,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppText(text: introFeatures[index].title, size: 20, fontWeight: FontWeight.w900),
                      sph(),
                      AppText(text: introFeatures[index].description, faded: true),
                    ],
                  ),
                ),
              ),
              mpw(),
              AppButton(
                onPressed: () => setState(() => index = index < introFeatures.length - 1 ? index + 1 : 0),
                noStyling: true,
                isRound: true,
                child: AppIcon(Icons.keyboard_arrow_right, extraFaded: true),
              ),
            ],
          ),
          mph(),
          //
        ],
      ),
    );
  }
}
