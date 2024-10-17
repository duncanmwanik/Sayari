import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../_models/features.dart';
import '../../_providers/_providers.dart';
import '../../_providers/focus.dart';
import '../../_theme/breakpoints.dart';
import '../../_widgets/others/blur.dart';
import '../../_widgets/others/others/other.dart';
import 'var/intro_features.dart';

class BackgroundCover extends StatefulWidget {
  const BackgroundCover({super.key});

  @override
  State<BackgroundCover> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<BackgroundCover> {
  Timer? timer;

  @override
  void initState() {
    timer = Timer.periodic(
      Duration(seconds: 10),
      (_) => state.focus.setIndex(state.focus.index < introFeatures.length - 1 ? state.focus.index + 1 : 0),
    );
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FocusProvider>(builder: (context, focus, child) {
      int index = focus.index;

      return Stack(
        children: [
          //
          for (IntroFeature introFeature in introFeatures)
            Opacity(
              opacity: index == introFeatures.indexOf(introFeature) ? 1 : 0,
              child: Container(
                width: double.maxFinite,
                height: double.maxFinite,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/${introFeature.title == '+ more' ? 'notes' : introFeature.title.toLowerCase()}.png'),
                    colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.darken),
                    fit: isPhone() ? BoxFit.cover : BoxFit.fill,
                  ),
                ),
                child: Blur(
                  blur: 5,
                  child: NoWidget(),
                ),
              ),
            ),
          //
        ],
      );
    });
  }
}
