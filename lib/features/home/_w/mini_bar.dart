import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_providers/providers.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/abcs/buttons/buttons.dart';
import '../../../_widgets/others/text.dart';
import '../_helpers/change_view.dart';

class MiniBar extends StatelessWidget {
  const MiniBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadiusLarge),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
        child: Container(
          height: 30,
          padding: EdgeInsets.symmetric(horizontal: 10),
          color: styler.navColor(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //
              Expanded(
                child: AppButton(
                  onPressed: () => goToView(feature.notes.t),
                  height: 20,
                  color: state.views.isNotes() ? null : transparent,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: AppText(text: 'Notes', textAlign: TextAlign.center),
                ),
              ),
              //
              spw(),
              //
              Expanded(
                child: AppButton(
                  onPressed: () => goToView(feature.finance.t),
                  height: 20,
                  color: state.views.isFinance() ? null : transparent,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: AppText(text: 'Finances', textAlign: TextAlign.center),
                ),
              ),
              //
              spw(),
              //
              Expanded(
                child: AppButton(
                  onPressed: () => goToView(feature.lists.t),
                  height: 20,
                  color: state.views.isList() ? null : transparent,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: AppText(text: 'Habits', textAlign: TextAlign.center),
                ),
              ),
              //
            ],
          ),
        ),
      ),
    );
  }
}
