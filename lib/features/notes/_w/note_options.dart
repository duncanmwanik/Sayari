import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../__styling/spacing.dart';
import '../../../__styling/variables.dart';
import '../../../_providers/common/views.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/abcs/buttons/buttons.dart';
import '../../../_widgets/others/text.dart';

class NoteOptions extends StatelessWidget {
  const NoteOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ViewsProvider>(builder: (context, views, child) {
      return Visibility(
        visible: views.isNotes(),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              //
              option('Notes', feature.notes.lt),
              option('Finances', feature.finances.lt),
              option('Habits', feature.habits.lt),
              option('Links', feature.links.lt),
              option('Portfolio', feature.portfolios.lt),
              option('Forms', feature.forms.lt),
              option('Bookings', feature.bookings.lt),
              lpw(),
              //
            ],
          ),
        ),
      );
    });
  }
}

Widget option(String label, String type) => Consumer<ViewsProvider>(
    builder: (context, views, child) => Padding(
          padding: itemPadding(right: true),
          child: AppButton(
            onPressed: views.noteView == type ? null : () => views.setNotesView(type),
            noStyling: true,
            borderRadius: borderRadiusCrazy,
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(width: 2, color: views.noteView == type ? styler.accent : transparent))),
              child: AppText(text: label),
            ),
          ),
        ));
