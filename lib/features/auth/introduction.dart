import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_widgets/others/images.dart';
import '../../_widgets/others/text.dart';

class WelcomeIntro extends StatelessWidget {
  const WelcomeIntro({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //
        AppImage(imagePath: 'assets/images/sayari.png', size: imageSizeMedium),
        //
        mph(),
        //
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            //
            Padding(
              padding: EdgeInsets.only(bottom: 0),
              child: SizedBox(
                width: 60,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    DefaultTextStyle(
                      style: TextStyle(fontSize: medium, fontWeight: FontWeight.w500, color: styler.textColor()),
                      child: AnimatedTextKit(
                        repeatForever: true,
                        animatedTexts: [
                          TypewriterAnimatedText('Plan', speed: Duration(milliseconds: 150)),
                          TypewriterAnimatedText('Note', speed: Duration(milliseconds: 150)),
                          TypewriterAnimatedText('Learn', speed: Duration(milliseconds: 150)),
                          TypewriterAnimatedText('Play', speed: Duration(milliseconds: 150)),
                          TypewriterAnimatedText('Share', speed: Duration(milliseconds: 150)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //
            AppText(text: ' with Sayari.'),
            //
          ],
        )
//
      ],
    );
  }
}
