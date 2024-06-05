import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

import '../../../_models/item.dart';
import '../../../_providers/providers.dart';
import 'quill_configs/editor.dart';

class NoteTextOverview extends StatelessWidget {
  const NoteTextOverview({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: QuillEditor.basic(
        configurations: QuillEditorConfigurations(
          controller: QuillController(
            document: Document.fromJson(jsonDecode(item.content())),
            selection: TextSelection.collapsed(offset: 0),
          ),
          maxHeight: state.views.isColumn() ? 300 : 200,
          customStyles: getQuillEditorStyle(isOverview: true, bgColor: item.color()),
        ),
      ),
    );
  }
}
