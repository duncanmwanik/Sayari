import 'package:flutter/material.dart';

import '../../__styling/breakpoints.dart';
import '../../__styling/helpers.dart';
import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_widgets/others/text.dart';
import '_blocks/delay.dart';
import '_blocks/if.dart';
import '_blocks/led_pin.dart';
import '_blocks/pin_state.dart';
import '_vars/descriptions.dart';
import '_w/widgets.dart';

class CodeView extends StatelessWidget {
  const CodeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isPhone() ? Alignment.topCenter : Alignment.topLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //
          // Blocks
          //
          if (isSmallPC())
            Container(
              padding: itemPadding(),
              margin: itemPadding(left: true),
              decoration: BoxDecoration(
                color: styler.appColor(isDark() ? 0.5 : 1),
                borderRadius: BorderRadius.circular(borderRadiusMedium),
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.zero,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //
                    AppText(text: 'Code Blocks', bold: true),
                    mph(),
                    DelayBlock(),
                    mph(),
                    LedColorBlock(),
                    mph(),
                    PinStateBlock(),
                    mph(),
                    IfBlock(),
                    mph(),
                    IfBlock(isWhile: true),
                    sph(),
                  ],
                ),
              ),
            ),
          //
          // Content
          //
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(top: 15, left: 15, right: 15),
              child: Column(
                children: [
                  //
                  AppText(text: 'Start', fontWeight: FontWeight.w900),
                  //
                  BlockSpeparator(),
                  //
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                        2,
                        (index) => Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                //
                                DelayBlock(),
                                //
                                BlockSpeparator(),
                                //
                                LedColorBlock(),
                                //
                                BlockSpeparator(),
                                //
                                PinStateBlock(),
                                //
                                BlockSpeparator(),
                                //
                                IfBlock(),
                                //
                                BlockSpeparator(),
                                //
                                IfBlock(isWhile: true),
                                //
                                BlockSpeparator(),
                                //
                              ],
                            )),
                  ),
                  //
                  AppText(text: 'End', fontWeight: FontWeight.w900),
                  //
                  mph(),
                  //
                  AppText(size: small, text: 'Repeat is ON', faded: true),
                  //
                  lpph(),
                  //
                ],
              ),
            ),
          ),
          //
          // Info
          //
          if (isSmallPC())
            Container(
              padding: itemPadding(),
              margin: itemPadding(right: true),
              decoration: BoxDecoration(
                color: styler.appColor(isDark() ? 0.5 : 1),
                borderRadius: BorderRadius.circular(borderRadiusMedium),
              ),
              width: 300,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //
                    HtmlText(text: delayDescription),
                    //
                  ],
                ),
              ),
            ),
          //
        ],
      ),
    );
  }
}
