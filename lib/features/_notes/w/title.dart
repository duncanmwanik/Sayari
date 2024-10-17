import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../_helpers/extentions/strings.dart';
import '../../../_helpers/ui.dart';
import '../../../_models/item.dart';
import '../../../_providers/_providers.dart';
import '../../../_widgets/forms/input.dart';

class NoteTitle extends StatelessWidget {
  const NoteTitle({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    return DataInput(
      hintText: 'Title ',
      initialValue: item.isNew() ? null : item.title(),
      onChanged: (value) {
        state.input.update('t', value.trim());
        setWindowTitle((value.trim().isNotEmpty ? value : 'Untitled').cap());
      },
      onFieldSubmitted: (_) => state.quill.controller.moveCursorToEnd(),
      fontSize: 2.5.h,
      weight: FontWeight.bold,
      textCapitalization: TextCapitalization.sentences,
      filled: false,
      autofocus: item.isNew(),
      contentPadding: EdgeInsets.zero,
    );
  }
}
