import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

import '../../../__styling/spacing.dart';
import '../../../_providers/_providers.dart';
import '../../../_widgets/others/others/divider.dart';

class QuillEmbedDivider extends CustomBlockEmbed {
  QuillEmbedDivider(String data) : super(noteType, data);
  static String noteType = 'divider';
}

class QuillEmbedDividerBuilder extends EmbedBuilder {
  QuillEmbedDividerBuilder({required this.addQuillEmbedDividerBlock});

  Future<void> Function() addQuillEmbedDividerBlock;

  @override
  String get key => 'divider';

  @override
  Widget build(BuildContext context, QuillController controller, Embed node, bool readOnly, bool inline, TextStyle textStyle) {
    // String type = splitList(QuillEmbedDivider(node.value.data).data ?? '')[0];
    // String color = splitList(QuillEmbedDivider(node.value.data).data ?? '')[1];

    return AppDivider(height: tinyHeight());
  }
}

Future<void> addQuillEmbedDividerBlock() async {
  final block = BlockEmbed.custom(QuillEmbedDivider('0,0'));
  final index = state.quill.controller.selection.baseOffset;
  final length = state.quill.controller.selection.extentOffset - index;
  state.quill.controller.replaceText(index, length, block, null);
}
