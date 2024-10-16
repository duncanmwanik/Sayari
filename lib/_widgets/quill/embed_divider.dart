import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

import '../../_providers/_providers.dart';
import '../../_theme/spacing.dart';
import '../../_variables/colors.dart';
import '../menu/menu.dart';
import '../others/color_menu.dart';
import '../others/others/divider.dart';

class QuillEmbedDivider extends CustomBlockEmbed {
  QuillEmbedDivider(String data) : super(dividerType, data);
  static String dividerType = 'divider';
}

class QuillEmbedDividerBuilder extends EmbedBuilder {
  QuillEmbedDividerBuilder({required this.addQuillEmbedDividerBlock});

  Future<void> Function() addQuillEmbedDividerBlock;

  @override
  String get key => 'divider';

  @override
  Widget build(BuildContext context, QuillController controller, Embed node, bool readOnly, bool inline, TextStyle textStyle) {
    // String type = node.value.data[0];
    String color = node.value.data[1];

    return AppDivider(
      height: tinyHeight(),
      color: color != 'x' ? backgroundColors[color]!.color : null,
    );
  }
}

Future<void> addQuillEmbedDividerBlock() async {
  final index = state.quill.controller.selection.baseOffset;
  final length = state.quill.controller.selection.extentOffset - index;

  showAppMenu(
    Offset.zero,
    colorMenu(
      title: 'Add Divider',
      showRemove: false,
      onSelect: (newColor) => state.quill.controller.replaceText(
        index,
        length,
        BlockEmbed.custom(QuillEmbedDivider('0,$newColor')),
        null,
      ),
    ),
  );
}
